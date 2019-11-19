#include <stdio.h>
#include <sys/mman.h>   // mmap functions
#include <unistd.h>     // POSIX API
#include <errno.h>      // error numbers
#include <stdlib.h>     // exit function
#include <stdint.h>     // type definitions
#include <fcntl.h>      // file control
#include <signal.h>     // catch ctrl-c interrupt signal from parent process
#include <stdbool.h>    // boolean types

#include <hps_0_arm_a9_0.h> // Platform Designer components addresses

/**********************
* Register offsets
***********************/
/* Remember that each register is offset from each other by 4 bytes;
   this is different from the vhdl view where each register is offset by 1 word
   when we do the addressing on the avalon bus!
   Also note that your offsets might be different depending on how you assigned
   addresses in your qsys wrapper.

   Here we specify the offsets in words rather than bytes because we type cast
   the base address returned by mmap to a uint32_t*. Thus when we increment that
   pointer by 1, the memory address increments by 4 bytes since that's the size
   of the type the pointer points to.
*/
#define HS_LED_CONTROL_OFFSET 0x0
// Define the other register offsets here 
#define SYS_CLKS_SEC_OFFFSET 0x1
#define LED_REG_OFFSET 0x2
#define BASE_RATE_OFFSET 0x3


// flag to indicate whether or not we've recieved an interrupt signal from the OS
static volatile bool interrupted = false;

// graciously handle interrupt signals from the OS
void interrupt_handler(int sig)
{
    printf("Received interrupt signal. Shutting down...\n");
    interrupted = true;
}


int main()
{
    // open /dev/mem
    int devmem_fd = open("/dev/mem", O_RDWR | O_SYNC);

    // check for errors
    if (devmem_fd < 0)
    {
        // capture the error number
        int err = errno;

        printf("ERROR: couldn't open /dev/mem\n");
        printf("ERRNO: %d\n", err);

        exit(EXIT_FAILURE);
    }

    // map our custom component into virtual memory
    // NOTE: QSYS_LED_CONTROL_0_BASE and QSYS_LED_CONTROL_0_SPAN come from 
    // hps_0_arm_a9_0.h; the names might be different based upon how you 
    // named your component in Platform Designer.
    uint32_t *led_control_base = (uint32_t *) mmap(NULL, QSYS_LED_CONTROL_0_SPAN,
        PROT_READ | PROT_WRITE,MAP_SHARED, devmem_fd, QSYS_LED_CONTROL_0_BASE);

    // check for errors
    if (led_control_base == MAP_FAILED)
    {
        // capture the error number
        int err = errno;

        printf("ERROR: mmap() failed\n");
        printf("ERRNO: %d\n", err);

        // cleanup and exit
        close(devmem_fd);
        exit(EXIT_FAILURE);
    }

    // create pointers for each register
    	uint32_t *hs_led_control = led_control_base + HS_LED_CONTROL_OFFSET;
    // Define the other register pointers here
	uint32_t *sys_clks_sec = led_control_base + SYS_CLKS_SEC_OFFFSET;
	uint32_t *led_reg = led_control_base + LED_REG_OFFSET;
	uint32_t *base_rate = led_control_base + BASE_RATE_OFFSET;
    
    // display each register address and value
    	printf("**************************\n");
    	printf("register addresses\n");
    	printf("**************************\n");
	printf("hs_led_control address: 0x%p\n", hs_led_control);
     // Print the other register addresses here
	printf("**************************\n");
	printf("sys_clks_sec address: 0x%p\n", sys_clks_sec);
	printf("**************************\n");
	printf("led_reg address: 0x%p\n", led_reg);
	printf("**************************\n");
	printf("base_rate address: 0x%p\n", base_rate);
	printf("**************************\n");
    	printf("**************************\n");
    	printf("register values\n");
    	printf("**************************\n");
    	printf("hs_led_control: 0x%08x\n", *hs_led_control);
     // Print the other register values here
	printf("**************************\n");
	printf("sys_clks_sec : 0x%08x\n", *sys_clks_sec);
	printf("**************************\n");
	printf("led_reg : 0x%08x\n", *led_reg);
	printf("**************************\n");
	printf("base_rate : 0x%08x\n", *base_rate);
	printf("**************************\n");
    
    // set the component into software control mode
    *hs_led_control = 1;

    // clear all of the LEDs
    *led_reg = 0;

    /* run a pattern on the LEDS until we are interrupted with a SIGINT signal.
       The pattern "fills" the LEDS from right to left, i.e.
        00011000
        00111100
        01111110
        11111111
        01111110
        00111100
        00011000
        ... repeat
       where 0 indicates off and 1 indicates on. This pattern repeats.
       Sleep for 0.1 seconds between each pattern-step with usleep(0.1*1e6)

       Extra credit will be given to the most concise (in number of lines)
       pattern logic implementation.
       */
	      
    signal(SIGINT, interrupt_handler); // catch the interrupt signal
    while(!interrupted)
    {
        // pattern logic goes here...
		*led_reg = 0x18; //00011000
       		 usleep(0.1*1e6); 
		*led_reg = 0x3C; //00111100
		usleep(0.1*1e6);
		*led_reg = 0x7E; //01111110
		usleep(0.1*1e6);
		*led_reg = 0xFF;  //11111111
		usleep(0.1*1e6);
		*led_reg = 0x7E; //01111110
		usleep(0.1*1e6);
		*led_reg = 0x3C; //00111100
		usleep(0.1*1e6);	
    }

    // set the component back into hardware control mode
    *hs_led_control = 0;

    // unmap our custom component
    int result = munmap(led_control_base, QSYS_LED_CONTROL_0_SPAN);

    // check for errors
    if (result < 0)
    {
        // capture the error number
        int err = errno;

        printf("ERROR: munmap() failed\n");
        printf("ERRNO: %d\n", err);

        //cleanup and exit
        close(devmem_fd);
        exit(EXIT_FAILURE);
    }

    // close /dev/mem
    close(devmem_fd);

    return 0;
}
