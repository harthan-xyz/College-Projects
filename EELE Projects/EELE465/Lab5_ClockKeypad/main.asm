;Main.s for Lab5 keypad by Josh Freund, Josh Harthan
;4/23/19
		INCLUDE 'derivative.inc'
		XDEF _Startup, main, Column, _Viic
		XREF __SEG_END_SSTACK	;symbol defined by the linker for the end of the stack

	
		ORG	$0060
;variables stored in RAM	
RowPress	 DS.B 1 ;keeps track of value pressed for the row of the keypad
ColumnPress  DS.B 1 ;keeps track of value pressed for the column of the keypad
Total		 DS.B 1 ;total value of the keypad press, combines rowpress and columnpress
Flag		 DS.B 1 ;flag to be used in I2C
Number		 DS.B 1 ;variable to represent the number pressed on the keypad
AddressCount  DS.B 1 ;variable that keeps track of the current clock address
InterruptFlag DS.B 1 ;flag that is thrown when the keyboard interrupt is entered
KeyPadStorage DS.B 1 ;variable that acts as a storage of the initial keypad press, so that the total can be manipulated
IndexCount	  DS.B 1 ;variable that stores the total amount of index positions to move
IndexPosition   DS.B 1 ;index that points to the current index position
Redrum		  DS.B 1 ;variable that acts a flag that is set when all data is sent


	FullKeypad:	DS.B 1 ;superfluous variable for testing
	IIC_addr:	DS.B 1 ;track IIC address
	IIC_LCD:	DS.B 1 ;tracs IIC address of the LCD
	msgLength:	DS.B 1 ;track total message length
	current:	DS.B 1 ;track which byte we have sent
	IIC_msg:	DS.B 7 ;enable 32 bit transmission


		ORG $E000	
		
		;lookup table to act as indexes of the DS1337 clock registers
		AddressWrite:   DC.B $05, $04, $06, $02, $01, $00
		
main:

_Startup:

	LDHX #__SEG_END_SSTACK ; initialize the stack pointer
	TXS
	CLI					;clears interrupt flag-enables interrupt
	
	LDA SOPT1			;kill watchdog
	AND #%01111111
	STA SOPT1
	
	LDA SOPT2 ;set PTBD pins to be used for SDA/SCL
	ORA #%00000010
	STA SOPT2
	
	MOV #$00, IIC_msg
	

	MOV #$12, IIC_LCD  ;set slave address
	MOV #$C1, IIC_msg  ;set actual message
	


	LDA #%00000000		;disable pull ups for port A
	STA PTAPE

	LDA	#%11111111		;Sets rising edge sensitive 
	STA KBIES
	
						;enable columns interrupt
	BSET 0, KBIPE		;column 1
	BSET 1, KBIPE		;column 2
	BSET 2, KBIPE		;column 3
	BSET 3, KBIPE		;column 4
	
						;Set Rows as Outputs
	BSET 5, PTBDD		;set Row 4
	BSET 4, PTBDD		;set Row 3
	BSET 3, PTBDD		;set Row 1
	BSET 2, PTBDD		;set Row 2
	
						;Set Columns as Inputs
	BCLR 0, PTADD		;set Column 1
	BCLR 1, PTADD		;set Column 2
	BCLR 2, PTADD		;set Column 3
	BCLR 3, PTADD		;set Column 4
	
	
	
	BSET 1, KBISC		;enables Keyboard interrupt
	
	;clear the H and X registers
	CLRH
	CLRX
	
	;initialize variables to equal zero
	LDA #0
	STA Flag
	STA Number
	STA KeyPadStorage
	STA AddressCount
	STA InterruptFlag
	STA IndexCount
	STA IndexPosition
	STA Redrum
	JSR IIC_Startup_Master

	;1101000 0 - write bit - transfer info from master to slave
	;1101000 1 - read bit - transfer info from slave to master

;mainloop that runs indefinitely until I2C flag is thrown
mainLoop:
	;initialize the length of the I2C message to a value of two
	LDA #2
	STA msgLength
	
	JSR Delay
	
	LDA Flag
	CMP #1
	BEQ firstbit
	JMP END
	
