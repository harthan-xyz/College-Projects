;Main.s by Josh Freund, Josh Harthan
;1/15/19
		INCLUDE 'derivative.inc'
		XDEF _Startup, main, LetsFlash
		XREF __SEG_END_SSTACK	
	

;counter variable defined in memory	
		ORG	$0060
Counter DS.B 1
		ORG $E000
	
		
main:

_Startup:

	LDA SOPT1			;kill watchdog
	AND #$7F
	STA SOPT1


	BSET 6, PTBDD		;set LED1 as output
	
	BSET 6, PTBD		;initialize LED1 off
	
	LDA #$4A			;set up the pwm mode, input clock, prescaler and enables the timer overflow interrupt in the tpmsc register
	STA TPMSC
	
	LDA #$4E ;load up the values for a period of 20 msec
	STA TPMMODH
	LDA #$20
	STA TPMMODL
	
	LDA #$05 ;set up the values for a pulse width of 1.5 msec
	STA TPMC0VH
	LDA #$DC
	STA TPMC0VL	
	
	;load up a value of 255 into a memory location 
	LDA #$FF
	STA $70
	STA $71
	
	MOV #0, Counter
	
	CLI					;clears interrupt flag, enables interrupt	
	
	
mainLoop:
	;compares the value of counter and determines if equivalent to value of 50; if equvalent branch to flash	
	LDA Counter
	CMP #50 
	BEQ flash
	
	BRA mainLoop ;branch to mainloop to loop indefinitely


flash:
	;flash function that loads up the ptbd register, and exclusive ors the register in order to flash it
	LDA PTBD
	EOR #$FF
	STA PTBD
	
	;returns to mainloop after execution to loop indefinitely
	MOV #0, Counter
	BRA mainLoop

timer1: 
	;innermost loop that loads up a memory location with a value of 255 stored, decrements this value, and branches to next loop if not equivalent to 0
	LDA $70 
	DECA
	STA $70
	BNE timer2
	
	BRA mainLoop
	
	
timer2:
	;nops to fine tune frequency required 
	NOP
	NOP
	NOP
	
	;inner loop that loads up a memory location with a value of 255 stored, decrements this value, and branches to next loop if not equivalent to 0
	LDA $71 
	DECA
	STA $71
	BNE timer3
	
	;when done, branch back to inner loop
	BRA timer1

timer3:
	;outermost loop that loads up a memory location with a value of 255 stored, decrements this value, and branches to next loop if not equivalent to 0
	LDA $72 
	DECA
	STA $72
	BNE timer3
	LDX #4
	STX $72

	;when done, branch back to inner loop
	BRA timer2


LetsFlash:
	;interrupt that increments the counter variable everytime the program enters the interrupt
	BCLR 7, TPMSC
	LDA Counter
	INCA
	STA Counter
	
	RTI
	
	
