
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'
            

; export symbols
            XDEF _Startup, main, _RX
            
            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack

			ORG $0060
			
			Message: DS.B 100
			
			Count: DS.B 1
			ORG $E000

main:
_Startup:
            LDHX   #__SEG_END_SSTACK ; initialize the stack pointer
            TXS
            
			;kill watchdog
            LDA #%00000011
            STA SOPT1
            
			;set every sci option to default operation
            LDA #%00000000
            STA SCIC1
            
			;enable receiver interrupt, idle line interrupt, transmitter, and receiver
            LDA #%00111100
            STA SCIC2
            
			;set sci options to default operations
            LDA #%00000000
            STA SCIC3

			;set baud rate modulo divisor to correctly communicate with serial port
            LDA #$00
            STA SCIBDH
			
            LDA #$1A
            STA SCIBDL
            MOV #0, Count
            
			;clear the H and x register to be used for indexing
			CLRH
            CLRX
			CLI			; enable interrupts

;mainloop to branch indefinitely			
mainLoop:
            BRA    mainLoop

;send loop that sends the characters stored in memory, first clear count and the x register 
GetYourSendOn:
	CLRX
	MOV #0, Count

;loop that actually displays the characters
Awesome:
	LDX Count
	LDA Message, X
	CBEQA #$21, mainLoop
	STA SCID
	BSET 5, SCIS1
	INCX
	STX Count
	BRA Awesome

	;recieve interrupt to be entered when scid is read from
_RX:

	LDX Count
	LDA SCID
	STA Message, X
	CBEQA #$21, GetYourSendOn
	INCX
	STX Count
	BSET 5, SCIS1
	LDA SCID
	RTI


