//Joshua Harthan, Jordan Palmer
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
// Define the register offsets
#define OPERAND_A_OFFSET 0x0
#define OPERAND_B_OFFSET 0x1
#define OPCODE_OFFSET 0x2
#define RESULT_LOW_OFFSET 0x3
#define RESULT_HIGH_OFFSET 0x4
#define STATUS_OFFSET 0x5

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
    // NOTE: QSYS_ALU_0_BASE and QSYS_ALU_0_SPAN come from
    // hps_0_arm_a9_0.h; the names might be different based upon how you
    // named your component in Platform Designer.
    int32_t *alu_base = (int32_t *) mmap(NULL, QSYS_ALU_0_SPAN,
        PROT_READ | PROT_WRITE,MAP_SHARED, devmem_fd, QSYS_ALU_0_BASE);

    // check for errors
    if (alu_base == MAP_FAILED)
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
    int32_t *operand_a = alu_base + OPERAND_A_OFFSET;
	  int32_t *operand_b = alu_base + OPERAND_B_OFFSET;
	  int32_t *opcode = alu_base + OPCODE_OFFSET;
	  int32_t *result_low = alu_base + RESULT_LOW_OFFSET;
	  int32_t *result_high = alu_base + RESULT_HIGH_OFFSET;
	  int32_t *status = alu_base + STATUS_OFFSET;

    /* display each case result, the format is as follows:
	Case being presented
	IRV: R0(dec) R1(dec) R2(hex) R4(hex) R3(hex) R4+R3(dec) R5(hex)
	ABW: R0(dec) R1(dec) R2(hex) R4(hex) R3(hex) R4+R3(dec) R5(hex)
	OPW: R0(dec) R1(dec) R2(hex) R4(hex) R3(hex) R4+R3(dec) R5(hex)

	IRV = Initial Register Values
	ABW = Register values after operands A and B are written
	OPW = Final Register Values (after opcode write to register 2)
	R4+R3 = 64-bit result value
	*/

  //initialize registers to zero values
  *operand_a = 0x0;
  *operand_b = 0x0;
  *opcode = 0x0;

