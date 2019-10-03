;main.s by Josh Harthan
;10/11/18
;Program to introduce "bit banging" I2C on a microcontroller.

	INCLUDE 'derivative.inc'
	XDEF _Startup, main
	XREF __SEG_END_STACK
    
SCL EQU    7 ;clock
SDA    EQU    6 ;data

DACADDR EQU    $01

    ORG    $0060
BitCounter DS.B 1
Value DS.B 1
Direction DS.B 1

    ORG    $E000

	main:
	_Startup:
    	LDA SOPT1 ;load up the SOPT1 register
    	AND #$7F ;and value of SOPT1 by 0111 1111
    	STA SOPT1 ;store the and value into SOPT1 to  turn off watchdog    
    
    Start:    
   	 CLR Value
   	 CLR    BitCounter
   	 CLR Direction
   	 LDA    #$90
   	 STA PTBD
   	 STA PTBDD
   	 
    SendIt:
   	 ;start condition
   	 JSR    I2CStartBit
   	 
   	 ;address byte
   	 LDA #DACADDR
   	 ASLA
   	 JSR I2CTxByte
   	 
   	 ;stop condition
   	 JSR I2CStopBit
   	 
   	 JSR    I2CBitDelay
   	 BRA    SendIt
   	 
    I2CTxByte:
   	 LDX #$08
   	 STX BitCounter
   	 
    I2CNextBit:
   	 ROLA
   	 BCC SendLow
    
    SendHigh:
   	 BSET SDA,PTBD
   	 JSR I2CSetupDelay
   	 
    ;setup:
   	 BSET SCL,PTBD
   	 JSR I2CBitDelay
   	 BRA I2CTxCont
    
    SendLow:
   	 BCLR SDA,PTBD
   	 JSR I2CSetupDelay
   	 BSET SCL,PTBD
   	 JSR I2CBitDelay
   	 
    I2CTxCont:
   	 BCLR SCL,PTBD
   	 DEC BitCounter
   	 BEQ I2CAckPoll
   	 BRA I2CNextBit
   	 
    I2CAckPoll:
   	 BSET SDA,PTBD
   	 BCLR SDA,PTBDD
   	 JSR I2CSetupDelay
   	 BSET SCL,PTBD
   	 JSR I2CBitDelay
   	 BRSET SDA,PTBD,I2CNoAck
   	 BCLR SCL,PTBD
   	 BSET SDA,PTBDD
   	 RTS
   	 
    I2CNoAck:
   	 BCLR SCL,PTBD
   	 BSET SDA,PTBDD
   	 RTS
   	 
    I2CStartBit:
   	 BCLR SDA,PTBD
   	 JSR I2CBitDelay
   	 BCLR SCL,PTBD
   	 RTS
   	 
    I2CStopBit:
   	 BCLR SDA,PTBD
   	 BSET SCL,PTBD
   	 BSET SDA,PTBD
   	 JSR I2CBitDelay
   	 RTS
   	 
    I2CSetupDelay:
   	 NOP
   	 NOP
   	 RTS
    
    I2CBitDelay:
   	 NOP
   	 NOP
   	 NOP
   	 NOP
   	 NOP
   	 RTS
