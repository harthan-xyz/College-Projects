;Main.s for Lab5 LCD by Josh Freund, Josh Harthan
;4/23/19
		INCLUDE 'derivative.inc'
		XDEF _Startup, main, Column, _Viic
		XREF __SEG_END_SSTACK	;symbol defined by the linker for the end of the stack
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'
            XDEF _Startup, main, _Viic
            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack

;bits to manipulate LCD registers
E		 EQU 0
RW		 EQU 2
RS		 EQU 1

		ORG $0060
	;variables stored in RAM
	FLAG	DS.B 1 ;flag to be thrown when I2C interrupt is entered
	FULLER  DS.B 1 ;variable to store the full value of the button pressed to be put into the correct register
	UPPER	DS.B 1 ;upper digit of the value pressed
	LOWER	DS.B 1 ;lower digit of the value pressed 
	Counter DS.B 1 ;counter variable to act as an index 
	IIC_addr: DS.B 1 ;address of the I2C message
	msgLength: DS.B 7 ;length of the message sent over I2C in bytes
	current: DS.B 1 ;pointer index that acts as the current position of the array
	IIC_MSG: DS.B 7 ;variable to store the data sent over I2C
	TIME: DS.B 1 ;variable to properly initialize the LCD
			
		ORG $E000	
		
	;messages to be stored in ROM to be displayed on the LCD
	MSG1: DC.B 'Date MM/DD/YY'
		  DC.B 0
	MSG2: DC.B 'Time hh:mm:ss'
		  DC.B 0
	;lookup table to act as indexes of the DS1337 clock registers
	AddressWrite:   DC.B 5, 4, 6, 2, 1, 0	  


	
main:
_Startup:
    LDHX #__SEG_END_SSTACK ;initialize the stack pointer
	TXS
	
	CLI
	
	LDA SOPT1			;kill watchdog
	AND #%00000011
	STA SOPT1
	
	
	LDA #%10000001
	STA SOPT2

	CLR PTAD 	;clears the data
	CLR PTBD	;clears the data
	LDA #$FF	;makes ports outputs
	STA PTADD
	STA PTBDD
	
	BCLR RS, PTAD
	LDA #255		;delay
	STA TIME
	JSR VAR_DELAY
	
	LDA #$38		;display control to initialize the LCD
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	
	;delay
	LDA #200
	STA TIME
	JSR VAR_DELAY
	
	
	LDA #$38
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	
	;delay
	LDA #200
	STA TIME
	JSR VAR_DELAY
	
	LDA #$38
	JSR LCD_WRITE
	
	;show rows
	LDA #$38
	JSR LCD_WRITE
	
	
	;cursor and display
	LDA #$0F
	JSR LCD_WRITE
	
	LDA #%00000010
	JSR LCD_WRITE
	JSR VAR_DELAY
	
	;clear display
	LDA #$01
	JSR LCD_WRITE
	LDA #16
	STA TIME
	JSR VAR_DELAY
	
	;set entry mode - shift right, dont shift display
	LDA #$06
	JSR LCD_WRITE
	CLRH
	CLRX
	JSR MESSAGE1
	CLRH
	CLRX
	MOV #0, Counter
	JSR VAR_DELAY
	
	JSR DebugBounce

	BCLR RS, PTAD
	LDA #%11000000
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD
	
	JSR MESSAGE2	
	
	JSR IIC_Startup_slave	
	
;loop that runs indefinitely until flag set in interrupt is set	
mainLoop:
	LDA FLAG
	CBEQA #1, cool ;if flag is set, start the process
	JSR DebugBounce
	BRA mainLoop
	
;subroutine that clears the LCD display and resets the cursor position
cool:
	JSR DebugBounce

	BCLR RS, PTAD
	LDA #%00000001
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD	
	JSR DebugBounce

	BCLR RS, PTAD
	LDA #%00000010
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD
	JSR DebugBounce
	CLRH
	CLRX
	
;subroutine that splits each data value into two seperate values, and concatenates this value to display the correct ASCII value
cool1:
	LDA #%00110000
	STA UPPER
	
	LDX Counter
	LDX AddressWrite, X
	LDA IIC_MSG, X
	
	LSRA
	LSRA
	LSRA
	LSRA
	STA LOWER

	LDA UPPER
	ADD LOWER
	STA FULLER
	
	JSR DebugBounce
	JSR DebugBounce

	LDA FULLER
	JSR LCD_WRITE
	JSR DebugBounce
	JSR DebugBounce

	
	LDX Counter
	LDX AddressWrite, X
	LDA IIC_MSG, X
	
	AND #%00001111
	STA LOWER
	
	LDA UPPER
	ADD LOWER
	STA FULLER
	
	JSR DebugBounce
	JSR DebugBounce
	LDA FULLER
	JSR LCD_WRITE
	JSR DebugBounce
	JSR DebugBounce
	BRA JUMPO
	
;subroutine to branch back to mainloop, if mainloop is out of range
mainLoop1:
	BRA mainLoop
	
;subroutine that checks if the index of the word is at a value of four, and to increment the index if not
JUMPO:
	LDA Counter
	INCA
	STA Counter
	
	LDA Counter 
	CBEQA #4, NEW

	BRA cool1
	
;loop that converts hex data values into correct corresponding ASCII values 
NEW:
	JSR DebugBounce

	BCLR RS, PTAD
	LDA #%11000000
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD
	JSR DebugBounce

