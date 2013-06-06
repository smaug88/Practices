;*******************************
;LCD.INC
;ARCHIVO DE CABECERA DE LCD.LIB
;*******************************

EXTERN DISPLAY_CONF, BORRA_Y_HOME, LCD_DATO,LCD_REG, LCD_INI

;*********************************
;LCD_INI: Inicializa el display. Imprescindible ejecutar antes
;         de usar el resto de las rutinas. Sin parametros.
;DISPLAY_CONF: Inicializa el display a dos lineas, cursor des-
;         activado, autoincremento.
;BORRA_Y_HOME: Borra la pantalla y vuelve el punto de entrada a
;         cero.
;LCD_REG: Envía como comando el contenido de w
;LCD_DATO: Envía como dato el contenido de w
;**********************************
;Estas rutinas modifican el estado de los puertos. Usan dos
;registros de memoria


