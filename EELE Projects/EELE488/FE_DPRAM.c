#include <linux/init.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/io.h>
#include <linux/hdreg.h>
#include <linux/ioctl.h>
#include <linux/fs.h>
#include <linux/types.h>
#include <linux/uaccess.h>
#include <linux/of.h>
#include <linux/timer.h>
#include <linux/genhd.h>
#include <linux/blkdev.h>
#include <linux/bio.h>
#include "custom_functions.h"

/* File header necessary for kernel compilation */
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Joshua Harhtan");
MODULE_DESCRIPTION("Loadable kernel module for the Flat Earth Dual Port RAM component");
MODULE_VERSION("1.0");

/* Set the number of sectors (2*KERNEL_SECTOR_SIZE) */
int major_num = 0;
module_param(major_num, int, 0); 
int hardsect_size = 512;
module_param(hardsect_size, int, 0); 
int nsectors = 2048;
module_param(nsectors, int, 0);

/* Set the constant for the kernel sector size, major number and name, and minor numbers */
#define KERNEL_SECTOR_SIZE 512 // Indicates to the kernel the size of the kernel sector 
#define FE_DPRAM_MAJOR 0 // Major number of zero indicates that the kernel will dyanamically allocate the major number
#define FE_DPRAM_MINORS 1 // Minor number of one indicates the device is non-partitionable
#define MAJOR_NAME "DPRAM" // The major name to appear in list of devices

/* Function Prototypes for disk initialization */
int register_blkdev(unsigned int major, const char *name); //register and unregister the block deice
void unregister_blkdev(unsigned int major, const char *name);
struct request_queue *blk_init_queue(request_fn_proc *request, spinlock_t *lock); //request is the request function, lock is an optional spinlock to protect queue from concurrent access
struct request *elv_next_request(struct request_queue *queue);
void del_gendisk(struct gendisk *gd); //unregister the disk
void blk_cleanup_queue(struct request_queue *q); //free the request queue
void put_disk(struct gendisk *disk); //drop the reference taken in alloc_disk()
static void set_capacity(struct gendisk *disk, sector_t size); //size is a number of 512-byte sectors, sector_t is 64 or 32 based of 64 or 32 bit architectures, respectively
static void add_disk(struct gendisk *gd); //driver must be able to handle I/O requests before calling this function, adds the gendisk structure to the system
static int fe_DPRAM_open(struct block_device *bdev, fmode_t mode); //lock and unlock the device
static void fe_DPRAM_release(struct gendisk *gd, fmode_t mode);
static int fe_DPRAM_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd, unsigned long arg); // I/O control for custom component 
/* End of function protypes for disk initialization */

/* FPGA device functions */
static ssize_t system_enable_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count);
static ssize_t system_enable_read  (struct device *dev, struct device_attribute *attr, char *buf);
static ssize_t preset_sel_write (struct device *dev, struct device_attribute *attr, const char *buf, size_t count);
static ssize_t preset_sel_read  (struct device *dev, struct device_attribute *attr, char *buf);
/* End of FPGA device functions */

/* Write the device attributes */
DEVICE_ATTR(system_enable, 0664, system_enable_read, system_enable_write);
DEVICE_ATTR(preset_sel, 0664, preset_sel_read, preset_sel_write);
/* End of device attributes */

/* Fixed point number structure */
struct fixed_num {
  int integer;
  int fraction;
  int fraction_len;
};
/* End of fixed point struct */

/* Device structure */
typedef struct fe_DPRAM_dev fe_DPRAM_dev_t;
struct fe_DPRAM_dev {
	int size; 			// device size in vectors
	u8 *data; 			// the data array 
	short users;			// # of users
	spinlock_t lock;		// mutual exclusion
	struct request_queue *queue;	// device request queue	
	struct gendisk *gd;		// gendisk struct
	struct timer_list timer;        // media change timer
	void __iomem *regs;		// pointer to the device's register
	int system_enable;	
	int preset_sel;
} device; 
/* End of device struct */

/* Block dev ops struct */
static const struct block_device_operations fe_DPRAM_ops = {
   .owner = THIS_MODULE,
   .open = fe_DPRAM_open,
   .release = fe_DPRAM_release,
   .ioctl = fe_DPRAM_ioctl
};
/* End of block dev ops struct */

