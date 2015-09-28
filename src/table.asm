;-----------------------------------------------------------------------
;
; *********************** TABLAS ****************************

; Tabla de gráficos para los niveles. Una por SET gráfico.

; SET 1.
GRTIS1:	defw 0
	defw S1PEQ	; Placa pequeña.
	defw S1HIZ	; placa grande horizontal mitad izquierda.
	defw S1HDE	; placa grande horizontal mitad derecha.
	defw S1VAR	; placa grande vertical mitad superior.
	defw S1VAB	; placa grande vertical mitad inferior.
	defw S1PIE	; Piedra.
	defw S1CASA	; Casa.

; SET 2.
GRTIS2:	defw 0
	defw S2PEQ	; Placa pequeña.
	defw S2HIZ	; placa grande horizontal mitad izquierda.
	defw S2HDE	; placa grande horizontal mitad derecha.
	defw S2VAR	; placa grande vertical mitad superior.
	defw S2VAB	; placa grande vertical mitad inferior.
	defw S2PIE	; Piedra.
	defw S2CASA	; Casa.

;SET 3.
GRTIS3:	defw 0
	defw S3PEQ	; Placa pequeña.
	defw S3HIZ	; placa grande horizontal mitad izquierda.
	defw S3HDE	; placa grande horizontal mitad derecha.
	defw S3VAR	; placa grande vertical mitad superior.
	defw S3VAB	; placa grande vertical mitad inferior.
	defw S3PIE	; Piedra.
	defw S3CASA	; Casa.

;SET 4.
GRTIS4:	defw 0
	defw S4PEQ	; Placa pequeña.
	defw S4HIZ	; placa grande horizontal mitad izquierda.
	defw S4HDE	; placa grande horizontal mitad derecha.
	defw S4VAR	; placa grande vertical mitad superior.
	defw S4VAB	; placa grande vertical mitad inferior.
	defw S4PIE	; Piedra.
	defw S4CASA	; Casa.

;SET 5.
GRTIS5:	defw 0
	defw S5PEQ	; Placa pequeña.
	defw S5HIZ	; placa grande horizontal mitad izquierda.
	defw S5HDE	; placa grande horizontal mitad derecha.
	defw S5VAR	; placa grande vertical mitad superior.
	defw S5VAB	; placa grande vertical mitad inferior.
	defw S5PIE	; Piedra.
	defw S5CASA	; Casa.

;SET 6.
GRTIS6:	defw 0
	defw S6PEQ	; Placa pequeña.
	defw S6HIZ	; placa grande horizontal mitad izquierda.
	defw S6HDE	; placa grande horizontal mitad derecha.
	defw S6VAR	; placa grande vertical mitad superior.
	defw S6VAB	; placa grande vertical mitad inferior.
	defw S6PIE	; Piedra.
	defw S6CASA	; Casa.

;SET 7.
GRTIS7: defw 0
        defw S7PEQ      ; Placa pequeña.
        defw S7HIZ      ; placa grande horizontal mitad izquierda.
        defw S7HDE      ; placa grande horizontal mitad derecha.
        defw S7VAR      ; placa grande vertical mitad superior.
        defw S7VAB      ; placa grande vertical mitad inferior.
        defw S7PIE      ; Piedra.
        defw S7CASA     ; Casa.

;SET 8.
GRTIS8: defw 0
        defw S8PEQ      ; Placa pequeña.
        defw S8HIZ      ; placa grande horizontal mitad izquierda.
        defw S8HDE      ; placa grande horizontal mitad derecha.
        defw S8VAR      ; placa grande vertical mitad superior.
        defw S8VAB      ; placa grande vertical mitad inferior.
        defw S8PIE      ; Piedra.
        defw S8CASA     ; Casa.

; Tabla para almacenar las direcciones de los textos de selección de controles.
CONTAB: defw CONKEY, CONKEM, CONCUR, CONSI1, CONSI2

; Tabla para almacenar las direcciones de los textos de selección de set gráfico.
GRATAB: defw GRAFUT, GRASPE, GRASCR, GRASPR, GRAGRA, GRASUR, GRATOW, GRATUB

