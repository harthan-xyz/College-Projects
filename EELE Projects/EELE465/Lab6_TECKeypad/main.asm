;Main.s for Lab6 Thermoelectric Cooler Keypad by Josh Freund, Josh Harthan
;4/30/19
		INCLUDE 'derivative.inc'
		XDEF _Startup, main, Column, _Viic ;define interrupts
		XREF __SEG_END_SSTACK	;symbol defined by the linker for the end of the stack
	
		ORG	$0060
		
RowPress	 DS.B 1 ;variable that keeps track of which row on keypad is pressed
ColumnPress  DS.B 1 ;variable that keeps track of which column on keypad is pressed
Total		 DS.B 1 ;total variable that stores the total row and column press of the keypad
Flag		 DS.B 1 ;flag that is thrown when keypad interrupt is entered
Number		 DS.B 1 ;variable that determines the number associated with keypad press
GODWHY		 DS.B 1 ;variable to store bits 15-7 of the LM92 temp register
KeyPadStorage DS.B 1 ;variable that stores the initial keypad press
Redrum		  DS.B 1 ;variable that determines which keypad is pressed and branches accordingly


	FullKeypad:	DS.B 1 ;superfluous variable for testing
	IIC_addr:	DS.B 1 ;track IIC address
	IIC_LCD:	DS.B 1 ;address for the LCD (12)
	IIC_LED:	DS.B 1 ;address for the LED (10)
	msgLength:	DS.B 1 ;track total message length
	current:	DS.B 1 ;track which byte we have sent
	IIC_msg:	DS.B 2 ;enable 32 bit transmission

		ORG $E000	
	
main:

_Startup:

	LDHX #__SEG_END_SSTACK ; initialize the stack pointer
	TXS
	CLI					;clears interrupt 
	LDA SOPT1			;kill watchdog
	AND #%01111111
	STA SOPT1
	
	LDA SOPT2 ;set PTBD pins to be used for SDA/SCL
	ORA #%00000010
	STA SOPT2
	
	MOV #$00, IIC_msg
	
	MOV #$10, IIC_LED
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
	
	
	
	BSET 1, KBISC ;enables Keyboard interrupt
	
	;initialize I2C message length to equal one byte
	CLRH
	CLRX
	LDA #1
	STA msgLength
	
	
	;initialize variables to equal zero
	LDA #0
	STA Flag
	STA Number
	STA KeyPadStorage
	STA InterruptFlag
	STA Redrum
	STA GODWHY

	JSR IIC_Startup_Master

;main loop that loops indefinitely, waiting for keypad press
mainLoop:
	;if keypad is pressed, begin operation
	LDA Flag
	CMP #1
	BEQ completed
	
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
	
	JSR Delay
	BRA mainLoop

;loop that determines keypad press and branches accordingly
completed:
	JSR Delay
	JSR Acquire
	
	LDA Number
	STA KeyPadStorage
	
	LDA KeyPadStorage
	CBEQA #0, zero
	CBEQA #1, first
	CBEQA #2, secondjump
	BRA mainLoop

;if zero is pressed, send the data to the slaves of the system
zero:
	LDA Number
	STA IIC_msg
	LDA IIC_LCD
	STA IIC_addr
	JSR IIC_DataWrite
	JSR Delay
	LDA Number
	STA IIC_msg
	LDA IIC_LED
	STA IIC_addr
	JSR IIC_DataWrite
	JSR Delay
	
	LDA #0
	STA IIC_msg
	LDA #%10010000
	STA IIC_addr
	JSR IIC_DataWrite
	JSR Delay

	BRA EXIT
	
;subroutine that branches for out of bounds error	
mainLoop1:
	JMP mainLoop

;subroutine sets the flag for the 	
EXIT:
	LDA #1
	STA Redrum
	
redrum2:
	JSR Delay
	LDA #%10010001
	STA IIC_addr
	JSR IIC_DataWrite
	
	JSR Delay
	JSR Delay
	JSR alrightthissucks
	
	LDA IIC_LCD
	STA IIC_addr 	
	JSR IIC_DataWrite
	
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
	
	LDA Redrum
	CBEQA #1, redrum2

	LDA #0
	STA Flag
	
	LDA #1
	STA msgLength
	
	BRA mainLoop1

