;Main.s for Lab6 Thermoelectric Cooler LCD by Josh Freund, Josh Harthan
;4/30/19

; Include derivative-specific definitions
            INCLUDE 'derivative.inc'
            XDEF _Startup, main, _Viic ;define interrupts
            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack

;define bits to be manipulated in LCD setup
E		 EQU 0 
RW		 EQU 2
RS		 EQU 1

		ORG $0060
		
FLAG	DS.B 1 ;flag to be thrown when I2C interrupt entered
BigDud	DS.B 1 ;variable that stores the manipulated LM92 register values
BigDudTemp DS.B 1 ;variable that stores the actual temperature reading of the LM92
Counter DS.B 1 ;variable used for LCD setup
	IIC_addr: DS.B 1 ;address used in I2C (12)
	msgLength: DS.B 1 ;length of the I2C message (1 byte)
	current: DS.B 1 ;current message variable
	IIC_MSG: DS.B 1 ;actual message sent over I2C
	TIME: DS.B 1 ;variable that keeps track of the time from DS1337 serial clock	
		
		
		ORG $E000	
	;possible messages to be displayed on the LCD stored in ROM
	MSG1: DC.B 'TEC State:      '
		  DC.B 0
	MSG2: DC.B 'T92:    K@T=   '
		  DC.B 0
	MSG3: DC.B 'TEC State: Heat '
		  DC.B 0
	MSG4: DC.B 'TEC State: Cool '
		  DC.B 0
	MSG5: DC.B 'TEC State: Off  '
		  DC.B 0
	MSG6: DC.B 'T92:'
		  DC.B 0
	AddressWrite:   DC.B 0	  
	
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

	CLR PTAD ;clears the data
	CLR PTBD ;clears the data
	LDA #$FF		;makes ports outputs
	STA PTADD
	STA PTBDD
	
	;LCD initialization
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
	
;loop that waits for I2C interrupt 
mainLoop:
	LDA FLAG
	CBEQA #1, completed

	BRA mainLoop
	
;when I2C message recieved, determine what data is sent
completed:
	LDA IIC_MSG
	CBEQA #0, zero
	CBEQA #1, first
	CBEQA #2, secondo
	BRA mainLoop
	
;if the sent data is one, display the correct state, temp, time
zero:
	LDA #0
	STA FLAG
	waiter3:
	LDA FLAG
	CBEQA #1, almostdone
	BRA waiter3
;if the I2C message is recieved, display the correct message on the LCD
almostdone:
	LDA IIC_MSG
	CBEQA #2, second
	CBEQA #1, first
	BCLR RS, PTAD
	LDA #%00000010			;sets home
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD
	JSR DebugBounce
	CLRH
	CLRX
	JSR MESSAGE5
	LDA #0
	STA FLAG
	BCLR RS, PTAD
	LDA #%11000000			;sets second line
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD
	JSR MESSAGE6
	JSR DecimalToHexToAscii
	BRA waiter3
	
;subroutine that branches for out of bounds error
mainLoop1:
	BRA mainLoop
;if the sent data is one, display the correct state, temp, time
first:
	LDA #0
	STA FLAG
	waiter:
	LDA FLAG
	CBEQA #1, letsgo
	BRA waiter
	letsgo:
	LDA IIC_MSG
	CBEQA #2, second
	CBEQA #0, zero
	BCLR RS, PTAD			;sets home
	LDA #%00000010
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD
	JSR DebugBounce
	CLRH
	CLRX
	BRA JUMPERS
	zero1:
	BRA zero
	mainLoop2:
	BRA mainLoop1
	secondo:
	BRA second
	JUMPERS:
	JSR MESSAGE3
	LDA #0
	STA FLAG
	BCLR RS, PTAD
	LDA #%11000000			;sets second line
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD
	JSR MESSAGE6
	JSR DecimalToHexToAscii
	BRA waiter
	