/* Beginning of data transfer function */
static void fe_DPRAM_transfer(struct fe_DPRAM_dev *dev, unsigned long sector, unsigned long nsect, char *buffer, int write){
        unsigned long offset = sector*KERNEL_SECTOR_SIZE;
        unsigned long nbytes = nsect*KERNEL_SECTOR_SIZE;

	pr_info("The driver has entered the transfer function.\n");

        if((offset + nbytes) > device.size){
                printk(KERN_NOTICE "Beyond-end write (%ld %ld)\n",offset, nbytes);
                return;
        }
        if (write)
                memcpy(device.data + offset, buffer, nbytes);
        else
                memcpy(buffer, device.data + offset, nbytes);    

	pr_info("The driver has exited the transfer function.\n");
};
/* End of data transfer data function */

/* Request Function */
static void fe_DPRAM_request(struct request_queue *q){
        struct request *req;

	pr_info("The driver has entered the request function.\n");

	while (1) {
		req = blk_fetch_request(q);
		if(req == NULL){
			break;
      		}

		if(blk_rq_is_passthrough(req)){
			printk(KERN_NOTICE "Skip non-fs request\n");
			__blk_end_request_all(req, -EIO);
			continue;
		}
	      fe_DPRAM_transfer(&device, req->__sector, req->__data_len, bio_data(req->bio), rq_data_dir(req));
	      __blk_end_request_cur(req, 0);
	}
	pr_info("The driver has exited the request function.\n");
};
/* End of request function */

/* Open Method */
static int fe_DPRAM_open(struct block_device *bdev, fmode_t mode){
    
        pr_info("The driver has entered the open function.\n");

        del_timer_sync(&device.timer); // once called, delete the 30 sec media removal timer 
        spin_lock(&device.lock); //lock the spinlock AFTER the timer is deleted
        if(!device.users){
                check_disk_change(bdev); // check if a media change has occured
        }
        device.users++; // increment the user count to show how many users are in use of driver
        spin_unlock(&device.lock);
    
        pr_info("The drive has exited the open function.\n");
    
        return 0;
};
/* End of Open Method */

/* Release Method */
static void fe_DPRAM_release(struct gendisk *gd, fmode_t mode){
    
        pr_info("The driver has entered the release function.\n");
    
        spin_lock(&device.lock);
        device.users--; // decrement the user count to update the number of users using the device
        spin_unlock(&device.lock);

        pr_info("The driver has exited the release function.\n");

        return; 
};
/* End of Release Method */

/* Generic I/O Control Method */
static int fe_DPRAM_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd, unsigned long args){
        long size;
        struct hd_geometry geo;

        pr_info("The driver has entered the IOCTL function.\n");
    
        // Get geometry of the device, arbitrary values input
        switch(cmd){
                case HDIO_GETGEO:
                        size = device.size*(hardsect_size/KERNEL_SECTOR_SIZE);
                        geo.cylinders = (size & ~0x3f) >> 6; //size of device AND w/ 00111111, right shift by 6
                        geo.heads = 2;
                        geo.sectors = 16; 
                        geo.start = 0;
 	if (copy_to_user((void __user *) args, &geo, sizeof(geo))){
                                return -EFAULT;}
                        return 0;
        }

        pr_info("The driver has exited the IOCTL function.\n");

        return -ENOTTY; // unknown command flag thrown
};
/* End of Generic I/O Control Method */