;subroutine that takes each individual digit of the hex data value and concatenates its binary value to display a correct ASCII value
NEW1:

	LDX Counter
	LDX AddressWrite, X
	LDA IIC_MSG, X
	
	LSRA
	LSRA
	LSRA
	LSRA
	STA LOWER

	LDA UPPER
	ADD LOWER
	STA FULLER
	JSR DebugBounce
	JSR DebugBounce

	LDA FULLER
	JSR LCD_WRITE
	JSR DebugBounce
	JSR DebugBounce

	LDX Counter
	LDX AddressWrite, X
	LDA IIC_MSG, X
	
	AND #%00001111
	STA LOWER
	
	LDA UPPER
	ADD LOWER
	STA FULLER
	JSR DebugBounce
	JSR DebugBounce
	
	LDA FULLER
	JSR LCD_WRITE
	JSR DebugBounce
	JSR DebugBounce
	
	LDA Counter
	INCA
	STA Counter
	
	LDA Counter 
	CBEQA #7, INT ;if the lengh of the message is seven, reset the flag as the clock initialization is complete

	BRA NEW1

;rest the Viic flag, and start the program again
INT:
	MOV #0, FLAG
	
	MOV #0, Counter
	BRA mainLoop1

;delay loop	to be jumped to when one is needed
DebugBounce:
	LDA #2
	STA $120
	loop3:
		LDA #25
		STA $121
		loop4:
			LDA $121
			DECA
			STA $121
			BNE loop4
		LDA $120
		DECA
		STA $120
		BNE loop3
	RTS            

;subroutines that display the messages stored in ROM onto the LCD
MESSAGE1:
	LDA #$84
	JSR LCD_ADDR
	CLRX
	JSR VAR_DELAY
	L3:
		LDA MSG1, X
		BEQ OUTMSG1
		JSR LCD_WRITE
		JSR VAR_DELAY
		INCX
		BRA L3
		OUTMSG1:
			RTS
MESSAGE2:
	JSR LCD_ADDR
	CLRX
	JSR VAR_DELAY
	L44:
		LDA MSG2, X
		BEQ OUTMSG2
		JSR LCD_WRITE
		JSR VAR_DELAY
		INCX
		BRA L44
		OUTMSG2:
			RTS
VAR_DELAY:
	LDA #200
	L1: DECA
	BNE L1
	DEC TIME
	BNE VAR_DELAY
	RTS

;write the accumulator value to the LCD register
LCD_WRITE:
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	LDA #13
	L2: DECA
	BNE L2
	RTS

;set address of the LCD to correctly use it in I2C
LCD_ADDR:
	BCLR RS, PTAD
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	LDA #13
	L4: DECA
	BNE L4
	BSET RS, PTAD
	RTS
	
IIC_Startup_slave:
	;set baud rate kbps
	LDA #%10000111
	STA IICF
	;set slave address
	LDA #$12
	STA IICA
	;Enable IIC and Interrrupts
	BSET IICC_IICEN, IICC
	BSET IICC_IICIE, IICC
	BCLR IICC_MST, IICC
	
	RTS
_Viic:
	LDA #1
	STA FLAG ;interrupt entered
	;clear interrupt
	BSET IICS_IICIF, IICS
	;master mode?
	LDA IICC
	AND #%00100000
	BEQ _Viic_slave ;yes
	;no
	RTI
	

_Viic_slave:

	;Arbitration lost?
	LDA IICS
	AND #%00010000
	BEQ _Viic_slave_iaas ;No
	BCLR 4, IICS ;if yes clear arbitration lost bit
	BRA _Viic_slave_iaas2

_Viic_slave_iaas:

	;adressed as slave?
	LDA IICS
	AND #%01000000
	BNE _Viic_slave_srw ;yes
	BRA _Viic_slave_txRx ;no
	

_Viic_slave_iaas2:

	;adressed as slave?
	LDA IICS
	AND #%01000000
	BNE _Viic_slave_srw ;yes
	RTI ;if no exist
	

_Viic_slave_srw:

	;slave read/write
	LDA IICS
	AND #%00000100
	BEQ _Viic_slave_setRx ;slave reads
	BRA _Viic_slave_setTx ;slave writes
	

_Viic_slave_setTx:

	;transmits data
	BSET 4, IICC ;transmit mode select
	LDX current
	LDA IIC_MSG, X ;selects current byte of message to send
	STA IICD ;sends message
	INCX
	STX current; increments current
	RTI
	

_Viic_slave_setRx:
	;makes slave ready to receive data
	BCLR 4, IICC ;recieve mode select
	LDA #0
	STA current
	LDA IICD ;dummy read
	RTI
	

_Viic_slave_txRx:

	LDA IICC
	AND #%00010000
	BEQ _Viic_slave_read ;receive
	BRA _Viic_slave_ack ;transmit
	
	

_Viic_slave_ack:

	LDA IICS
	AND #%00000001
	BEQ _Viic_slave_setTx ;yes, transmit next byte
	BRA _Viic_slave_setRx ;no, switch to receive mode
	
	

_Viic_slave_read:

	CLRH
	LDX current
	LDA IICD
	STA IIC_MSG, X ;store recieved data in IIC_MSG
	NOP
	NOP
	
	INCX
	STX current ;increment current
	
	CPX #7
	BEQ _Viic_slave_read
	NOP
	RTI