;if the sent data is a two, display the correct state, temp, time
second:
	LDA #0
	STA FLAG
	waiter2:
	LDA FLAG 
	CBEQA #1, getout
	BRA waiter2
	getout:
	LDA IIC_MSG
	CBEQA #1, first
	CBEQA #0, zero1

	BCLR RS, PTAD
	LDA #%00000010			;sets home
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD
	JSR DebugBounce
	CLRH
	CLRX
	
	JSR MESSAGE4
	LDA #0
	STA FLAG

	BCLR RS, PTAD
	LDA #%11000000			;sets second line
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	BSET RS, PTAD
	
	JSR MESSAGE6

	JSR DecimalToHexToAscii

	BRA waiter2

;display the LM92 temperature register reading in ASCII
DecimalToHexToAscii:
	LDA IIC_MSG
	STA BigDud
	
	LDA #0
	STA BigDudTemp
	
	LDA BigDud
	LSRA
	LSRA
	LSRA
	LSRA
	STA BigDudTemp
	
	LDA #%00110000
	ADD BigDudTemp
	STA BigDudTemp
	
	LDA BigDudTemp
	JSR LCD_WRITE
	JSR DebugBounce
	
	LDA BigDud
	AND #%00001111
	STA BigDudTemp
	
	LDA #%00110000
	ADD BigDudTemp
	STA BigDudTemp
	
	LDA BigDudTemp
	JSR LCD_WRITE
	JSR DebugBounce
	
;delay loop to be implemented when needed
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

;display the messages stored in ROM to the LCD
MESSAGE1:
	LDA #$84
	JSR LCD_ADDR
	CLRX
	JSR VAR_DELAY
	L11:
		LDA MSG1, X
		BEQ OUTMSG1
		JSR LCD_WRITE
		JSR VAR_DELAY
		INCX
		BRA L11
		OUTMSG1:
			RTS
MESSAGE2:
	JSR LCD_ADDR
	CLRX
	JSR VAR_DELAY
	L22:
		LDA MSG2, X
		BEQ OUTMSG2
		JSR LCD_WRITE
		JSR VAR_DELAY
		INCX
		BRA L22
		OUTMSG2:
			RTS
MESSAGE3:
	JSR LCD_ADDR
	CLRX
	JSR VAR_DELAY
	L33:
		LDA MSG3, X
		BEQ OUTMSG3
		JSR LCD_WRITE
		JSR VAR_DELAY
		INCX
		BRA L33
		OUTMSG3:
			RTS
			
MESSAGE4:
	JSR LCD_ADDR
	CLRX
	JSR VAR_DELAY
	L44:
		LDA MSG4, X
		BEQ OUTMSG4
		JSR LCD_WRITE
		JSR VAR_DELAY
		INCX
		BRA L44
		OUTMSG4:
			RTS
			
MESSAGE5:
	JSR LCD_ADDR
	CLRX
	JSR VAR_DELAY
	L55:
		LDA MSG5, X
		BEQ OUTMSG5
		JSR LCD_WRITE
		JSR VAR_DELAY
		INCX
		BRA L55
		OUTMSG5:
			RTS		
MESSAGE6:
	JSR LCD_ADDR
	CLRX
	JSR VAR_DELAY
	L66:
		LDA MSG6, X
		BEQ OUTMSG6
		JSR LCD_WRITE
		JSR VAR_DELAY
		INCX
		BRA L66
		OUTMSG6:
			RTS
;delay to be used in LCD setup			
VAR_DELAY:
	LDA #200
	L1: DECA
	BNE L1
	DEC TIME
	BNE VAR_DELAY
	RTS

;write data to be displayed on the LCD
LCD_WRITE:
	STA PTBD
	BSET E, PTAD
	NOP
	BCLR E, PTAD
	LDA #13
	L2: DECA
	BNE L2
	RTS

;set the address of the LCD
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
;I2C interrupt
_Viic:
	;set flag
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
	NOP
	NOP
	
	INCX
	STX current ;increment current
	
	CPX #7
	BEQ _Viic_slave_read
	NOP
	RTI