;subroutine that takes in value of the first keypad press, and puts this value into the tens-digit position of keypadstorage
firstbit:
	JSR Acquire
	
	LDA Number
	STA KeyPadStorage
	
	LDA KeyPadStorage
	LSLA
	LSLA
	LSLA
	LSLA
	STA KeyPadStorage
	
;infinite loop that waits until I2C interupt is entered
looper:
	JSR Delay
	LDA Flag
	CMP #1
	BEQ secondbit
	
	JMP END2
	
;subroutine that takes in value of the first keypad press, and puts this value into the ones-digit position of keypadstorage
secondbit:
	JSR Acquire
	
	LDA KeyPadStorage
	ADD Number
	STA KeyPadStorage
	
	JMP Begin

;once both keypresses are concatenated into a singular number, send this value over I2C to the correct registers of the clock and LCD
Begin:	
	LDX IndexCount
	LDA AddressWrite, x
	LDX IndexPosition
	STA IIC_msg, x
		
	LDA IndexPosition
	INCA
	STA IndexPosition	
				
	LDX IndexPosition
	LDA KeyPadStorage
	STA IIC_msg, x
	
				
	LDA #%11010000
	STA IIC_addr ;get info to clock	
	JSR IIC_DataWrite
	JSR Delay
		
	;reset flags		
	MOV #0, KeyPadStorage
	MOV #0, IndexPosition
		
	LDA IndexCount
	INCA 
	STA IndexCount
		
	CBEQA #6, ReadModeFlag
		
	JMP mainLoop

;loops that determine column and row presses	
END:
	JSR Delay
	
	LDA #%00000100
	STA PTBD
	NOP
	LDA #%00001000
	STA PTBD
	NOP		
	LDA #%00010000
	STA PTBD
	NOP	
	LDA #%00100000
	STA PTBD	
	NOP

	JSR DebugBounce
	
	LDA Redrum
	CBEQA #244, ReadMode ;if flag is set, start reading
		
	JMP mainLoop
	
END2:
	JSR Delay
	
	LDA #%00000100
	STA PTBD
	NOP
	LDA #%00001000
	STA PTBD
	NOP		
	LDA #%00010000
	STA PTBD
	NOP	
	LDA #%00100000
	STA PTBD	
	NOP

	JSR DebugBounce	

	JMP looper

;set the redrum flag, data is done being written
ReadModeFlag:
	MOV #244, Redrum
	JMP mainLoop

;subroutine that continues to read values from the clock over I2C	
ReadMode:
	
	LDA #1
	STA msgLength
	CLRX
	
	JSR Delay
	JSR Delay
	
	LDA #%11010000
	STA IIC_addr
	MOV #0, IIC_msg
	JSR IIC_DataWrite
	JSR Delay
	LDA #7
	STA msgLength
	RM:

	JSR Delay
	LDA #%11010001
	STA IIC_addr ;get info to clock
	JSR IIC_DataWrite
	JSR Delay
	JSR Delay
	
	LDA IIC_LCD
	STA IIC_addr
	JSR IIC_DataWrite
	

	JSR Delay
	
	JMP mainLoop

;loop that determines which number was pressed based off total(columnpress + rowpress)
Acquire:
	LDA Total
	CBEQA #%00101000, GiveMeA1	
	CBEQA #%00100100, GiveMeA2
	CBEQA #%00100010, GiveMeA3
	CBEQA #%00011000, GiveMeA4
	CBEQA #%00010100, GiveMeA5
	CBEQA #%00010010, GiveMeA6
	CBEQA #%01001000, GiveMeA7
	CBEQA #%01000100, GiveMeA8
	CBEQA #%01000010, GiveMeA9
	CBEQA #%10000100, GiveMeA0
		RTS
	GiveMeA1:
		LDA #1
		STA Number
		MOV #0, Flag
		RTS
	GiveMeA2:
		LDA #2
		STA Number
		MOV #0, Flag
		RTS
	GiveMeA3:
		LDA #3
		STA Number
		MOV #0, Flag
		RTS
	GiveMeA4:
		LDA #4
		STA Number
		MOV #0, Flag
		RTS
	GiveMeA5:
		LDA #5
		STA Number
		MOV #0, Flag
		RTS
	GiveMeA6:
		LDA #6
		STA Number
		MOV #0, Flag
		RTS
	GiveMeA7:
		LDA #7
		STA Number
		MOV #0, Flag
		RTS
	GiveMeA8:
		LDA #8
		STA Number
		MOV #0, Flag
		RTS
	GiveMeA9:
		LDA #9
		STA Number
		MOV #0, Flag
		RTS
	GiveMeA0:
		LDA #0
		STA Number
		MOV #0, Flag
		RTS
		
