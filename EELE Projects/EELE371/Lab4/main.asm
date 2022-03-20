;Main.s by Josh Harthan
;9/27/18
;Program to toggle LED 1 at around 1-5 Hz and LED 2 at around 1/255 of that
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEG_END_STACK
    
;initialize variables pointing to values of memory
MEM1 EQU $0101
MEM2 EQU $0102
MEM3 EQU $0103
    
	main:
	_Startup:
        	BSET 6, PTBDD ;setting output for LED 1
        	BSET 7, PTBDD ;setting output for LED 2
        	LDA SOPT1 ;load up the SOPT1 register
        	AND #$7F ;and value of SOPT1 by 0111 1111
        	STA SOPT1 ;store the and value into SOPT1 to  turn off watchdog
   	 
	mainLoop:
		 
   		 LDA #255     ;load up a value of 255 into the accumulator
    
	delay:
        	LDA MEM1     ;load up the memory location of variable mem1
        	DECA    	 ;decrement value stored in accumulator by 1
        	STA MEM1     ;store decremented value into variable mem1
        	BEQ toggle     ;branch to toggle if z flag is thrown
                  	 
        	LDA PTBD;     ;load up the PTBD register into the accumulator
        	EOR #$40     ;exclusive or to toggle only the value of LED1
        	STA PTBD    ;stores this value into PTBD
       	 
        	LDA #255     ;load value of 255 into accumulator to be stored into different address mem2
   	   		   	 
    delay2:
   		 LDA MEM2     ;load up the memory location of variable mem2 into the accumulator
  			 DECA    	 ;decrement value stored in the accumulator by 1
        	STA MEM2     ;store decremented value into variable mem2
   		 BEQ delay    ;branch to delay if z flag is thrown to keep looping until not thrown
   		 LDA #255    ;load up a value of 255 into the accumulator
    
    delay3:
   		 LDA MEM3    ;load up the memory location of variable mem3 into the accumulator
  			 DECA    	 ;decrement value stored in accumulator by 1
        	STA MEM3     ;store decremented value into variable address mem3    
   		 BNE delay3    ;branch if the z flag is not thrown, to keep looping until flag is set
   		 BRA delay2    ;branch back to delay2 if flag is set
    
	toggle:    
   		 ;Toggles LED1 using EOR
        	LDA PTBD;
        	EOR #$80    ;exclusive or to toggle only the value of LED2
        	STA PTBD    ;stores values into PTBD
       	 
        	BRA delay     ;branch back to delay to keep looping the program
