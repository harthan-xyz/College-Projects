;Main.s by Alex Hellenberg and Josh Harthan
;9/6/18
;Simple program to toggle the LED1 on the MC9S08QG8
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEG_END_STACK ;symbol defined by the linker for the end of the stack
	
	main:
	_Startup:
		BSET 6, PTBDD
		BSET 7, PTBDD
	mainLoop:
		LDA PTBD ;Load Accumulator puts the entire PTBD set into the accumulator 
		EOR #$C0 ;Exclusive OR with 1100 0000 so that bits 7 and 6 are OR'd
		STA PTBD ;Stores the value back into memory
		
		BRA mainLoop
