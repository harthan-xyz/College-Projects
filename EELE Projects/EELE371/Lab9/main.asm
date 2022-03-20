;Main.s by Josh Harthan
;11/8/18
;Program to press a button and have the LEDs flash at different frequencies.
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XDEF _Interrupt
	XREF __SEG_END_STACK
    
	ORG $0060
keypress DS.B 1 ;keypress defined in memory
	ORG $E000
    
 	main:
    
	_Startup:
   	 LDA SOPT1 ;disable the watchdog
   	 AND #$7F
   	 STA SOPT1
   	 
   	 BSET 6, PTBDD ;set ports 6 and 7 (LEDs) as outputs
   	 BSET 7, PTBDD
   	 
   	 BCLR 2, PTADD ;set ports 2 and 3 (switches) as inputs
   	 BCLR 3, PTADD
   	 
   	 LDA #%0000000 ;disable PTAPE register
   	 STA PTAPE
   	 
   	 BCLR 2, KBIES ;set ports 2 and 3 to be falling edge sensitive
   	 BCLR 3, KBIES
   	 
   	 BSET 2, KBIPE ;enable pins 2 and 3 as keyboard interrupts
   	 BSET 3,    KBIPE
   	 
   	 BSET 1, KBISC ;enable keyboard interrupt
   	 
   	 CLI ;enable interrupts

    mainLoop:
    
    ;press loop to determine which loop to go to
    press:
   	 LDA keypress
   	 AND $#FE
   	 BEQ key1
   	 BNE key2
    
    key1:
   	 ;load a value of 255 to flash at a certain frequency
   	 LDA #255
   	 BRA delay1
   	 
    key2:
   	 ;load a value of 255 to flash at a slower frequency
   	 LDA #255
   	 BRA delay2
    
    delay1:
    	DECA ; decrement value stored in accumulator by 1
    	STA $73 ;store decremented value into 73
    	LDA #255 ;load value of 255 into accumulator to be stored into different address of memory 73

	delay2:
    	DECA ;decrement value stored in accumulator by 1
    	STA $74 ;store nested decremented value into 74
    	BNE delay2 ;Loops nest until decrement puts Z flag to 1 on address
    	LDA $73 ;load accumulator value stored on 73 to later be decremented by loop
    	BNE delay1 ;Loops delay until decrement puts Z flag to 1 on address 73
       				 
    toggle:    
   	 ;Toggles LEDs using EOR
    	LDA PTBD
    	EOR #$C0
    	STA PTBD ;stores values into PTBD
    	LDA #255 ;load value of 255 into accumulator to be stored in memory and create a loop
    	BRA delay1 ;Branches always to delay to toggle on and off
    
    ;interrupt loop
    _Interrupt:
   	 LDA PTAD ;read porta
   	 STA keypress ;store into keypress
   	 BSET 2, KBISC ;clear keyboard interrupt
   	 RTI ;return from interrupt
   	 
    


