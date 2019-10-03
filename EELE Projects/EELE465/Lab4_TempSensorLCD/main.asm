;Main.s for Lab4 LCD by Josh Freund, Josh Harthan
;4/4/19
            INCLUDE 'derivative.inc'
            XDEF _Startup, main, _Viic
            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack

;define the enable, read/write, and rs bits for writing to LCD			
E		 EQU 0
RW		 EQU 2
RS		 EQU 1
	;create variables in RAM
		ORG $0060
		
FLAG	DS.B 1
FLAG2   DS.B 1
Storage DS.B 1
Temperature DS.B 1
Kelvin  DS.B 1
BigDud	DS.B 1
	IIC_addr: DS.B 1
	msgLength: DS.B 1
	current: DS.B 1
	IIC_MSG: DS.B 1
	TIME: DS.B 1		
		
		
		ORG $E000	

	;store messages to be displayed by LCD in ROM	
	MSG1: DC.B 'Enter n:'
		  DC.B 0
	MSG2: DC.B 'T,C:'
		  DC.B 0
	MSG3: DC.B 'T,K:'
		  DC.B 0


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

	CLR PTAD 		;clear data within PTA register
	CLR PTBD 		;clear data within PTB register
	LDA #$FF		;makes ports outputs
	STA PTADD
	STA PTBDD
	
	BCLR RS, PTAD
	LDA #255		;delay
	STA TIME
	JSR VAR_DELAY
	
	LDA #$38		;display control
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

	MOV #0, FLAG
	MOV #0, Kelvin
	JSR IIC_Startup_slave
				
;display number on LCD given keypad press			
mainLoop:
	LDA IIC_MSG
	CBEQA #%00101000, GiveMeA1
	BRA JUMP7
	GiveMeA1:
		JSR DebugBounce
		LDA #%00110001
		JSR LCD_WRITE
		JMP NEW
	JUMP7:
		LDA IIC_MSG
		CBEQA #%00100100, GiveMeA2
		BRA JUMP8
	GiveMeA2:
		JSR DebugBounce
		LDA #%00110010
		JSR LCD_WRITE
		JMP NEW
	JUMP8:
		LDA IIC_MSG
		CBEQA #%00100010, GiveMeA3
		BRA JUMP9
	GiveMeA3:
		JSR DebugBounce
		LDA #%00110011
		JMP NEW
	JUMP9:
		LDA IIC_MSG
		CBEQA #%00011000, GiveMeA4
		BRA JUMP10
	GiveMeA4:
		JSR DebugBounce
		LDA #%00110100
		JSR LCD_WRITE
		JMP NEW
		BRA JUMP10
	MIDDLE1:
		BRA mainLoop
	JUMP10:
		LDA IIC_MSG
		CBEQA #%00010100, GiveMeA5
		BRA JUMP11
	GiveMeA5:
		JSR DebugBounce
		LDA #%00110101
		JSR LCD_WRITE
		JMP NEW
	JUMP11:
		LDA IIC_MSG
		CBEQA #%00010010, GiveMeA6
		BRA JUMP12
	GiveMeA6:
		JSR DebugBounce
		LDA #%00110110
		JSR LCD_WRITE
		JMP NEW
	JUMP12:
		LDA IIC_MSG
		CBEQA #%01001000, GiveMeA7
		BRA JUMP13
	GiveMeA7:
		JSR DebugBounce
		LDA #%00110111
		JSR LCD_WRITE
		JMP NEW
	JUMP13:
		LDA IIC_MSG
		CBEQA #%01000100, GiveMeA8
		BRA JUMP14
	GiveMeA8:
		JSR DebugBounce
		LDA #%00111000
		JSR LCD_WRITE
		JMP NEW
		BRA JUMP14
	MIDDLE2:
		BRA MIDDLE1
	JUMP14:
		LDA IIC_MSG
		CBEQA #%01000010, GiveMeA9
		BRA JUMP15
	GiveMeA9:
		JSR DebugBounce
		LDA #%00111001
		JSR LCD_WRITE
		JMP NEW
	JUMP15:
		LDA IIC_MSG
		CBEQA #%10000100, GiveMeA0
		JSR DebugBounce
		JMP Another
	GiveMeA0:
		JSR DebugBounce
		LDA #%00110000
		JSR LCD_WRITE
	Another:
		LDA IIC_MSG
		CBEQA #%10001000, GiveMeAE
		JMP mainLoop
	GiveMeAE:
		JSR DebugBounce
		BCLR RS, PTAD
		LDA #%00000001
		STA PTBD
		BSET E, PTAD
		NOP
		BCLR E, PTAD
		BSET RS, PTAD	
		JSR MESSAGE1	
		JMP mainLoop

