;Main.s by Josh Freund, Joshua Harthan
;2/12/19
;LED Slave code
		INCLUDE 'derivative.inc'
		XDEF _Startup, main, _Viic
		XREF __SEG_END_SSTACK	;symbol defined by the linker for the end of the stack
	
	
		ORG	$0060
		
Counter1 DS.B 1
Counter2 DS.B 1
Counter3 DS.B 1
Check	 DS.B 1
	
	;variables in RAM to communicate via I2C
	IIC_addr: DS.B 1
	msgLength: DS.B 1
	current: DS.B 1
	IIC_MSG: DS.B 1

		ORG $E000	
	;values stored in ROM to be loaded into the PTBD register to flash the LED with certain patterns 		
	LookUpStatic: DC.B %10101010
	LookUpSlideRight: DC.B %11111110, %11111101, %11111011, %11110111, %11101111, %11011111, %10111111, %01111111
	LookUpDiamond: DC.B %00011000, %00100100, %01000010, %10000001, %01000010, %00100100, %00011000
	LookUpArrow: DC.B %00111100, %01111000, %11110000, %11100000, %11000000, %10000000, %11000000, %11100000, %11110000, %01111000, %00111100
	
	
main:

_Startup:

	LDHX #__SEG_END_SSTACK ;initialize the stack pointer
	TXS
	
	CLI ;intitialize interrupts
	
	LDA SOPT1			;kill watchdog
	AND #%0111111
	STA SOPT1

	LDA #%11111111 ;set PTBDD as outputs, controls LEDs
	STA PTBDD
	
	LDA #%00000000	;turn off LEDs
	STA PTBD
	
	LDA #%10000001 ;output connected to TPM and enable bus clock as source
	STA SOPT2
	
	JSR IIC_Startup_slave
	

mainLoop:
	;clear the H/X registers
	CLRH
	CLRX
	
	;load up the value of IIC_MSG that was sent by master
	LDA IIC_MSG
	
	;compare value sent by master and branch to different subroutines based off the value received

	CMP #%00100001
	BEQ Static
	
	CLRX
	LDA #9
	STA Counter1
	LDA IIC_MSG
	CMP #%00011001
	BEQ SlideRight
	
	CLRX
	LDA #8
	STA Counter2
	LDA IIC_MSG
	CMP #%01000001
	BEQ Diamond
	
	CLRX
	LDA #12
	STA Counter3
	LDA IIC_MSG
	CMP #%10000001
	BEQ Arrow
	
	BRA mainLoop
	
	
;subroutines that load up the values stored in ROM and store them in the PTBD register 	
;pattern A
Static:

	LDA LookUpStatic
	STA PTBD
	BRA mainLoop	

;pattern B	
SlideRight:

	
	LDA LookUpSlideRight, X
	STA PTBD
	STA Check
	INCX
	
	LDA Counter1
	DECA
	STA Counter1
	JSR Delay
	
	LDA Counter1
	STA Counter1
	BNE SlideRight
	
	BRA mainLoop

	
;pattern C	
Diamond:

	LDA LookUpDiamond, X
	STA PTBD
	STA Check
	INCX
	
	LDA Counter2
	DECA
	STA Counter2
	JSR Delay
	LDA Counter2
	STA Counter2
	BNE Diamond
	
	BRA mainLoop
	
;pattern D 
Arrow:

	LDA LookUpArrow, X
	STA PTBD
	STA Check
	INCX
	
	LDA Counter3
	DECA
	STA Counter3
	JSR Delay
	
	LDA Counter3
	STA Counter3
	BNE Arrow
	
	BRA mainLoop	


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

;delay loop to be implemented when neeeded
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
	
