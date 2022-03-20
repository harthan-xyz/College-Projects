;Main.s by Alex Hellenberg and Josh Harthan
;9/13/18
;Program to toggle LEDs 1 and 2 at around 1-5 Hz
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEG_END_STACK 
	
	main:
	_Startup:
			BSET 6, PTBDD ;Setting output for LED 1
			BSET 7, PTBDD ;Setting output for LED 2
			LDA #255 ;Load 255 to accumulator to later be decremented and stored in 73
		
	mainLoop:
	;nested loops to decrement values 255*255 times
	delay:
	
			DECA ; decrement value stored in accumulator by 1
			STA $73 ;store decremented value into 73
			LDA #255 ;load value of 255 into accumulator to be stored into different address of memory 73
	nest:
			DECA ;decrement value stored in accumulator by 1
			STA $74 ;store nested decremented value into 74
			BNE nest ;Loops nest until decrement puts Z flag to 1 on address
			LDA $73 ;load accumulator value stored on 73 to later be decremented by loop
			BNE delay ;Loops delay until decrement puts Z flag to 1 on address 73
			
			;MOV #15, $73
			;LDA #3
			
			;BRA mainLoop
			
			;ADC #250
			;STA $73
			;BCS delay

	toggle:	;Toggles LEDs using EOR
			LDA PTBD 
			EOR #$C0
			STA PTBD ;stores values into PTBD
			LDA #255 ;load value of 255 into accumulator to be stored in memory and create a loop
			BRA delay ;Branches always to delay to toggle on and off


