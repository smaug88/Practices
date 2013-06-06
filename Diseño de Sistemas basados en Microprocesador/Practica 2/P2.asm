		List 	p=16f876
		include	"P16F876.INC"
                include "lcd.inc"

__CONFIG _WDT_OFF & _RC_OSC

Iter	equ	0x0d

		org 	0x00
		goto	Inicio


		org		0x05
Menu1	addwf	PCL, F
		retlw	'1'
		retlw	' '
		retlw	't'
		retlw	'e'
		retlw	'x'
		retlw	't'
		retlw	'o'
		retlw	' '
		retlw	'A'
		retlw	' '
		retlw	'i'
		retlw	'z'
		retlw	'q'
		retlw	'd'
		retlw	'a'
		retlw	'.'
		retlw	' '
		retlw	' '
		retlw	' '
		retlw	'2'
		retlw	' '
		retlw	't'
		retlw	'e'
		retlw	'x'
		retlw	't'
		retlw	'o'
		retlw	' '
		retlw	'A'
		retlw	' '
		retlw	'i'
		retlw	'z'
		retlw	'q'
		retlw	'd'
		retlw	'a'

Menu2	addwf	PCL, F
		retlw	b'11111100'
		retlw	b'01100000'
		retlw	b'11011010'
		retlw	b'11110010'
		retlw	b'01100110'
		retlw	b'10110110'
		retlw	b'10111110'
		retlw	b'11100000'
		retlw	b'11111110'
		retlw	b'11110110'

Inicio  
        PAGESEL LCD_INI
		call LCD_INI
        PAGESEL DISPLAY_CONF
		call DISPLAY_CONF
		movlw 0  
        BANKSEL Iter 		
		movf Iter,1
		movlw 'h'
		PAGESEL LCD_DATO
		call LCD_DATO
		PAGESEL Aqui
		goto Aqui

Imprime 
        BANKSEL Iter 
		movf Iter,0
        PAGESEL Menu1
		call Menu1
        PAGESEL LCD_DATO
 		call LCD_DATO
		
        BANKSEL Iter 
		incf Iter,1
		
		movlw 37
        
		subwf Iter,0
		
        BANKSEL STATUS
		btfsc STATUS, Z
		PAGESEL Aqui
		goto Aqui
        
        PAGESEL Imprime
		goto Imprime

		PAGESEL Aqui
Aqui	goto Aqui

		end

