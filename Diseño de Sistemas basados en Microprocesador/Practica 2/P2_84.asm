		List 	p=16f84
		include	"P16F84.INC"
                include "lcd.inc"

__CONFIG _WDT_OFF & _RC_OSC


Iter	equ	0x0d
Iter2	equ	0x0e

		org 	0x00
		goto	Inicio


		org		0x05
Menu1	addwf	PCL, F
		retlw	't'
		retlw	'x'
		retlw	't'
		retlw	'1'
		retlw	' '
		retlw	'i'
		retlw	'z'
		retlw	' '
		retlw	't'
		retlw	'x'
		retlw	't'
		retlw	'1'
		retlw	' '
		retlw	'd'
		retlw	'e'
		; Cabe 18 caracteres
		

Menu2	addwf	PCL, F
		retlw	't'
		retlw	'x'
		retlw	't'
		retlw	'2'
		retlw	' '
		retlw	'i'
		retlw	'z'
		retlw	' '
		retlw	't'
		retlw	'x'
		retlw	't'
		retlw	'2'
		retlw	' '
		retlw	'd'
		retlw	'e'

Inicio  
        
;		call LCD_INI
        
;		call DISPLAY_CONF

		movlw 0         	
		movf Iter,1

;		movlw 'h'
;		call LCD_DATO		
;		goto Segundo

;     	movlw b'11000000'
;		call LCD_REG

Imprime          

		movf Iter,0
        
		call Menu1
       
; 		call LCD_DATO
	
		incf Iter,1
		
		;movlw 15
        movlw 0x0e  

		subwf Iter,0
		
        
		btfsc STATUS, Z
		
		goto Segundo 
		;goto Aqui
        ; Imprimimos las segunda línea
        
		goto Imprime

Segundo
		movlw 0         	
		movf Iter2,1

;		movlw b'10000000'
;		call LCD_REG

		
Imprime2  
		movf Iter2,0
        
		call Menu2
      
; 		call LCD_DATO
		
        
		incf Iter2,1
		
		;movlw 15
        movlw 0x0e      

		subwf Iter2,0
		
        
		btfsc STATUS, Z
		
		goto Aqui
        
        
		goto Imprime2
		
Aqui	goto Aqui

		end