;Actual Interrupt Start
_Viic:
	;clear interrupt
	BSET IICS_IICIF, IICS
	;check if master
	BCLR IICC_TXAK, IICC
	BRSET IICC_MST, IICC, _Viic_master ;yes
	;should never need to be a slave
	RTI 

;Code to check if master or slave
_Viic_master:
	BRSET IICC_TX, IICC, _Viic_master_TX ;for transfer
	BRA _Viic_master_RX ;for receive

;Check if transmitting or receiving, theoretically handle arbitration
_Viic_master_TX:
	LDA msgLength
	SUB current
	BNE _Viic_master_rxAck ;not last byte
	;is last byte
	BCLR IICC_MST, IICC
	BSET IICS_ARBL, IICS ;arbitration lost, no code made for recovery
	RTI

;Is there an acknowledge
_Viic_master_rxAck:

	BRCLR IICS_RXAK, IICS, _Viic_master_EoAC ;ack from slave received
	;BRA _Viic_master_EoAC
	NOP
	NOP
	NOP
	
	BCLR IICC_MST, IICC	;no ack from slave received
	RTI

;End of Address Cycle, check for receive or write data 
_Viic_master_EoAC:
	;read from or transfer to slave?
	LDA IIC_addr ;check if read or transfer
	AND #%00000001
	BNE _Viic_master_toRxMode
	
	LDX current
	LDA IIC_msg, x
	STA IICD
	
	LDA current
	INCA
	STA current
	RTI

;Perform dummy read
_Viic_master_toRxMode:
	BCLR IICC_TX, IICC ;dummy read for EoAC
	LDA IICD
	RTI
	
	
;Receive data and acheck if nearing message completion
_Viic_master_RX:
	BCLR IICC_TXAK, IICC
	;last byte to be read
	LDA msgLength
	SUB current
	BEQ _Viic_master_rxStop
	
	DECA
	
	BEQ _Viic_master_txAck
	BRA _Viic_master_readData

;generate stope condition for receive 
_Viic_master_rxStop:
	BCLR IICC_MST, IICC ;send stop bit
	BRA _Viic_master_readData

;generate acknowledge signal
_Viic_master_txAck:
	BSET IICC_TXAK, IICC ;transfer acknowledge
	BRA _Viic_master_readData

;Read and store data 
_Viic_master_readData:
	CLRH
	LDX current
	;Read byte from IICD and store into IIC_msg
	LDA IICD
	STA IIC_msg, x ;store message into indexed
	
	LDA current
	INCA 
	STA current
	
	RTI
	
;Initial configuration 
IIC_Startup_Master:
	;set baud rate to 50kbps
	LDA #%10000111
	STA IICF
	;Enable IIC and interrupts 
	BSET IICC_IICEN, IICC
	BSET IICC_IICIE, IICC
	RTS

;Initiate a transfer
IIC_DataWrite:

	LDX #0 ;initialize current
	STX current	
	
	BSET 5, IICC ;IICC_MST, IICC ;set master mode
	BSET IICC_TX, IICC
	STA IICD
	
	RTS

;two delay loops of varying lengths to be placed when needed
Delay:
	LDA #255
	STA $125
	loop1:
		LDA #255
		STA $126
		loop2:
			LDA $126
			DECA
			STA $126
			BNE loop2
		LDA $125
		DECA
		STA $125
		BNE loop1
	RTS

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

;column interrupt that is thrown when a keyboard press is performed
Column:

	JSR DebugBounce
	LDA #1
	STA Flag

	LDA InterruptFlag
	INCA
	STA InterruptFlag
	
	LDA PTAD
	AND #%00001111
 	STA ColumnPress
 	
 	NOP
	NOP
	NOP
	
	LDA PTBD
	AND #%00111100
	LSLA
	LSLA
	STA RowPress
	
	NOP
	NOP

	LDA RowPress
	ADD ColumnPress
	STA Total
	STA IIC_msg

	BSET 2, KBISC
	
	RTI



