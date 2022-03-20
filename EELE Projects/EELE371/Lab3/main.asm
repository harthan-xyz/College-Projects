;Main.s by Alex Hellenberg and Josh Harthan
;9/20/18
;Simple program to toggle the LED1 on the MC9S08QG8
	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEG_END_STACK ;symbol defined by the linker for the end of the stack
	
TEMP EQU $0075 ;Address of start location of RAM
TEMP1 EQU $0076
TEMP2 EQU $0077
	main:
	_Startup:

	mainLoop:
		;MOV #18, TEMP
		;LDA TEMP
		;STA $60
		;LDHX #$01FF
		;STHX TEMP1
		CLRH
		LDX #$60
		MOV #02, TEMP2
		MOV #07, TEMP
	ramLoop:
		LDA TEMP
		MOV TEMP2, X+
		LSL TEMP2
		DECA
		STA TEMP
		BNE ramLoop
		BRA mainLoop

