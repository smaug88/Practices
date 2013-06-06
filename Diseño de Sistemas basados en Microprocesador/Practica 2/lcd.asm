#include "p16f84.inc"

#define ENABLE       bsf PORTA,2        ;Activa E
#define DISABLE      bcf PORTA,2        ;Desactiva
#define LEER         bsf PORTA,1        ;Pone LCD en Modo RD
#define ESCRIBIR     bcf PORTA,1        ;Pone LCD en Modo WR
#define OFF_COMANDO  bcf PORTA,0        ;Desactiva RS (modo comando)
#define ON_COMANDO   bsf PORTA,0        ;Activa RS

GLOBAL DISPLAY_CONF, BORRA_Y_HOME, LCD_DATO,LCD_REG, LCD_INI

LCDX_S	equ	00h	;Portb es salida en el pic
LCDB_E	equ	0ffh	;Portb es entrada en el pic


lcd_data	udata_ovr
Lcd_Temp_1	res	1	;Para la espera del LCD.
Lcd_Temp_2	res	1	;Para la espera del LCD.


lcd	code
;_-_-_-_-_-_-_-_-_-_-_-_-_ Rutinas de impresión en el LCD -_-_-_-_-_-_-_-_-_-_-_-_-_-
;
;**************************************************************************
;UP_LCD: Configuración PIC para el LCD.
;
UP_LCD  	    
				bsf     STATUS,RP0      ;Banco 1
                clrf    PORTB           ;RB <0-7> salidas digitales
                clrf	PORTA           ;RA <0-7> salidas digitales
                bcf     STATUS,RP0      ;Banco 0
                OFF_COMANDO             ;RS=0
                DISABLE                 ;E=0
                return
;
;**************************************************************************
;LCD_BUSY: Lectura del Flag Busy y la dirección.
;
LCD_BUSY        LEER                    ;Pone el LCD en Modo RD
                bsf     STATUS,RP0
                movlw   H'FF'
                movwf   PORTB           ;Puerta B como entrada
                bcf     STATUS,RP0      ;Selecciona el banco 0
                ENABLE                  ;Activa el LCD
                nop
                btfsc   PORTB,7         ;Chequea bit de Busy
                goto    $-1
                DISABLE                 ;Desactiva LCD
                bsf     STATUS,RP0
                clrf    PORTB           ;Puerta B salida
                bcf     STATUS,RP0
                ESCRIBIR                ;Pone LCD en modo WR
                return

;
;**************************************************************************
;LCD_E: Pulso de Enable
;
LCD_E           ENABLE                  ;Activa E
                nop
                DISABLE                 ;Desactiva E
		nop 
	;	ENABLE
                return
;
;**************************************************************************
;LCD_DATO: Escritura de datos en DDRAM o CGRAM
;
LCD_DATO        call UP_LCD		;Configura los puertos
                movwf   PORTB           ;Valor ASCII a sacar por portb
                call    LCD_BUSY        ;Espera a que se libere el LCD
                ON_COMANDO              ;Activa RS (modo dato).
                goto    LCD_E           ;Genera pulso de E

;**************************************************************************
;LCD_REG: Escritura de comandos del LCD
;W=Código de comando para el LCD
;W ==> portb
;
LCD_REG         call UP_LCD		;Configura los puertos
                movwf   PORTB           ;Código de comando.
                call    LCD_BUSY        ;LCD libre?.
                goto    LCD_E           ;SI.Genera pulso de E.

LCD_REG_2       OFF_COMANDO             ;Desactiva RS (modo comando)
                movwf   PORTB           ;Código de comando.
                goto    LCD_E           ;SI.Genera pulso de E.
;
;**************************************************************************
;LCD_INI_2: inicialización del LCD 
;
LCD_INI
LCD_INI_2	call UP_LCD			;Configura los puertos
		movlw	b'00111000'
		call	LCD_REG_2		;Código de instrucción
		call	LCD_DELAY		;Temporiza
		movlw	b'00111000'
		call	LCD_REG_2		;Código de instrucción
		movlw	d'1'
		call	LCD_DELAY_2		;Temporiza
		movlw	b'00111000'
		call	LCD_REG_2		;Código de instrucción
		movlw	d'1'
		call	LCD_DELAY_2		;Temporiza

;
;**************************************************************************
;BORRA_Y_HOME: Borra el display y retorna el cursor a la posición 0 
;
BORRA_Y_HOME    movlw   b'00000001'     ;Borra LCD y Home.
                call    LCD_REG
                return
;
;**************************************************************************
;DISPLAY_ON_CUR_OFF: Control ON/OFF del display y cursor.
;Activa Display desactiva cursor.

DISPLAY_CONF    call UP_LCD
                movlw   b'00111000'     ;LCD de 2 lineas, caracter 5x7.
                call    LCD_REG	
                movlw   b'00001100'     ;LCD on,cursor off.
                call    LCD_REG
                movlw   b'00000110'     ;LCD autoincremento sin desplazamiento.
                call    LCD_REG
                return

;
;**************************************************************************
;LCD_DELAY: Rutina de temporización de unos 5 mS para W=d'16'
;LCD_DELAY_2: Rutina de temporización a la que le pasamos el parámetro en W
;

LCD_DELAY_2:	goto	Delay_start	
LCD_DELAY:      movlw	.10
Delay_start     movwf	Lcd_Temp_1
                clrf	Lcd_Temp_2
LCD_DELAY_1:	decfsz	Lcd_Temp_2,F
		goto	LCD_DELAY_1
		decfsz	Lcd_Temp_1,F
		goto	LCD_DELAY_1
		return
	end
