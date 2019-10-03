;Main.s by Josh Freund, Joshua Harthan
;2/12/19
;Keypad Master Code
		INCLUDE 'derivative.inc'
		XDEF _Startup, main, Column, _Viic
		XREF __SEG_END_SSTACK	;symbol defined by the linker for the end of the stack
	
	
		ORG	$0060
		
RowPress	 DS.B 1
ColumnPress  DS.B 1
Total		 DS.B 1

	;variables in RAM to communicate via I2C
	FullKeypad:	DS.B 1 ;superfluous variable for testing
	IIC_addr:	DS.B 1 ;track IIC address
	msgLength:	DS.B 1 ;track total message length
	current:	DS.B 1 ;track which byte we have sent
	IIC_msg:	DS.B 1 ;enable 32 bit transmission
	


		ORG $E000	
	
	
		
main:

_Startup:

	LDHX #__SEG_END_SSTACK ; initialize the stack pointer
	TXS
	CLI					;clears interrupt flag-enables interrupt
	
	LDA SOPT1			;kill watchdog
	AND #$7F
	STA SOPT1
	
	LDA SOPT2 ;set PTB pins to be used for SDA/SCL
	ORA #%00000010
	STA SOPT2
	
	MOV #$10, IIC_addr ;set slave address
	MOV #$C1, IIC_msg ;set actual message
	


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
	
	JSR IIC_Startup_Master


mainLoop:

	JSR Delay
	LDA #1 ;set message length to 1 byte
	STA msgLength
	JSR IIC_DataWrite ;begin data transfer
	
	;Load up values given keypresses and store them in the PTBD register
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
	
	BRA mainLoop
	

	
	
;Actual Interrupt Start
_Viic:
	;clear interrupt
	BSET IICS_IICIF, IICS
	;check if master
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
	BRA _Viic_master_EoAC
	BCLR IICC_MST, IICC	;no ack from slave received
	RTI

;End of Address Cycle, check for receive or write data 
_Viic_master_EoAC:
	;read from or transfer to slave?
	LDA IIC_addr ;check if read or transfer
	AND #%00000001
	BNE _Viic_master_toRxMode
	
	LDA IIC_msg
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
	STA IIC_msg;, X ;store message into indexed
	
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
	LDA #0 ;initialize current
	STA current
	
	BSET 5, IICC ;IICC_MST, IICC ;set master mode
	BSET IICC_TX, IICC
	LDA IIC_addr ;send slave address
	STA IICD
	
	RTS

;delay loop to be used when neeeded
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

;debounce loop to get rid of debounce when key is pressed
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

;keyboard interrupt that triggers when a key is pressed
Column:

	JSR DebugBounce
	
	LDA PTAD
	AND #%00001111
 	STA ColumnPress
 	
 	NOP
	
	LDA PTBD ;load up value that was pressed by loading up the PTBD register
	LSLA ;logic shift left twice to send data of both row and column
	LSLA
	STA RowPress
	
	LDA RowPress
	ADD ColumnPress ;load up rowpress and columnpress to get value for key in row/column
	STA Total ;total variable that keeps track of both row and column pressed
	STA IIC_msg ;also store value into iic_msg to be sent to slave

	BSET 2, KBISC ;reset keyboard interrupt flag
	
	RTI