; Tabla para almacenar las direcciones de los textos de selección de UNDO SI/NO
UNDTAB:	defw UNDO1TE,UNDO2TE

; Tabla para almacenar las direcciones de los textos de selección de BACKGROUND SI/NO
BACTAB:	defw BACK1TE,BACK2TE

; Tabla para almacenar las direcciones de los textos de selección de MÚSICA SI/NO durante el juego.
MUSTAB: defw MUSI1TE, MUSI2TE


; Tabla en la que se almacenan los valores de las semifilas y bits a leer para el control.
KEYTAB:	defb 223,71,223,79,251,71,253,71,127,71		; OPQA
	defb 0,0,0,0,0,0,0,0,0,0			; Lo dejamos a cero para no complicar los cálculos, Kempston
	defb 239,87,247,103,239,95,239,103,239,71	; Cursor joystick
	defb 239,95,239,103,239,79,239,87,239,71	; Sinclair 1 Joystick
	defb 247,79,247,71,247,95,247,87,247,103	; Sinclair 2 Joystick.

; Tabla en la que se almacenan los caracteres ASCII de las semifilas.
; Al revés del orden habitual para facilitar u manejo por la rutina KEYBOARD.

TABLET:	defm "-ZXCV"
	defm "ASDFG"
	defm "QWERT"
	defm "12345"
	defm "09876"
	defm "POIUY"
	defm "-LKJH"
	defm "--MNB"

; Tabla para la secuencia del final moviendo robotito.
SECEND01:
	defb 1,1,1,3,1,1,3,4,255
SECEND02:
	defb 1,1,1,1,1,1,4,1,1,3,3,3,3,4,4,4,4,2,2,3,2,2,2,2,2,2,2,3,3,3,4,4,4
	defb 2,4,2,2,3,3,3,3,4,1,3,2,4,4,4,1,3,3,4,4,1,1,3,2,1,3,2,4,1,1,1,4,2
	defb 2,2,4,4,2,1,4,2,3,3,2,3,1,1,3,1,1,4,4,4,4,4,2,2,2,1,1,1,3,3,2,4,1
	defb 4,2,2,1,1,3,3,3,2,2,4,4,3,3,3,2,4,1,3,3,1,4,4,1,4,2,3,3,1,1,1,1,4
	defb 4,2,2,2,3,3,1,4,3,1,4,4,3,3,1,1,1,3,3,2,3,4,2,2,3,1,3,2,4,4,1,1,1
	defb 4,4,2,3,4,2,3,4,2,3,2,2,2,3,3,1,4,2,4,1,4,1,1,1,1,1,1,4,4,2,3,2,3
	defb 3,2,4,4,4,4,3,3,1,1,1,3,2,4,2,3,4,1,1,1,1,3,2,1,3,3,2,1,4,4,4,1,1
	defb 3,3,3,3,2,2,4,2,3,1,1,1,4,2,1,4,2,1,4,4,2,3,2,2,3,4,4,2,2,3,1,4,1
	defb 3,2,4,4,4,4,2,3,3,1,1,3,1,1,1,1,4,4,2,2,4,2,1,3,2,1,1,1,3,3,2,4,3
	defb 3,2,2,2,2,2,4,1,3,1,4,3,2,2,2,2,2,2,2,2,2,4,255
SECEND03:
	defb 2,255

; Tabla de direcciones para FONDITO.

FONDOTAB:
	defw 16482, ROBDE1, 16490, S1PIE, 16498, ROBIZ1, 16506, S2PIE
	defw 18498, S3PIE, 18506, ROBAR1, 18514, S4PIE, 18522, ROBAB1
	defw 20514, ROBDE1, 20522, S5PIE, 20530, ROBIZ1, 20538, S6PIE

; Tabla de atributos del robot del menu en juego

ROBOTFONDO:
	defb 68,68,76,76,12,12,12,4,4
	defb 68,76,76,76,12,12,4,12,4
	defb 76,68,76,68,12,12,12,4,12
	defb 76,68,76,68,12,12,12,12,12
	defb 76,76,76,76,12,12,4,4,12
	defb 76,68,68,68,12,4,12,12,4
	defb 76,76,76,76,12,4,12,12,4
