;Main.s for Lab6 Thermoelectric Cooler LED by Josh Freund, Josh Harthan
;4/30/19
		INCLUDE 'derivative.inc'
		XDEF _Startup, main, _Viic ;define interrupts
		XREF __SEG_END_SSTACK	;symbol defined by the linker for the end of the stack
	
	
		ORG	$0060
		
Flag	 DS.B 1 ;flag variable thrown when I2C message recieved

	IIC_addr: DS.B 1 ;address used in I2C (10)
	msgLength: DS.B 1 ;length of the I2C message
	current: DS.B 1 ;current message variable
	IIC_MSG: DS.B 1 ;actual message sent over I2C

		ORG $E000	
		
main:

_Startup:

	LDHX #__SEG_END_SSTACK ;initialize the stack pointer
	TXS
	
	CLI
	
	LDA SOPT1			;kill watchdog
	AND #%01111110
	STA SOPT1

	LDA #%11111111 ;set PTBDD as outputs, controls LEDs
	STA PTBDD
	
	LDA #%00000000	;turn off LEDs
	STA PTBD
	
	LDA #%10000001
	STA SOPT2
	
	JSR IIC_Startup_slave
	CLRH
	CLRX

;loop indefinitely until I2C message is sent
mainLoop:
	LDA Flag
	CBEQA #1, Completed
	BRA mainLoop

;check which messsage is sent over I2C
Completed:
	LDA IIC_MSG
	CBEQA #0, ZERO
	CBEQA #1, ONE
	CBEQA #2, TWO
	BRA mainLoop
;if zero, turn off LEDs and reset flag
ZERO:
	LDA #%00000000
	STA PTBD
	LDA #0
	STA Flag
	BRA mainLoop
;if one, turn on PTBD0 and reset flag
ONE:
	LDA #%00000001
	STA PTBD
	LDA #0
	STA Flag
	BRA mainLoop
;if two, turn on PTBD1 and reset flag
TWO:
	LDA #%00000010
	STA PTBD
	LDA #0
	STA Flag
	BRA mainLoop

;I2C interrupt
_Viic:
	LDA #1
	STA Flag
	;clear interrupt
	BSET IICS_IICIF, IICS
	;master mode?
	LDA IICC
	AND #%00100000
	BEQ _Viic_slave ;yes
	;no
	RTI	
	
IIC_Startup_slave:
	;set baud rate kbps
	LDA #%10000111
	STA IICF
	;set slave address
	LDA #$10
	STA IICA
	;Enable IIC and Interrrupts
	BSET IICC_IICEN, IICC
	BSET IICC_IICIE, IICC
	BCLR IICC_MST, IICC
	
	RTS


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

;delay loop to be implemented when needed
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
	
