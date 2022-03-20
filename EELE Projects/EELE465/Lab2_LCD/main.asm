;Main.s by Josh Freund, Josh Harthan
;Lab 2 LCD Slave code
;2/26/19
		INCLUDE 'derivative.inc'
		XDEF _Startup, main, _Viic
		XREF __SEG_END_SSTACK	;symbol defined by the linker for the end of the stack
			
E		 EQU 0
RW		 EQU 2
RS		 EQU 1

		ORG	$0060

	IIC_addr: DS.B 1
	msgLength: DS.B 1
	current: DS.B 1
	IIC_MSG: DS.B 1
	TIME: DS.B 1
	
	
		ORG $E000	
main:

_Startup:

	LDHX #__SEG_END_SSTACK ;initialize the stack pointer
	TXS
	
	CLI
	
	LDA SOPT1			;kill watchdog
	AND #%01111111
	STA SOPT1
	
	
	LDA #%10000001
	STA SOPT2

	CLR PTAD	;clears the data
	CLR PTBD	;clears the data
	LDA #$FF	;makes ports outputs
	STA PTADD
	STA PTBDD
	
	BCLR RS, PTAD
	LDA #255		;delay
	STA TIME
	JSR VAR_DELAY
	
	LDA #$38 ;display control
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

	JSR IIC_Startup_slave

mainLoop:
	BSET 1, PTAD
	LDA IIC_MSG
	CBEQA #%00100001, GiveMeAnA
	BRA JUMP1
GiveMeAnA:
	JSR DebugBounce
	LDA #%01000001
	JSR LCD_WRITE	
	JSR DebugBounce
	LDA #$00
	STA IIC_MSG
	BRA mainLoop
JUMP1:	
	LDA IIC_MSG
	CBEQA #%00010001, GiveMeAB
	BRA JUMP2
GiveMeAB:
	LDA #%01000010
	JSR LCD_WRITE
	JSR DebugBounce
	LDA #$00
	STA IIC_MSG
	BRA mainLoop
JUMP2:
	LDA IIC_MSG
	CBEQA #%01000001, GiveMeAC
	BRA JUMP3
GiveMeAC:
	JSR DebugBounce
	LDA #%01000011
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA mainLoop
JUMP3:
	LDA IIC_MSG
	CBEQA #%10000001, GiveMeAD
	BRA JUMP4
GiveMeAD:
	JSR DebugBounce
	LDA #%01000100
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA mainLoop
JUMP4:
	LDA IIC_MSG
	CBEQA #%10001000, GiveMeAE
	BRA JUMP5
GiveMeAE:
	JSR DebugBounce
	LDA #%01000101
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA mainLoop
MIDDLE:
	BRA mainLoop
JUMP5:
	LDA IIC_MSG
	CBEQA #%10000010, GiveMeAF
	BRA JUMP6
GiveMeAF:
	JSR DebugBounce
	LDA #%01000110
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA MIDDLE
JUMP6:
	LDA IIC_MSG
	CBEQA #%00101000, GiveMeA1
	BRA JUMP7
GiveMeA1:
	JSR DebugBounce
	LDA #%00110001
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA MIDDLE
JUMP7:
	LDA IIC_MSG
	CBEQA #%00100100, GiveMeA2
	BRA JUMP8
GiveMeA2:
	JSR DebugBounce
	LDA #%00110010
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA MIDDLE
JUMP8:
	LDA IIC_MSG
	CBEQA #%00100010, GiveMeA3
	BRA JUMP9
GiveMeA3:
	JSR DebugBounce
	LDA #%00110011
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA MIDDLE
JUMP9:
	LDA IIC_MSG
	CBEQA #%00011000, GiveMeA4
	BRA JUMP10
GiveMeA4:
	JSR DebugBounce
	LDA #%00110100
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA MIDDLE
	BRA JUMP10
MIDDLE1:
	BRA MIDDLE
JUMP10:
	LDA IIC_MSG
	CBEQA #%00010100, GiveMeA5
	BRA JUMP11
GiveMeA5:
	JSR DebugBounce
	LDA #%00110101
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA MIDDLE1
JUMP11:
	LDA IIC_MSG
	CBEQA #%00010010, GiveMeA6
	BRA JUMP12
GiveMeA6:
	JSR DebugBounce
	LDA #%00110110
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA MIDDLE1
JUMP12:
	LDA IIC_MSG
	CBEQA #%01001000, GiveMeA7
	BRA JUMP13
GiveMeA7:
	JSR DebugBounce
	LDA #%00110111
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA MIDDLE1
JUMP13:
	LDA IIC_MSG
	CBEQA #%01000100, GiveMeA8
	BRA JUMP14
GiveMeA8:
	JSR DebugBounce
	LDA #%00111000
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA MIDDLE1
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
	LDA #$00
	STA IIC_MSG
	BRA MIDDLE1
JUMP15:
	LDA IIC_MSG
	CBEQA #%10000100, GiveMeA0
	JSR DebugBounce
	BRA MIDDLE2
GiveMeA0:
	JSR DebugBounce
	LDA #%00110000
	JSR LCD_WRITE
	LDA #$00
	STA IIC_MSG
	BRA MIDDLE2

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
	
DebugBounce:
	LDA #2
	STA $120
	loop9:
		LDA #25
		STA $121
		loop10:
			LDA $121
			DECA
			STA $121
			BNE loop10
		LDA $120
		DECA
		STA $120
		BNE loop9
	RTS
Delay:

	LDA #200
	STA $100
	loop1:
		LDA #100
		STA $101
		loop2:
			LDA #10
			STA $102
			loop3:
				LDA $102
				DECA
				STA $102
				BNE loop3
			LDA $101
			DECA
			STA $101
			BNE loop2
		LDA $100
		DECA
		STA $100
		BNE loop1
	RTS
	