;subroutine that branches for out of bounds error
secondjump:
	BRA secondjump1

;if one is pressed, send the data to the slaves of the system
first:
	LDA #1
	STA msgLength
	CLRX
	CLRH
	JSR Delay
	LDA Number
	STA IIC_msg
	LDA IIC_LCD
	JSR IIC_DataWrite
	JSR Delay
	LDA Number
	STA IIC_msg
	LDA IIC_LED
	JSR IIC_DataWrite
	JSR Delay
	BRA EXIT1
	
;subroutine that branches for out of bounds error
mainLoop2:
	BRA mainLoop1
	
;continuation of the first subroutine
EXIT1:	
	LDA #0
	STA IIC_msg
	LDA #%10010000
	STA IIC_addr
	JSR IIC_DataWrite
	JSR Delay
	JSR Delay
	LDA #1
	STA Redrum
	
;subroutine	that indicates to the LM92 to start reading
redrum:
	JSR Delay
	LDA #%10010001
	STA IIC_addr
	JSR IIC_DataWrite
	JSR Delay
	JSR alrightthissucks
	LDA IIC_LCD
	STA IIC_addr
	JSR IIC_DataWrite
	JSR Delay
	BRA EXIT2

;subroutine that branches for out of bounds error
secondjump1:
	BRA second

;continuation to the redrum subroutine
EXIT2:
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
	LDA Redrum
	CBEQA #1, redrum	
	LDA #0
	STA Flag
	BRA mainLoop2
	mainLoop3:
	BRA mainLoop2
	
;if two is pressed, send the data to the slaves of the system
second:
	LDA #1
	STA msgLength
	CLRH
	CLRX
	JSR Delay	
	LDA Number
	STA IIC_msg
	LDA IIC_LCD
	JSR IIC_DataWrite
	JSR Delay
	LDA Number
	STA IIC_msg
	LDA IIC_LED
	JSR IIC_DataWrite
	JSR Delay
	LDA #0
	STA IIC_msg
	LDA #%10010000
	STA IIC_addr
	JSR IIC_DataWrite
	JSR Delay

	LDA #1
	STA Redrum
	
;if the redrum flag is set, the data is ready to be read	
redrum1:
	JSR Delay
	LDA #%10010001
	STA IIC_addr
	JSR IIC_DataWrite
	
	JSR Delay
	JSR Delay
	JSR alrightthissucks
	
	LDA IIC_LCD
	STA IIC_addr 	
	JSR IIC_DataWrite

	;if buttons are pressed, stop rading data and branch
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
	LDA Redrum
	CBEQA #1, redrum1
	
	LDA #0
	STA Flag
	BRA mainLoop3

;loop that takes the correct temperature from the necessary bits from the LM92 temperature register
alrightthissucks:
	CLRX
	MOV #0, GODWHY
	LDA IIC_msg, x
	STA GODWHY
	LDA GODWHY
	LSLA
	STA GODWHY
		
	INCX
	LDA IIC_msg, x
	AND #%10000000
	STA IIC_msg, x
	
	LDA IIC_msg, x
	LSRA
	LSRA
	LSRA
	LSRA
	LSRA
	LSRA
	LSRA
	ADD GODWHY
	STA GODWHY
	LDA GODWHY
	CLRX
	STA IIC_msg, x
	RTS
	
;loop that compares the total keypad press to get corresponding button
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
	INCA
	
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
	
	BSET 5, IICC ;set master mode
	BSET IICC_TX, IICC
	STA IICD
	
	RTS
	

;delay loops of varying lenght to be implemented when needed
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

;keyboard press interrupt that triggers when keypad is pressed
Column:
	LDA #0
	STA Redrum ;reset the button press flag
	JSR DebugBounce
	LDA #1
	STA Flag ;set the flag for the keypad interrupt
	
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

	BSET 2, KBISC
	
	RTI