;loop that indicates a new keypress is acknowleged
NEW:
	LDA #0
	STA FLAG
	JSR DebugBounce
	JSR DebugBounce
	
	BCLR RS, PTAD
	LDA #%00000001
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD	
	
	JSR DebugBounce ;delays for correct timing
	JSR DebugBounce
	JSR DebugBounce
	JSR DebugBounce
	JSR DebugBounce
	
	;loop that loops indefinitely until flag in interrupt is set
	INF:
		LDA FLAG
		CBEQA #1, T
		BRA INF
	;loop that displays the message stored in ROM, than the actual temperature reading
	T:
		JSR DebugBounce
		JSR DebugBounce

		CLRH
		CLRX
		JSR MESSAGE2
	
		LDA IIC_MSG 
		STA Temperature
	
		;binary coded decimal, from binary to hex
		LDA Temperature
		AND #%11110000
		LSRA
		LSRA
		LSRA
		LSRA
		STA Storage
	
		LDA #%00110000
		ADD Storage
		STA IIC_MSG
	
		LDA IIC_MSG
		JSR LCD_WRITE
	
		JSR DebugBounce
		JSR DebugBounce
	
		LDA Temperature
		AND #%00001111
		STA Storage
	
		LDA #%00110000
		ADD Storage
		STA IIC_MSG
		LDA IIC_MSG
		JSR LCD_WRITE
		JSR DebugBounce
		JSR DebugBounce
	
		JMP INT
	
	JMP mainLoop ;branch indefinitely

INT:
	JSR DebugBounce
	
	BCLR RS, PTAD
	LDA #%11000000
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD
	
	JSR DebugBounce
	JSR DebugBounce
	
	
	LDA #0
	STA FLAG
	INF2:
	LDA FLAG
	CBEQA #1, T2
	BRA INF2
	T2:
	JSR DebugBounce
	JSR DebugBounce
	
	CLRH
	CLRX
	JSR MESSAGE2
	LDA IIC_MSG 
	STA Temperature
	
	LDA Temperature
	AND #%11110000
	LSRA
	LSRA
	LSRA
	LSRA
	STA Storage
	
	LDA #%00110000
	ADD Storage
	STA IIC_MSG
	
	LDA IIC_MSG
	JSR LCD_WRITE
	
	
	JSR DebugBounce
	JSR DebugBounce
	
	LDA Temperature
	AND #%00001111
	STA Storage
	
	LDA #%00110000
	ADD Storage
	STA IIC_MSG
	LDA IIC_MSG
	JSR LCD_WRITE
	JSR DebugBounce
	JSR DebugBounce
	
	LDA #%00000010
	STA Kelvin
	LDA #%00110000
	ADD Kelvin
	STA Kelvin
	
	JSR DebugBounce
	JSR MESSAGE3
	JSR DebugBounce
	
	LDA Kelvin
	JSR LCD_WRITE
	JSR DebugBounce
	
	LDA Temperature
	ADD #$73
	STA BigDud
	
	LDA BigDud
	AND #%11110000
	LSRA
	LSRA
	LSRA
	LSRA
	STA Storage
	
	LDA #%00110000
	ADD Storage
	STA IIC_MSG
	
	LDA IIC_MSG
	JSR LCD_WRITE
	
	
	JSR DebugBounce
	JSR DebugBounce
	
	LDA BigDud
	AND #%00001111
	STA Storage
	
	LDA #%00110000
	ADD Storage
	STA IIC_MSG
	LDA IIC_MSG
	JSR LCD_WRITE
	JSR DebugBounce
	JSR DebugBounce
	
	
	BCLR RS, PTAD
	LDA #%00000010
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD
	
	JMP mainLoop

;delay loop when a delay is needed
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

;loop that iterates through the ASCII characters stored in ROM
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
	
;loop that iterates through the ASCII characters stored in ROM	
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
;loop that iterates through the ASCII characters stored in ROM
MESSAGE3:
	JSR LCD_ADDR
	CLRX
	JSR VAR_DELAY
	L444:
		LDA MSG3, X
		BEQ OUTMSG3
		JSR LCD_WRITE
		JSR VAR_DELAY
		INCX
		BRA L444
		OUTMSG3:
			RTS
;shorter delay loop
VAR_DELAY:
	LDA #200
	L1: DECA
	BNE L1
	DEC TIME
	BNE VAR_DELAY
	RTS

LCD_WRITE:
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	LDA #13
	L2: DECA
	BNE L2
	RTS

;set the address for the LCD slave	
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
	STA FLAG
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
	INCX
	STX current ;increment current
	RTI
