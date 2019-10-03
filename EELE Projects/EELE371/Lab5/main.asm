;Main.s by Josh Harthan
;10/4/18
;Program to manipulate certain places of memory, and to copy a string from ROM to RAM
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEG_END_STACK
      
      ORG $0060 ;point to beginning of RAM to store following values
DATA1 DC.B 5 ;define a constant of 5 bytes in RAM
DATA2 DC.B 2 ;define a constant of 2 bytes in RAM
VAR1 EQU $12 ;variable to be decremented to 0 once the word is written to data location
 
BUFFER1 DS.B 16 ;reserve storage space for 16 continuous bytes in memory for the 4 buffers
BUFFER2 DS.B 16
BUFFER3 DS.B 16
BUFFER4 DS.B 16
   	 
   	 ORG    $E000 ;point to beginning of ROM
   	 ;declare the string 'Hello World'
STRING1 DC.B 'Hello World'

	main:
	_Startup:
    
	mainLoop:
   	 LDA DATA1 ;load up value of data1 into the accumulator
   	 LDX DATA2 ;load up value of data2 into x register
   	 MUL ;multiply data1 by data 2, store in accumulator
   	 STA BUFFER1 ;store this value of the accumulator into buffer1 memory location
   	 LDA BUFFER1 ;load the value at buffer1 into accumulator
   	 LDX DATA2    ;load the value at data2 into x register
   	 MUL ;multiply buffer1 by data2, store in accumulator
   	 STA BUFFER2 ;store multiplie value into buffer2
   	 LDA BUFFER1 ;load the value of buffer1 into the accumulator
   	 EOR BUFFER2 ;exclusive or the value of buffer1 with buffer2
   	 STA BUFFER3 ;store this value into buffer3
   	 CLRH  ;clear registers
     	 LDX $00 ;load a value of 0 into the x register to act as an index
     	 
      
      loop: 	 
   	 LDA STRING1, X ;load up the value of string1 at given index
   	 STA BUFFER4, X ;store this value into buffer4, into RAM
   	 INCX ;increment the value of x
   	 
   	 LDA VAR1 ;load up variable1 to be decremented, act as a counter for the loop
   	 DECA ;decrement the value of var1 once code is ran
   	 STA VAR1 ;store this decremented value into var1
   	 BNE loop ;loop until z-flag is thrown
   	 
   	 BRA mainLoop ;keep running the code