signal(SIGINT, interrupt_handler); //catch the interrupt signal
while (!interrupted)
{
// Case 1 R = A + B, A = 100 B = 100
printf("****************************\n");
printf("Case 1\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %d\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,*result_low,*status);
//write values to registers A and B
*operand_a = 0x64; // A = 100
*operand_b = 0x64; // B = 100
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %d\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,*result_low,*status);
//write to the opcode register
*opcode = 0x1; // Opcode = 001
int64_t result1 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result1,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 2 R = A + B, A = 100 B = -100
printf("****************************\n");
printf("Case 2\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result1,*status);
//write values to registers A and B
*operand_a = 0x64; // A = 100
*operand_b = -0x64; // B = -100
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result1,*status);
//write to the opcode register
*opcode = 0x1; // Opcode = 001
int64_t result2 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result2,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 3 R = A + B, A = 0x7FFFFFFF B = 1
printf("****************************\n");
printf("Case 3\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result2,*status);
//write values to registers A and B
*operand_a = 0x7FFFFFFF; // A = 0x7FFFFFFF
*operand_b = 0x1; // B = 1
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result2,*status);
//write to the opcode register
*opcode = 0x1; // Opcode = 001
int64_t result3 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,-result3,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 4 R = A - B, A = 1000 B = 1000
printf("****************************\n");
printf("Case 4\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,-result3,*status);
//write values to registers A and B
*operand_a = 0x3E8; // A = 1000
*operand_b = 0x3E8; // B = 1000
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,-result3,*status);
//write to the opcode register
*opcode = 0x2; // Opcode = 010
int64_t result4 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result4,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 5 R = A - B, A = 1000 B = 5000
printf("****************************\n");
printf("Case 5\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result4,*status);
//write values to registers A and B
*operand_a = 0x3E8; // A = 1000
*operand_b = 0x1388; // B = 5000
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result4,*status);
//write to the opcode register
*opcode = 0x2; // Opcode = 010
int64_t result5 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result5,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 6 R = A - B, A = 0x80000000 B = 1
printf("****************************\n");
printf("Case 6\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result5,*status);
//write values to registers A and B
*operand_a = 0x80000000; // A = 0x80000000
*operand_b = 0x1; // B = 1
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result5,*status);
//write to the opcode register
*opcode = 0x2; // Opcode = 010
int64_t result6 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result6,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 7 R = A * B, A = 0x0FFFFFFF B = 0x0FFFFFFF
printf("****************************\n");
printf("Case 7\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result6,*status);
//write values to registers A and B
*operand_a = 0x0FFFFFFF; // A = 0x0FFFFFFF
*operand_b = 0x0FFFFFFF; // B = 0x0FFFFFFF
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result6,*status);
//write to the opcode register
*opcode = 0x3; // Opcode = 011
int64_t result7 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result7,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 8 R = A * B, A = 7000 B = -500
printf("****************************\n");
printf("Case 8\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result7,*status);
//write values to registers A and B
*operand_a = 0x1B58; // A = 7000
*operand_b = -0x1F4; // B = -500
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result7,*status);
//write to the opcode register
*opcode = 0x3; // Opcode = 011
int64_t result8 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result8,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 9 R = A * B, A = 7000 B = 0
printf("****************************\n");
printf("Case 9\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result8,*status);
//write values to registers A and B
*operand_a = 0x1B58; // A = 7000
*operand_b = 0x0; // B = 0
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result8,*status);
//write to the opcode register
*opcode = 0x3; // Opcode = 011
int64_t result9 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result9,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 10 R = B - 1, B = 16
printf("****************************\n");
printf("Case 10\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result9,*status);
//write values to register B
*operand_b = 0x10; // B = 16
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result9,*status);
//write to the opcode register
*opcode = 0x4; // Opcode = 100
int64_t result10 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result10,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 11 R = B - 1, B = 0x80000000
printf("****************************\n");
printf("Case 11\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result10,*status);
//write values to register B
*operand_b = 0x80000000; // B = 0x80000000
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result10,*status);
//write to the opcode register
*opcode = 0x4; // Opcode = 100
int64_t result11 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result11,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 12 R = B - 1, B = 0
printf("****************************\n");
printf("Case 12\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result11,*status);
//write values to register B
*operand_b = 0; // B = 0
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result11,*status);
//write to the opcode register
*opcode = 0x4; // Opcode = 100
int64_t result12 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result12,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 13 R = A, B = 5
printf("****************************\n");
printf("Case 13\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result12,*status);
//write values to register A
*operand_a = 0x5; // A = 5
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result12,*status);
//write to the opcode register
*opcode = 0x5; // Opcode = 101
int64_t result13 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result13,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 14 R = A, B = 0
printf("****************************\n");
printf("Case 14\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result13,*status);
//write values to register A
*operand_a = 0x0; // A = 0
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result13,*status);
//write to the opcode register
*opcode = 0x5; // Opcode = 101
int64_t result14 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result14,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Case 15 R = A, B = -5
printf("****************************\n");
printf("Case 15\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result14,*status);
//write values to register A
*operand_a = -0x5; // A = 5
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result14,*status);
//write to the opcode register
*opcode = 0x5; // Opcode = 101
int64_t result15 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result15,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Case 16 A <-> B, A = -1 B = 0
printf("****************************\n");
printf("Case 16\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result15,*status);
//write values to registers A and B
*operand_a = -0x1; // A = -1
*operand_b = 0x0; // B = 0
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result15,*status);
//write to the opcode register
*opcode = 0x6; // Opcode = 110
//int64_t result16 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_b, *operand_a,*opcode,*result_high,*result_low,result15,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Case 17 R = A OR B, A = 0x0 B = 0x0
printf("****************************\n");
printf("Case 17\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_b, *operand_a,*opcode,*result_high,*result_low,result15,*status);
//write values to registers A and B
*operand_a = 0x0; // A = 0
*operand_b = 0x0; // B = 0
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result15,*status);
//write to the opcode register
*opcode = 0x7; // Opcode = 111
int64_t result17 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result17,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Case 18 R = A OR B, A = 0x0F0F0F0F B = 0x01010101
printf("****************************\n");
printf("Case 18\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_b, *operand_a,*opcode,*result_high,*result_low,result17,*status);
//write values to registers A and B
*operand_a = 0x0F0F0F0F; // A = 0x0F0F0F0F
*operand_b = 0x01010101; // B = 0x01010101
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result17,*status);
//write to the opcode register
*opcode = 0x7; // Opcode = 111
int64_t result18 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result18,*status);
getchar();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Case 19 R = A OR B, A = 0xFFFFFFFF B = 0x0;
printf("****************************\n");
printf("Case 19\t R0\t R1\t R2\t R4\t\t R3\t\t R4+3\t R5\n");
printf("IRV:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result18,*status);
//write values to registers A and B
*operand_a = 0xFFFFFFFF; // A = 0xFFFFFFFF
*operand_b = 0x0; // B = 0
printf("ABW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result18,*status);
//write to the opcode register
*opcode = 0x7; // Opcode = 111
int64_t result19 = (int64_t) *result_high << 32 | (int64_t ) *result_low;
printf("OPW:\t %d\t %d\t 0x%01x\t 0x%08x\t 0x%08x\t %lld\t 0x%01x\n",*operand_a, *operand_b,*opcode,*result_high,*result_low,result19,*status);
getchar();
}

    // unmap our custom component
    int result = munmap(alu_base, QSYS_ALU_0_SPAN);

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