/* Initialize the component */
static int fe_DPRAM_init(void){
        pr_info("\n\nInitializing the Flat Earth DPRAM module:\n");

        int status;

        // Register major number to the block device
        status = register_blkdev(FE_DPRAM_MAJOR, MAJOR_NAME);
        if (FE_DPRAM_MAJOR < 0) {
                printk(KERN_ERR "fe-DPRAM : Unable to register fe_DPRAM device.\n");
                return -EBUSY;
        };
        pr_info("The MAJOR has been successfully registered for the FE DPRAM component!\n");

	pr_info("Begin DPRAM device block creation:\n");

	device.size = nsectors*hardsect_size;
	spin_lock_init(&device.lock); // Initialize the device lock
	pr_info("The size of the device is %d sectors long.\n", device.size);

	device.data = vmalloc(device.size);
	pr_info("The memory for this device has been allocated successfully with vmalloc!\n"); 

	if (device.data == NULL){
		printk(KERN_NOTICE "vmalloc failure\n");
		return -ENOMEM;
	}
	
	pr_info("Device structute successfully initialized!\n");

	/* Create the request queue */
	device.queue = blk_init_queue(fe_DPRAM_request, &device.lock); // fe_DPRAM_request is the request function (that which performs read and write requests); blk_init_queue can fail allocation of memory so caution here
	if(device.queue == NULL){
		return -ENOMEM;
	}
	blk_queue_logical_block_size(device.queue, KERNEL_SECTOR_SIZE);
        device.queue->queuedata = device.queue;
	pr_info("Request queue successfully initialized!\n");

	/* Initialize the gendisk structure */
	device.gd = alloc_disk(FE_DPRAM_MINORS);
	if (!device.gd){
		printk(KERN_NOTICE "alloc_disk failure\n");
		unregister_blkdev(FE_DPRAM_MAJOR, MAJOR_NAME);
		if(device.data){
			vfree(device.data);
			pr_info("The data within the device has been deleted.");
		}
	}
	device.gd->major = FE_DPRAM_MAJOR; // Set the major number of the device	
	device.gd->first_minor = 0; // FE_DPRAM_MINORS is the number of each minors our device can support; 0 would indicate the device as non-partitionable
	device.gd->fops = &fe_DPRAM_ops; // Pointer to the device block_device_operations structure of the device
	device.gd->queue = device.queue; // Put the gendisk queue as the device queue
	device.gd->private_data = &device; // Pointer to gendisk specific data structure
	snprintf(device.gd->disk_name, 32, "fe_DPRAM"); // print the gendisk name to buffer
	set_capacity(device.gd, nsectors*(hardsect_size/KERNEL_SECTOR_SIZE)); // KERNEL_SECTOR_SIZE is a locally defined constant as the kernel's 512-byte sectors 	
	
	pr_info("Gendisk structure successfully initialized!\n");
	
	add_disk(device.gd); // Add the gendisk structure 

        pr_info("Flat Earth DPRAM module successfully initialized!\n");
        return 0;
};        
/* End of initialization */

/* FPGA ReadWrite functions */
static ssize_t system_enable_read(struct device *dev, struct device_attribute *attr, char *buf) {
  fe_DPRAM_dev_t *devp = (fe_DPRAM_dev_t *)dev_get_drvdata(dev);
  fp_to_string(buf, devp->system_enable, 28, true, 9);
  strcat2(buf,"\n");
  return strlen(buf);
};

static ssize_t system_enable_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count) {
  uint32_t tempValue = 0;
  char substring[80];
  int substring_count = 0;
  int i;
  fe_DPRAM_dev_t *devp = (fe_DPRAM_dev_t *)dev_get_drvdata(dev);
  for (i = 0; i < count; i++) {
    if ((buf[i] != ',') && (buf[i] != ' ') && (buf[i] != '\0') && (buf[i] != '\r') && (buf[i] != '\n')) {
      substring[substring_count] = buf[i];
      substring_count ++;
    }
  }
  substring[substring_count] = 0;
  tempValue = set_fixed_num(substring, 28, false);
  devp->system_enable = tempValue;
  iowrite32(devp->system_enable, (u32 *)devp->regs + 0);
  return count;
};

static ssize_t preset_sel_read(struct device *dev, struct device_attribute *attr, char *buf) {
  fe_DPRAM_dev_t *devp = (fe_DPRAM_dev_t *)dev_get_drvdata(dev);
  fp_to_string(buf, devp->preset_sel, 28, true, 9);
  strcat2(buf,"\n");
  return strlen(buf);
};

static ssize_t preset_sel_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count) {
  uint32_t tempValue = 0;
  char substring[80];
  int substring_count = 0;
  int i;
  fe_DPRAM_dev_t *devp = (fe_DPRAM_dev_t *)dev_get_drvdata(dev);
  for (i = 0; i < count; i++) {
    if ((buf[i] != ',') && (buf[i] != ' ') && (buf[i] != '\0') && (buf[i] != '\r') && (buf[i] != '\n')) {
      substring[substring_count] = buf[i];
      substring_count ++;
    }
  }
  substring[substring_count] = 0;
  tempValue = set_fixed_num(substring, 28, false);
  devp->preset_sel = tempValue;
  iowrite32(devp->preset_sel, (u32 *)devp->regs + 1);
  return count;
};
/* End of CreateAttrReadWriteFuncs */

/* Exit Function, remove the device */
static void __exit fe_DPRAM_exit(void) {
  pr_info("Flat Earth DPRAM module exit.\n");
  del_gendisk(device.gd); // delete the gendisk, clean up any partitioning information
  put_disk(device.gd); // relsease the gendisk object reference
  unregister_blkdev(FE_DPRAM_MAJOR, MAJOR_NAME); // unregister the block so it no longer takes up a major
  blk_cleanup_queue(device.queue); // delete any request in the device's queue
  vfree(device.data); // free memory space
  pr_info("Flat Earth DPRAM module successfully unregistered!\n");
};
/* End Exit Function */

module_init(fe_DPRAM_init);
module_exit(fe_DPRAM_exit);
