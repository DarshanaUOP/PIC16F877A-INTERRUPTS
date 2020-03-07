;Author Darshana Ariyarathna	||  darshana.uop@gmail.com  ||	+94774901245
    processor   16f877a		    ; Initialize the processor
    #include    <p16f877a.inc>	    ;Include library

    
    org	0x00;

count1    equ	0x20		    ;name the register adress 0x20 as count1 
count2    equ	0x21		    ;name the register adress 0x21 as count2
count3	  equ	0x22
	  
    goto Main			    ;
	  org	0x04			    ;origin vector of interrupt
    goto	LEDON			    ;interrupt function
	
Main
	CALL	GO_BANK_1	    ;SWITCH TO BANK 1
	    bcf	TRISB,6		    ;RA0  as output
	    bCf	TRISB,7		    ;RB0/INT as output
	    bsf	    OPTION_REG,6    ;Interrupt on rising edge of RB0/INT pin
	    bsf	    INTCON,7	    ;Enable all unmasked interrupts
	    bsf	    INTCON,4	    ;Enables the RB0/INT external interrupt
	CALL	GO_BANK_0
	bcf	    PORTB,7
	bcf	    PORTB,6	   
	CALL	    DELAY
	BSF	    PORTB,6
	CALL	    DELAY
    goto    Main

LEDON
	bcf	    INTCON,7
	bcf	    PORTB,7	   
	CALL	    DELAY
	BSF	    PORTB,7
	CALL	    DELAY
	bcf	    PORTB,7	   
	CALL	    DELAY
	BSF	    PORTB,7
	CALL	    DELAY
	bcf	    PORTB,7	   
	CALL	    DELAY
	BSF	    PORTB,7
	BCF	    INTCON,1
	BSF	    INTCON,7
	RETFIE
	
GO_BANK_0
	BCF	    STATUS,5
        BCF	    STATUS,6
        RETURN
    
GO_BANK_1
	BSF	    STATUS,5
        BCF	    STATUS,6
        RETURN
    
GO_BANK_2
	BCF	    STATUS,5
        BSF	    STATUS,6
        RETURN
    
GO_BANK_3
	BSF	    STATUS,5
        BSF	    STATUS,6
        RETURN
	
DELAY
	decfsz  count1,1	    ;decrese the value of register count1 (0x20) start from b'11111111' (=d'255') to zero and store the new value back in that register 
				    ;if new value is zero it is not execute next instruction [jump to  " decfsz  count2,1 "], otherwise it will execute "goto DELAY" line in bellow
				    ;if once count1 become '0000000' and then decrease it,it comes back to '11111111' = 255,
	goto    DELAY		    ;go back to DELAY
	decfsz  count2,1	    ;it works as count1.
				    
	goto    DELAY		    ;go back to DELAY
	
	RETURN
	end

