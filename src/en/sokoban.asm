; ***********************************
;		SOKOBAN
; 	Compiler Software 2006
; ***********************************

org 24000

jp INTRODUCCION

;-----------------------------------------------------------------------
;-----------------------------------------------------------------------
;********** BUFFER **********

BUFFUNDO:	defs 101  ; Pila de UNDO.

BUFFPANT:	defs 193  ; Buffer de los datos del nivel.

;-----------------------------------------------------------------------
;-----------------------------------------------------------------------
;********** VARIABLES **********

PRATTR:	DEFB 7	; Atributos. Usado por la rutina PRINT y PRINTB. 
PRPOSI: DEFW 0	; Posición en pantalla en baja res. Usado por la rutina PRINT y PRINTB.

SETGR:	DEFB 2	; Set gráfico a emplear, de 0 a 7. INICIAL ES 2

UNDOS:	defb 0	; Permitir Undos en el juego 0=NO 1=SI

CONTROL:DEFB 0	; Modo de control del juego:	0 - Teclado (OPQA)
;						1 - Kempston
;						2 - Cursor
;						3 - Sinclair 1
;						4 - Sinclair 2
	
LEVEL:	defb 1	; Nivel en el que estamos.

BACKGROUND:
	defb 1	; Indica si ponemos textura de fondo en niveles o no. 0=NO 1=SI

GRPIE:	defw 0	; Dirección en memoria de la piedra que se usa en tiempo de juego.

GRCASA:	defw 0	; Dirección en memoria de la casa que se usa en tiempo de juego.

COLPRO:	defb 0	; Columna en la que se encuentra robotito.

LINPRO:	defb 0	; Línea en la que se encuentra robotito.

NUMPIE:	defb 0	; Número de piedras/casas del nivel.

PUNTBU:	defw 0	; Dirección del buffer donde se encuentra el prota.

DIRECC:	defb 0	; Teclas pulsadas para el movimiento del Robotito, bit a 1 significa pulsada:
		;	BIT 0: DERECHA
		;	BIT 1: IZQUIERDA
		;	BIT 2: ABAJO
		;	BIT 3: ARRIBA

SCANCO:	defb 0	; Columna para imprimir en caso de que sea necesarios, de la rutina SCAN.
SCANLI:	defb 0	; Línea para imprimir en caso de que sea necesarios, de la rutina SCAN.

SCANPI:	defb 0	; Guarda el número de piedras que tenemos en las casas, de la rutina SCAN.

SETLEV:	DEFB 0	; Número pseudo-aleatorio para generar el password de carga de niveles.

TEMPPASS: defb 0 ; Almacen temporal del CRC de GENPASS

PASSTEMP: defs 6 ; Almacen temporal para el password una vez desencriptado.

MUSICA: defb 1 ; Indica si suena la música en tiempo de juego o no.

CHEAT:	defb 0

;-----------------------------------------------------------------------
;-----------------------------------------------------------------------
;********** TEXTOS **********

INCLUDE "text.txt"


;-----------------------------------------------------------------------
;-----------------------------------------------------------------------
; *************** NIVELES **************

INCLUDE "levels.txt"


;-----------------------------------------------------------------------
;-----------------------------------------------------------------------
; *************** GRAFICOS **************

INCLUDE "graphs.txt"


;-----------------------------------------------------------------------
;
; *********************** TABLAS ****************************

INCLUDE "table.txt"

;-----------------------------------------------------------------------
;
; INTRODUCCION

INTRODUCCION:

	ld sp, 23999
	xor a
	out (254),a
	call CLS
	
	ld hl, INIT2
        ld (65279),hl
        call 60000
        ld a,254
        ld i,a
        im 2

	call PAUSITA
	ld hl, LOGOCOMPILER
	ld d, 2
	ld e, 12
	call GRAFNO
	ld hl, INTROTEXT
	call PRINTB
	call PAUSITA
	call PAUSITA

	ld hl, 22728
	ld de, 16
	call ROTARATR
	call PAUSITA

	ld hl, 22792
        ld de, 15
        call ROTARATR
        call PAUSITA	

	ld hl, 22856
        ld de, 15
        call ROTARATR
        call PAUSITA

	ld hl, 22920
        ld de, 15
        call ROTARATR
        call PAUSITA

	ld hl, 22984
        ld de, 15
        call ROTARATR
        call PAUSITA

	ld hl, 23048
        ld de, 15
        call ROTARATR
        call PAUSITA

	ld hl, 23112
        ld de, 15
        call ROTARATR
        call PAUSITA

	ld a,21
	ld (LINPRO), a
	ld a, 4
	ld (COLPRO),a
	call DESTACAROBOT
	ld a, 26
	ld (COLPRO),a
	call DESTACAROBOT

	call PAUSITA

	ld d,20
	ld e,9
	ld hl, LOGOSOKO
	call GRAFNO

	ld b,6
INT01:	push bc
	call PAUSITA
	pop bc
	djnz INT01

	jp MENU

; FIN INTRODUCCIÓN
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; PAUSITA: Hace una pausa marcada por hl

PAUSITA:
	ld hl, 20000
PAUSI01:nop
	dec hl
	ld a,h
	or l
	jr nz, PAUSI01
	ret

; FIN PAUSITA
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; ROTARATR: ROTA LOS ATRIBUTOS DE UNA LINEA PARA CREAR UN EFECTO COLORIDO
; ENTRADA:	HL, DIRECCIÓN EN MEMORIA DE ATTR DEL PRIMER CARACTER
;		DE, LONGITUD -1 DE LA LINEA A ROTAR

ROTARATR:
	ld (ROTA03+1),hl
	inc hl
	ld (ROTA04+1),hl
	ld (ROTA05+1),de
	ld bc,4998
	ld a,7
	ld (ROTA02+1),a
ROTA01:	push bc
ROTA03:	ld hl, 0
ROTA04:	ld de, 0
ROTA05:	ld bc, 0
ROTA02:	ld (hl),0
	ldir
	ld a,(ROTA02+1)
	dec a
	jr nz, ROTA06
	ld a,7
ROTA06:	ld (ROTA02+1),a
	pop bc
	dec bc
	ld a,b
	or c	
	jr nz, ROTA01
	ret

; ROTARATR
;
;-----------------------------------------------------------------------

;-----------------------------------------------------------------------
;
; MENU: Pues eso, el menú del juego.
;

ACORRER:
	call 60000
	IM 2
MENU:	ld sp, 23999
	
	xor a
	out (254),a
	call CLS
ME01:	ld hl, LOGOSOKO
        ld de,1033
        call GRAFNO
        ld hl, LEVMEN
        call MAPEA
        ld hl, TEXMEN
        call PRINTB
	im 2
	call STECLA

	

MELOOP:	ld a,247
	in a,(254)

	; Opción comenzar a jugar.
	bit 0,a
	jp z, START

	; Opción cargar nivel.
	bit 1,a
	jp z, INTROPASS

	; Opción pantalla de opciones.
	bit 2,a
	jp z, OPTIONS

	; Muestra los créditos del juego.
	bit 3,a
	jp z, CREDITS



ECS:	ld a, 251
	in a,(254)
	bit 2,a
	jr nz, MELOOP
	ld a, 254
	in a,(254)
	bit 3,a
	jr nz, MELOOP
	ld a, 253
	in a,(254)
	bit 1,a
	jr nz, MELOOP
	ld a, 8
	ld (CHEAT1+1),a
	ld (CHEAT2+1),a
	dec a
	ld (SETGR),a
	ld b,7
ECS1:   push bc
        ld hl,22528
        ld (hl),b
        ld de,22529
        ld bc,767
        ldir
        pop bc
        halt
        halt
        halt
        halt
        djnz ECS1
	ld a,1
	ld (CHEAT),a
	ld a, 195
	ld (ECS),a
	ld hl,MELOOP
	ld (ECS+1),hl
	jp ME01

; FIN MENU
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; OPTIONS: Submenu de opciones.
;

OPTIONS:
	call STECLA
	call CLS

	ld hl, LEVMEN
	call MAPEA

	ld hl, LOGOSOKO
	ld de,1033
	call GRAFNO

	ld hl, TEXOPT
	call PRINTB

	;Ponemos las diferentes selecciones en pantalla.
	ld a,(CONTROL)
	ld bc, CONTAB
	call PRICON

	ld a,(SETGR)
	ld bc,GRATAB
	call PRICON

	ld a,(UNDOS)
	ld bc, UNDTAB
	call PRICON

	ld a,(BACKGROUND)
	ld bc, BACTAB
	call PRICON

	ld a, (MUSICA)
	ld bc, MUSTAB
	call PRICON

OPLOOP:	ld a, 247
	in a,(254)
	bit 0,a
	jr nz, OPT03

	; Selecciona el tipo de control.
OPT01:	call STECLA
	ld a,(CONTROL)
	inc a
	cp 5
	jr nz, OPT02
	xor a
OPT02:	ld (CONTROL),a
	push hl
	push af
	push de
	ld bc, CONTAB
	call PRICON
	call CONTROLK
	pop de
	pop af
	pop hl
	jr OPLOOP

	; Selecciona el SET gráfico.
OPT03:	bit 1,a
	jr nz, OPT05
	call STECLA
	ld a,(SETGR)
	inc a
CHEAT1:	cp 7
	jr nz, OPT06
	xor a
OPT06:	ld (SETGR),a
	push hl
	push af
	push de
	ld bc, GRATAB
	call PRICON
	ld hl, LEVMEN
	call MAPEA
	pop de
	pop af
	pop hl
	jr OPLOOP

	; Selecciona opción de UNDOS.
OPT05:	bit 2,a
	jr nz, OPT08
	call STECLA
	ld a,(UNDOS)
	inc a
	cp 2
	jr nz, OPT07
	xor a
OPT07:	ld (UNDOS),a
	push hl
	push af
	push de
	ld bc, UNDTAB
	call PRICON
	pop de
	pop af
	pop hl
	jp OPLOOP

	; Selecciona opción de background.
OPT08:	bit 3,a
	jr nz, OPTM0
	call STECLA
	ld a,(BACKGROUND)
	inc a
	cp 2
	jr nz, OPT12
	xor a
OPT12:	ld (BACKGROUND),a
	push hl
	push af
	push de
	ld bc, BACTAB
	call PRICON
	pop de
	pop af
	pop hl
	jp OPLOOP

	; Selecciona opción de música.

OPTM0:	bit 4,a
	jr nz, OPT09
	call STECLA
	ld a,(MUSICA)
	inc a
	cp 2
	jr nz, OPTM1
	xor a
OPTM1:	ld (MUSICA),a
	push hl
	push af
	push de
	ld bc, MUSTAB
	call PRICON
	pop de
	pop af
	pop hl
	jp OPLOOP
	
OPT09:	ld a,239
	in a,(254)
	bit 0,a
	jp nz , OPLOOP


	call STECLA
	;IM 1
	;call CLSMENU
	;jp ME01
	jp MENU

; Hace cls de la zona de menu (poniendo a 0 los attr).	

CLSMENU:ld hl, 22790
	ld de, 22791
	ld b,11
CLSME1:	push bc
	push hl
	push de
	ld bc, 24
	ld (hl),0
	ldir
	ld bc,32
	pop hl
	add hl, bc
	ex de, hl
	pop hl
	add hl, bc
	pop bc
	djnz CLSME1
	ret
	
; Imprime el control o el set gráfico seleccionados.
; A: Código.
; BC: Tabla de direcciones de los textos.

PRICON:	ld h,0
	ld l,a
	add hl, hl
	add hl, bc
	ld e,(hl)
	inc hl
	ld d,(hl)
	push de
	pop hl
	jp PRINTB

; FIN OPTIONS
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; DESTACAROBOT: rutina que pone el robot en pantalla al inicio y destaca su posición

DESTACAROBOT:

	ld hl, TERMICOP
	ld b,26
DEST01:	ld de,(COLPRO)
	push bc
	push hl
	call GRAF
	pop hl
	ld de, 36
	add hl, de
	pop bc
	ld de, 7000
DEST02:	dec de
	ld a,d
	or e
	jr nz, DEST02
	djnz DEST01
	
        ld de, (COLPRO)
        ld hl, ROBAB1
        jp GRAF 


; FIN DESTACAROBOT
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; COLORROBOT: Destaca el robot con colores al volver del menu en tiempo de juego

COLORROBOT:
	ld de, (COLPRO)
	ld hl, ROBAB1
	call GRAF
	ld de, (COLPRO)
	call DIRATR
	ld b,3
COLROB2:
	push bc
	ld b,7
COLROB1:
	push hl
	ld a,b
	ld (hl),a
	inc hl
	ld (hl),a
	ld de, 32
	add hl,de
	ld (hl),a
	dec hl
	ld (hl),a
	halt
	halt
	halt
	pop hl
	djnz COLROB1
	pop bc
	djnz COLROB2

	ld de, (COLPRO)
        ld hl, ROBAB1
        jp GRAF

; FIN COLORROBOT
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; MENUGAME: El menu de opciones en tiempo de juego.
;

MENUGAME:

	call CLSMARCO
	ld hl, MARCO
	call PRINTB
	ld hl, 22830
	ld de, ROBOTFONDO
	ld b,7
MENG01:	push bc
	ld b,9
MENG02:	ld a,(de)
	ld (hl),a
	inc hl
	inc de
	djnz MENG02
	ld bc, 23
	add hl,bc
	pop bc
	djnz MENG01
	ld hl,22987
	ld (hl),12
	ld hl, 23019
	ld (hl),12
	inc hl
	ld (hl),12	

	call STECLA

MENG03:	ld a,254
	in a,(254)
	
	; CAMBIAR SET GRAFICO
	bit 1,a
	jr nz, MENG06
	ld a,(SETGR)
        inc a
CHEAT2: cp 7
        jr nz, MENG07
        xor a
MENG07:	ld (SETGR),a
	call CLSMARCO
        ld hl, BUFFPANT
       	call  MAPEA
	ld de, (COLPRO)
	ld hl, ROBAB1
	call GRAF 
	ld b,50
MENG08:	halt
	djnz MENG08
	jr MENUGAME

	; REINICIAR NIVEL
MENG06:	bit 2,a
	jp z, STAR02

	; CONTINUA EL JUEGO
MENG04:	bit 3,a
	jr nz, MENG05
	call CLS2
        ld a,(BACKGROUND)
        and a
        call nz, FONDITO
        ld hl, BUFFPANT
        call MAPEA
;        jp DESTACAROBOT
	jp COLORROBOT

	; SALIR AL MENU
MENG05:	bit 4,a
	jr nz, MENG03
	
	ld a,(MUSICA)
	and a
	jp z, ACORRER
	jp MENU

; FIN MENUGAME
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; CLSMARCO: Borra la zona que vamos a usar como ventana para el menu
; en tiempo de juego y sus atributos los pone a 0
;

CLSMARCO:

	ld b,96
	ld de, 16552
CLSM01:	push bc
	push de
	ld b, 16
	xor a
CLSM02:	ld (de),a
	inc de
	djnz CLSM02
	pop de
	call SIGL
	pop bc
	djnz CLSM01
	ld b,12
	ld hl,22696
CLSM03:	push bc
	ld b,16
CLSM04:	ld (hl),0
	inc hl
	djnz CLSM04
	ld bc,16
	add hl, bc
	pop bc
	djnz CLSM03
	ret

; FIN CLSMARCO
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; STECLA: Espera que se suelte una tecla y retorna.
;

STECLA:	xor a
	in a,(254)
	or 224
	inc a
	jr nz, STECLA
	ret

; FIN STECLA
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; FINAL: Pantalla final del juego cuando se supera el último nivel.
;

FINAL:	ld a,(MUSICA)
	and a
	jr nz, MUSSI
	call 60000
	IM 2
MUSSI:
	
	ld a,(SETGR)
	ld (TEMPPASS),a ; almacenamos temporalmente el juego gráfico en curso.
	xor a
	ld (SETGR),a

	ld (COLPRO),a ; Fijamos la posición del prota.
	ld a,14
	ld (LINPRO),a

	ld hl, LEVEND
	ld de, BUFFPANT ; Puntero al buffer de datos del nivel.
	ld bc, 193
	ldir

	; Ponemos pantalla de "juego"
	call CLS
	ld hl, LEVEND
	call MAPEA

	; Pone el robot en pantalla.
	ld de, (COLPRO)
	ld hl, ROBDE1
	call GRAF	

	; Fijamos el puntero en el buffer al robotito.
	ld hl, BUFFPANT+112
	ld (PUNTBU), hl

	; Colocamos la dirección del gráfico que hace de piedra.
	ld hl, S1PIE
	ld (GRPIE),hl

	; Ponemos Logo
	ld hl, LOGOSOKO
	ld de,9
	call GRAFNO

	; "Trucamos" la rutina de movimiento para que nos retorne.
	ld a,201
	ld (DERHA1),a
	ld (DERHA2),a
	ld (DERHA3),a
	ld (IZQHA1),a
	ld (IZQHA2),a
	ld (IZQHA3),a
	ld (ABJHA1),a
	ld (ABJHA2),a
	ld (ABJHA3),a
	ld (ARRHA1),a
	ld (ARRHA2),a
	ld (ARRHA3),a
	ld (SCAN),a

	ld hl, SECEND01
	call FINLOP

	ld hl, ROBOT01
	call PRINTB

	ld b, 250
FINL01:	halt
	djnz FINL01
	
	ld hl, SECEND02
	call FINLOP

	ld hl, ROBOT02
	call PRINTB

	ld d,14
	ld e,4
	ld hl, ROBOTDEDO
	call GRAFNO

	ld b,250
FINL02:	halt
	djnz FINL02

	ld hl, ROBOT03
	call PRINTB
	ld hl, ROBOT04
	call PRINTB

	ld b,250
FINL03:	halt
	djnz FINL03

	ld hl, ROBOT03
	call PRINTB

	ld hl, SECEND03
	call FINLOP

	ld hl,CAQUITA
	ld de,3588
	call GRAFNO

	ld hl, SECEND03
	call FINLOP

	ld hl, ROBOT05
	call PRINTB	

	; Imprimimos logo final.
	ld hl, LOGOFINAL
	ld de,1
	call GRAFNO

	ld bc,600
FINL04:	halt
	dec bc
	ld a,b
	or c
	jr nz,FINL04

	; Dejamos la rutina de movimiento original
	ld a,195
	ld (DERHA1),a
	ld (DERHA2),a
	ld (DERHA3),a
	ld (IZQHA1),a
	ld (IZQHA2),a
	ld (IZQHA3),a
	ld (ABJHA1),a
	ld (ABJHA2),a
	ld (ABJHA3),a
	ld (ARRHA1),a
	ld (ARRHA2),a
	ld (ARRHA3),a
	ld a,62
	ld (SCAN),a
	
	; Set gráfico seleccionado.
	ld a,(TEMPPASS)
	ld (SETGR),a

	jp MENU

	;Subrutina para mandar los movimientos al robot en la secuencia final
	; Entrada: HL dirección de la tabla con los movs.
	; 1-der 2-izq 3-Arr 4-Abj 255-fin
FINLOP:	ld a,(hl)
	cp 255
	ret z
	push hl
	cp 1
	jr nz, FINLO01
	call MOVDER
	jr FINLO04
FINLO01:cp 2
	jr nz, FINLO02
	call MOVIZQ
	jr FINLO04
FINLO02:cp 3
	jr nz, FINLO03
	call MOVARR
	jr FINLO04
FINLO03:call MOVABJ
FINLO04:pop hl
	inc hl
	jr FINLOP

; FIN FINAL
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; INTROPASS: Acepta la introducción del password para comenzar por determinado nivel.
;

INTROPASS:
	call STECLA
	;im 1
	call CLS

	ld hl, LEVMEN
	call MAPEA

	ld hl, LOGOSOKO
	ld de,1033
	call GRAFNO

INPA00:	ld hl, EPASSTEX
	call PRINTB
	ld hl, COPYTE
	call PRINTB

	ld hl, EPCUR
	call PRINTB

	ld hl,PASSASCII
	ld b,6
INPA01:	push bc
	push hl
INPA02:	call KEYBOARD
	ld d,a
	sub 64
	jp m, INPA02
	ld a,d
	;add a,175
	;jr z, INPA02
	;ld a,d
	pop hl
	sub 65
	ld (hl),a
	inc hl
	push hl
	ld h,0
	ld l,d
	call PRINT
	pop hl
	pop bc
	djnz INPA01

	; Comprobamos si el password es válido.
	ld hl, PASSASCII
	ld b,4
	xor a
INPA03:	add a,(hl)
	inc hl
	djnz INPA03
	xor 44
	push af
	call INPA0
	ld h,a
	pop af
	cp h
	jr z, LOADLEVEL

	
	ld b,7
INPE01:	ld a,b
	add a,64
	ld (EPASETEX+4),a
	push bc
	ld hl, EPASETEX
	call PRINTB
	halt
	halt
	halt
	pop bc
	djnz INPE01

	call PAUSITA
	call PAUSITA

	xor a
	ld (EPASETEX+4),a
	ld hl, EPASETEX
	call PRINTB
	ld a,67
	ld (EPASETEX+4),a
	
	ld hl, EPMENU
	call PRINTB

	call STECLA
	
INPA05:	ld a,127
	in a,(254)
	bit 2,a
	jp z, MENU
	bit 3,a
	jr nz, INPA05
	xor a
	ld (EPMENU+4),a
	ld hl, EPMENU
	call PRINTB
	ld a,67
	ld (EPMENU+4),a
	jp INPA00	
	

LOADLEVEL:
	
	ld hl, PASSASCII
	call INPA0
	ld (LEVEL),a
	jp STAR02

INPA0:	ld a,(hl)
	inc hl
	sla (hl)
	sla (hl)
	sla (hl)
	sla (hl)
	or (hl)
	inc hl
	ret

; FIN INTROPASS
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; GENPASS: Genera el password para los niveles incluyendo, nivel siguiente y set de niveles + CRC de ambos
;
; La clave tiene 6 bytes de longitud, y se conforma de la siguiente forma:
;	Byte 0 y 1: Fase
;	Byte 2 y 3: Número pseudo-aleatorio
;	byte 4 y 5: CRC

GENPASS:
	xor a
	ld (TEMPPASS),a
	ld hl, PASSASCII
	ld de, LEVEL
	call GENPA0
	ld a,r
	ld (SETLEV),a
	ld de, SETLEV
	call GENPA0

	; Genera el CRC
	push hl
	ld hl, PASSASCII
	ld b,4
	xor a
CRC01:	add a,(hl)
	sub 65
	inc hl
	djnz CRC01
	pop hl
	xor 44
	ld (TEMPPASS),a

	ld de , TEMPPASS

GENPA0:	ld a,(de)
	and 15
	add a, 65
	ld (hl),a
	inc hl
	ld a, (de)
	and 240
	srl a
	srl a
	srl a
	srl a
	add a,65
	ld (hl),a
	inc hl
	ret

; FIN GENPASS
;
;-----------------------------------------------------------------------

;-----------------------------------------------------------------------
;
; CONTROLK: Pone los valores apropiados para la lectura del teclado o de los
; Joystick's según seleccionemos.
;

CONTROLK:
	ld a, (CONTROL)
	cp 1 ; si es Kempston retorna sin hacer nada.
	ret z	
	ld d, 0
	ld e, a
	ld bc,10
	call MULTIPLI
	ld bc, KEYTAB
	add hl, bc
	ld a,(hl)
	ld (DER01+1), a
	inc hl
	ld a,(hl)
	ld (DER02+1),a
	inc hl
	ld a,(hl)
	ld (IZQ01+1), a
	inc hl
	ld a,(hl)
	ld (IZQ02+1),a
	inc hl
	ld a,(hl)
	ld (ARR01+1), a
	inc hl
	ld a,(hl)
	ld (ARR02+1),a
	inc hl
	ld a,(hl)
	ld (ABA01+1), a
	inc hl
	ld a,(hl)
	ld (ABA02+1),a
	inc hl
	ld a, (hl)
	ld (FUE01+1),a
	inc hl
	ld a, (hl)
	ld (FUE02+1),a
	ret

; FIN CONTROLK
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; UNDOR: Hace undo cuando lo solicitas.
;
; Códigos almacenados en la pila:	BIT 1: Movimiento Derecha
;					BIT 2: Movimiento Izquierda
;					BIT 3: Movimiento Arriba
;					BIT 4: Movimiento Abajo
;					Bit 7 a 1: Además de movimiento, empujas caja.

UNDOR:	ld a,(CONTROL)
	cp 1
	jr nz, UNDORB
UNDORA:	in a,(31)
	bit 4,a
	jr nz,UNDORA
	
UNDORB:	ld a,(UNDOS)
	and a
	ret z
	ld a,(BUFFUNDO) ; Mira a ver si tenemos movimientos en la pila para rectificar, si es 0 retorna.
	and a
	ret z
	
; UNDO A LA DERECHA.
	ld a,(BUFFUNDO)
	bit 0,a
	jr z, UNDER2
	push af
	call MENOSUNDO ; Subimos la pila	
	ld hl, (PUNTBU) ; actualizamos contenido del buffer y puntero.
	ld (hl),0
	dec hl
	ld (hl), 252
	ld (PUNTBU), hl

	ld de, (COLPRO)
	call DIRATR
	ld (hl),0
	inc hl
	ld (hl),0
	ld bc,31
	add hl, bc
	ld (hl),0
	inc hl
	ld (hl),0
	ld de, (COLPRO)
	dec e
	dec e
	ld (COLPRO), de
	ld hl, ROBDE1
	call GRAF
	pop af
	bit 7,a
	jr nz, UNDER1
	jp SCAN

	
UNDER1:	ld hl, (PUNTBU)
	inc hl
	ld (hl), 6
	inc hl
	ld (hl),0
	ld de,(COLPRO)
	inc e
	inc e
	push de
	inc e
	inc e
	call DIRATR
	ld (hl),0
	inc hl
	ld (hl),0
	ld bc,31
	add hl, bc
	ld (hl),0	
	inc hl
	ld (hl),0
	pop de
	ld hl, (GRPIE)
	call GRAF 
	jp SCAN
	
; UNDO A LA IZQUIERDA.
UNDER2:	ld a,(BUFFUNDO)
	bit 1,a
	jr z, UNDER4
	push af
	call MENOSUNDO ; Subimos la pila	
	ld hl, (PUNTBU) ; actualizamos contenido del buffer y puntero.
	ld (hl),0
	inc hl
	ld (hl), 252
	ld (PUNTBU), hl

	ld de, (COLPRO)
	call DIRATR
	ld (hl),0
	inc hl
	ld (hl),0
	ld bc,31
	add hl, bc
	ld (hl),0
	inc hl
	ld (hl),0
	ld de, (COLPRO)
	inc e
	inc e
	ld (COLPRO), de
	ld hl, ROBIZ1
	call GRAF
	pop af
	bit 7,a
	jr nz, UNDER3
	jp SCAN
	
UNDER3:	ld hl, (PUNTBU)
	dec hl
	ld (hl), 6
	dec hl
	ld (hl),0
	ld de,(COLPRO)
	dec e
	dec e
	push de
	dec e
	dec e
	call DIRATR
	ld (hl),0
	inc hl
	ld (hl),0
	ld bc,31
	add hl, bc
	ld (hl),0	
	inc hl
	ld (hl),0
	pop de
	ld hl, (GRPIE)
	call GRAF
	jp SCAN

; UNDO ARRIBA.
UNDER4:	ld a,(BUFFUNDO)
	bit 2,a
	jr z, UNDER6
	push af
	call MENOSUNDO ; Subimos la pila	
	ld hl, (PUNTBU) ; actualizamos contenido del buffer y puntero.
	ld (hl),0
	ld bc,16
	add hl, bc
	ld (hl), 252
	ld (PUNTBU), hl

	ld de, (COLPRO)
	call DIRATR
	ld (hl),0
	inc hl
	ld (hl),0
	ld bc,31
	add hl, bc
	ld (hl),0
	inc hl
	ld (hl),0
	ld de, (COLPRO)
	inc d
	inc d
	ld (COLPRO), de
	ld hl, ROBAR1
	call GRAF
	pop af
	bit 7,a
	jr nz, UNDER5
	jp SCAN
	
UNDER5:	ld hl, (PUNTBU)
	ld bc, 16
	sbc hl, bc
	ld (hl), 6
	sbc hl,bc
	ld (hl),0
	ld de,(COLPRO)
	dec d
	dec d
	push de
	dec d
	dec d
	call DIRATR
	ld (hl),0
	inc hl
	ld (hl),0
	ld bc,31
	add hl, bc
	ld (hl),0	
	inc hl
	ld (hl),0
	pop de
	ld hl, (GRPIE)
	call GRAF 
	jp SCAN

; UNDO ABAJO.
UNDER6:	ld a,(BUFFUNDO)
	bit 3,a
	ret z
	push af
	call MENOSUNDO ; Subimos la pila	
	ld hl, (PUNTBU) ; actualizamos contenido del buffer y puntero.
	ld (hl),0
	ld bc,16
	sbc hl, bc
	ld (hl), 252
	ld (PUNTBU), hl

	ld de, (COLPRO)
	call DIRATR
	ld (hl),0
	inc hl
	ld (hl),0
	ld bc,31
	add hl, bc
	ld (hl),0
	inc hl
	ld (hl),0
	ld de, (COLPRO)
	dec d
	dec d
	ld (COLPRO), de
	ld hl, ROBAB1
	call GRAF
	pop af
	bit 7,a
	jr nz, UNDER7
	jp SCAN
	
UNDER7:	ld hl, (PUNTBU)
	ld bc, 16
	add hl, bc
	ld (hl), 6
	add hl,bc
	ld (hl),0
	ld de,(COLPRO)
	inc d
	inc d
	push de
	inc d
	inc d
	call DIRATR
	ld (hl),0
	inc hl
	ld (hl),0
	ld bc,31
	add hl, bc
	ld (hl),0	
	inc hl
	ld (hl),0
	pop de
	ld hl, (GRPIE)
	call GRAF 
	jp SCAN

; FIN UNDOR
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; MASUNDO: Desciende la pila para añadir una nueva entrada al UNDO, perdiendo la última añadida.

MASUNDO:
	ld hl, BUFFUNDO+99
	ld de, BUFFUNDO+100
	ld bc, 100
	lddr
	ret

; FIN MASUNDO
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; MENOSUNDO: Asciende la pila y añade al final un 0 cuando hacemos UNDO

MENOSUNDO:
	ld hl, BUFFUNDO+1
	ld de, BUFFUNDO
	ld bc, 100
	ldir
	xor a
	ld (BUFFUNDO+100),a
	ret

; FIN MENOSUNDO
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; DELUNDO: Borra la pila de UNDO

DELUNDO:
	ld hl, BUFFUNDO
	ld de, BUFFUNDO+1
	ld bc, 99
	ld (hl),0
	ldir
	ret

; FIN DELUNDO
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; DEGRADADO: Hace un degradado a 0 de pantalla.
; Rutina tomada de MicroHobby Especial N7

DEGRADADO:

	ld b,8
ESPEBO:	ld hl, 23295
	halt
	halt
BUBO:	ld a,(hl)
	ld d,a
	and 7
	jr z, YACE
	dec a
YACE:	ld e,a
	ld a,d
	and 56
	jr z, TAMCE
	sub 8
TAMCE:	or e
	xor d
	and 63
	xor d
	ld (hl),a
	dec hl
	ld a,h
	cp 88
	jr nc, BUBO
	djnz ESPEBO
	ret

; FIN DEGRADADO
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; START: Comienzas a jugar.
;

START:	ld a,(MUSICA)
	and a
	jr nz, MUSICASI
	call 60008
	IM 1
MUSICASI:
	ld a,1 ; CAMBIAR POR 1 EN LA COMPILACIÓN DEFINITIVA
	ld (LEVEL),a

	; Entrada cuando cambias de nivel.
STAR02:	CALL DELUNDO ; Borramos la pila de UNDO
	CALL CLS
	ld b,0
	ld a,(LEVEL)
	ld c,a
	ld hl,0
STARN1:	ld de, 8
	add hl, de
	dec bc
	ld a,b
	or c
	jr nz, STARN1
	sbc hl, de
	ld b, h
	ld c, l
STARN2:	ld hl, LEVELDAT
	add hl, bc
	push hl
	pop ix ; en IX tenemos un puntero a la tabla de datos del nivel.
	ld l,(ix+0)
	ld h,(ix+1)
	
	;GUARDA LOS DATOS DEL MAPEADO EN EL BUFFER APROPIADO.
	push hl
	ld de, BUFFPANT ; Puntero al buffer de datos del nivel.
	ld bc, 193
	ldir

	ld a,(BACKGROUND)
	and a
	call nz, FONDITO

	pop hl
	call MAPEA	

	; Vuelca posición del prota y otros datos a sus variables.
	ld de, COLPRO
	push ix
	pop hl
	inc hl
	inc hl
	ld bc, 3
	ldir

	; Pone el robot en pantalla.
	call DESTACAROBOT

	; Calculamos el puntero a la dir de Robot en Offset
	
	ld h,0
	ld l,(ix+5)
	ld de,BUFFPANT
	add hl, de
	ld (PUNTBU),hl

LOOPST: ; BUCLE PRINCIPAL DEL JUEGO.
	halt

LOOPS0:
	xor a
	ld (DIRECC),a ; pone los flags de las pulsaciones de tecla a 0=no movimiento.

	; Detecta si está pulsada la tecla E para entrar en el menu en tiempo de juego.
	ld a, 251
	in a,(254)
	bit 2,a
	call z, MENUGAME

CHEATLEVEL:
	ld a,(CHEAT)
	and a
	jr z, LOOPS1
	ld a,254
	in a,(254)
	bit 3,a
	jr nz, LOOPS1
	ld a, 127
	in a, (254)
	bit 3,a
	jr z, LEVELMENOS
	bit 2,a
	jr z, LEVELMAS
	jr LOOPS1
LEVELMENOS:
	ld a,(LEVEL)
	cp 1
	jr z, LOOPS1
	dec a
	ld (LEVEL),a
	jp STAR02
LEVELMAS:	
	ld a,(LEVEL)
        cp 99
        jr z, LOOPS1
        inc a
        ld (LEVEL),a
        jp STAR02

LOOPS1:	call CONTROLES
	ld a,(DIRECC)
	and a
	jp z, LOOPST ; si no hay pulsación sigue el bucle

MUEVE:	ld de,2500 ;3500 sin música
MUEV01:	dec de
	ld a,d
	or e
	jr nz, MUEV01
	ld a, (DIRECC)
	bit 0,a
	jr nz, MOVDER
	bit 1,a
	jp nz, MOVIZQ
	bit 2,a
	jp nz, MOVABJ	
	bit 3,a
	jp nz, MOVARR
	bit 4,a
	jp z, LOOPST
	call UNDOR
	call STECLA
	jp LOOPST

;Mueve a la derecha

MOVDER:	ld hl,(PUNTBU)
	inc hl
	ld a,(hl)
	cp 7
	jr z, MIDER1
	cp 0
	jr z, MIDER1
	cp 6
	jr z, MIDER2
DERHA1:	jp LOOPST
MIDER1:	ld (PUNTBU),hl
	ld (hl),252
	dec hl
	ld (hl),0
	
	; almacenamos el moviemiento en la pila de UNDO
	call MASUNDO
MIDER3:	ld a, 1
	ld (BUFFUNDO),a
	ld a, 1
	ld (MIDER3+1),a
	
	call MOVDR
DERHA2:	jp LOOPST
MIDER2:	inc hl ; vemos si podemos mover la piedra
	ld a,(hl)
	cp 0
	jr z, MIDEPI
	cp 7
	jr z, MIDEPI
DERHA3:	jp LOOPST
MIDEPI:	ld (hl), 6
	dec hl
	push hl
	ld de,(COLPRO)
	inc e
	inc e
	inc e
	inc e
	ld hl, (GRPIE)
	call GRAF
	pop hl
	ld a, 129
	ld (MIDER3+1),a
	jr MIDER1

MOVDR:	ld de,(COLPRO)
	inc e
	ld hl,	ROBDE1
	call GRAF
	ld de, (COLPRO)
	call DIRATR
	ld (hl),0
	ld bc,32
	add hl, bc
	ld (hl),0
	halt
	halt 
	ld de, (COLPRO)
	inc e
	inc e
	ld hl, ROBDE2
	ld (COLPRO), de
	call GRAF
	ld de, (COLPRO)
	dec e
	call DIRATR
	ld (hl),0
	ld bc, 32
	add hl, bc
	ld (hl),0
	halt
	halt
	call SCAN	

	ret

MOVIZQ:	ld hl,(PUNTBU)
	dec hl
	ld a,(hl)
	cp 7
	jr z, MIZQ1
	cp 0
	jr z, MIZQ1
	cp 6
	jr z, MIZQ2
IZQHA1:	jp LOOPST
MIZQ1:	ld (PUNTBU),hl
	ld (hl),252
	inc hl
	ld (hl),0

	; almacenamos el moviemiento en la pila de UNDO
	call MASUNDO
MIIZQ3:	ld a, 2
	ld (BUFFUNDO),a
	ld a, 2
	ld (MIIZQ3+1),a

	call MOVIZ
IZQHA2:	jp LOOPST
MIZQ2:	dec hl ; vemos si podemos mover la piedra
	ld a,(hl)
	cp 0
	jr z, MIZPI
	cp 7
	jr z, MIZPI
IZQHA3:	jp LOOPST
MIZPI:	ld (hl), 6
	inc hl
	push hl
	ld de,(COLPRO)
	dec e
	dec e
	dec e
	dec e
	ld hl, (GRPIE)
	call GRAF
	pop hl
	ld a, 130
	ld (MIIZQ3+1),a
	jr MIZQ1

MOVIZ:	ld de,(COLPRO)
	dec e
	ld hl,	ROBIZ1
	call GRAF
	ld de, (COLPRO)
	inc e
	call DIRATR
	ld (hl),0
	ld bc,32
	add hl, bc
	ld (hl),0
	halt
	halt 
	ld de, (COLPRO)
	dec e
	dec e
	ld hl, ROBIZ2
	ld (COLPRO), de
	call GRAF
	ld de, (COLPRO)
	inc e
	inc e
	call DIRATR
	ld (hl),0
	ld bc, 32
	add hl, bc
	ld (hl),0
	halt
	halt
	call SCAN	

	ret

MOVABJ:	ld hl,(PUNTBU)
	ld bc, 16
	add hl, bc
	ld a,(hl)
	cp 7
	jr z, MABJ1
	cp 0
	jr z, MABJ1
	cp 6
	jr z, MABJ2
ABJHA1:	jp LOOPST
MABJ1:	ld (PUNTBU), hl
	ld (hl),252
	sbc hl, bc
	ld (hl),0

	; almacenamos el moviemiento en la pila de UNDO
	call MASUNDO
MIABJ3:	ld a, 8
	ld (BUFFUNDO),a
	ld a, 8
	ld (MIABJ3+1),a

	call MOVAB
ABJHA2:	jp LOOPST
MABJ2:	ld bc, 16 ; vemos si podemos mover la piedra
	add hl, bc
	ld a,(hl)
	cp 0
	jr z, MIABPI
	cp 7
	jr z, MIABPI
ABJHA3:	jp LOOPST
MIABPI:	ld (hl), 6
	sbc hl, bc
	push hl
	ld de,(COLPRO)
	inc d
	inc d
	inc d
	inc d
	ld hl, (GRPIE)
	call GRAF
	pop hl
	ld bc,16
	ld a, 136
	ld (MIABJ3+1),a
	jr MABJ1


MOVAB:	ld de,(COLPRO)
	inc d
	ld hl,	ROBAB1
	call GRAF
	ld de, (COLPRO)
	call DIRATR
	ld (hl),0
	inc hl
	ld (hl),0
	halt
	halt 
	ld de, (COLPRO)
	inc d
	inc d
	ld hl, ROBAB2
	ld (COLPRO), de
	call GRAF
	ld de, (COLPRO)
	dec d
	call DIRATR
	ld (hl),0
	inc hl
	ld (hl),0
	halt
	halt
	call SCAN	

	ret

MOVARR:	ld hl,(PUNTBU)
	ld bc, 16
	sbc hl, bc
	ld a,(hl)
	cp 7
	jr z, MARR1
	cp 0
	jr z, MARR1
	cp 6
	jr z, MARR2
ARRHA1:	jp LOOPST
MARR1:	ld (PUNTBU), hl
	ld (hl),252
	add hl, bc
	ld (hl),0

	; almacenamos el moviemiento en la pila de UNDO
	call MASUNDO
MIARR3:	ld a, 4
	ld (BUFFUNDO),a
	ld a, 4
	ld (MIARR3+1),a

	call MOVAR
ARRHA2:	jp LOOPST
MARR2:	ld bc, 16 ; vemos si podemos mover la piedra
	sbc hl, bc
	ld a,(hl)
	cp 0
	jr z, MIARPI
	cp 7
	jr z, MIARPI
ARRHA3:	jp LOOPST
MIARPI:	ld (hl), 6
	add hl, bc
	push hl
	ld de,(COLPRO)
	dec d
	dec d
	dec d
	dec d
	ld hl, (GRPIE)
	call GRAF
	pop hl
	ld bc,16
	ld a, 132
	ld (MIARR3+1),a
	jr MARR1


MOVAR:	ld de,(COLPRO)
	dec d
	ld hl,	ROBAR1
	call GRAF
	ld de, (COLPRO)
	inc d
	call DIRATR
	ld (hl),0
	inc hl
	ld (hl),0
	halt
	halt 
	ld de, (COLPRO)
	dec d
	dec d
	ld hl, ROBAR2
	ld (COLPRO), de
	call GRAF
	ld de, (COLPRO)
	inc d
	inc d
	call DIRATR
	ld (hl),0
	inc hl
	ld (hl),0
	halt
	halt
	call SCAN	

	ret


; FIN START
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; SCAN: Detecta si hay que repintar casas y si hemos colocado todas las piedras en su sitio.
;

SCAN:	ld hl,0
	ld (SCANCO),hl
	xor a
	LD (SCANPI),a
	ld de, BUFFPANT
	ld l, (ix+0)
	ld h, (ix+1)
SCAN1:	ld a,(hl)
	cp 255
	ret z
	ld a, (hl)
	cp 7
	jr nz, SCAN6 ; si no hay "casa" en ese tile continua al siguiente.

	ld a,(de)
	cp 7
	jr z, SCAN6 ; si hay casa y no está machacada en el buffer, retorna sin imprimir

	ld a,(de)
	cp 6
	jr nz, SCAN4
	ld a,(SCANPI)
	inc a
	ld (SCANPI),a
	cp (ix+4)
	jr nz, SCAN4
	
	; Cambiamos de nivel
	JP CAMBIO

SCAN4:	ld a,(de)
	cp 0
	jr nz, SCAN6 ; si no hay nada, imprime la casa

	ld a, 7
	ld (de),a
	push de
	push hl
	ld de,(SCANCO)
	LD HL,(GRCASA)
	call GRAF
	pop hl
	pop de

SCAN6:	inc hl
	inc de
	ld a, (SCANCO)
	inc a
	inc a
	ld (SCANCO),a
	cp 32
	jr z, SCAN5
	jr SCAN1
SCAN5:	xor a
	ld (SCANCO),a
	ld a,(SCANLI)
	inc a
	inc a
	ld (SCANLI),a
	jr SCAN1

; FIN SCAN
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; CAMBIO: Sube el nivel.
;

CAMBIO:
	; Efectillo que cambia el set gráfico pasando por todos antes del avance de nivel.
	ld a, (SETGR)
	push af
	ld b,6
CAMBLO:	push bc
	ld hl, BUFFPANT
	ld a,b
	ld (SETGR),a
	call MAPEA
	halt
	halt
	pop bc
	djnz CAMBLO
	pop af
	ld (SETGR),a

	call CLS

	; Ponemos gráficos de adorno en la pantalla, iguales a menú.
	ld hl, LEVMEN
	call MAPEA

	; Ponemos gráfico LOGO LEVEL
	ld hl, LOGOLEVEL
	ld de,778
	call GRAFNO

	; Ponemos el nivel que hemos pasado con letras LOGO.
	ld h,0
	ld a,(LEVEL)
	ld l,a
	call INT2ASCII
	
	ld a, (ASCII+3)
	sbc a,48
	ld d,0
	ld e,a
	ld bc, 57
	call MULTIPLI
	ld bc,LOGONUMERO
	add hl, bc
	ld de,787
	call GRAFNO

	ld a, (ASCII+4)
	sbc a,48
	ld d,0
	ld e,a
	ld bc, 57
	call MULTIPLI
	ld bc,LOGONUMERO
	add hl, bc
	ld de,789
	call GRAFNO

	ld l,(ix+6)
	ld h,(ix+7)
	call PRINTB

	ld hl, LOGOFINISHED
	ld de,2569
	call GRAFNO

	; Incrementamos el nivel y lo imprimimos en la zona del password	
	ld a, (LEVEL)
	inc a
	ld (LEVEL),a

	cp 100 ; Marca el número total de niveles +1 para llegar al final
	jr z, CAMBL3

	ld h,0
	ld l,a
	call INT2ASCII
	ld hl, SCTLE
	call PRINTB
	ld hl, ASCII+3
	call PRINTB

	ld hl, SCPASS
	call PRINTB

	; Genera Password y lo imprime
	call GENPASS
	ld hl, PASSPRI
	call PRINTB

CAMBL3:	
	; Imprime (c)
	ld hl, COPYTE
	call PRINTB

	call STECLA

CAMBL1:	xor a
	in a,(254)
	or 224
	inc a
	jr z, CAMBL1

	call STECLA

	pop af

	ld a,(LEVEL)
	cp 100 ; cambiar por 100 al meter todos los niveles.
	jp z, FINAL
	ld sp, 23999
	jp STAR02

; FIN CAMBIO
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; CREDITS: Pues eso, los créditos
;

CREDITS:;IM 1
	call CLS
	ld hl, LOGOCRED
	ld de,2304
	call GRAFNO
	ld hl, CREDITE
	call PRINTB
	ld hl, COPYTE
	call PRINTB
	call STECLA
CRE01:	xor a
	in a,(254)
	or 224
	inc a
	jp nz, MENU
	jr CRE01


; FIN CREDITS
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; CLS: Pone la memoria de pantalla y atributos a 0 y hace un degradado
;

CLS:	call DEGRADADO
CLS2:	ld hl, 16384
	ld de, 16385
	ld bc, 6911
	ld (hl),l
	ldir
	ret

; FIN CLS
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; MAPEA: Vuelca a pantalla los tiles del mapeado
;
; Entrada:	HL: Dirección de comienzo de los datos de la pantalla
;
;Códigos especiales:	252:		ROBOT.
;			255: 		Fin de pantalla
;
;Códigos gráficos:	0:	Nada (opaco)
;			1:	Gráfico pequeño.
;			2:	Gráfico grande horizontal (mitad izquierda)
;			3:	Gráfico grande horizontal (mitad derecha)
;			4:	Gráfico grande vertical (mitad superior)
;			5:	Gráfico grande vertical (mitad inferior)
;			6:	Gráfico Piedra.
;			7:	Gráfico Casa.
;			8:	Nada transparente.

MAPEA:	push hl
	ld a,(SETGR) ; calculamos la dirección del set del nivel.
	ld d,0
	ld e,a
	ld bc,16
	call MULTIPLI
	ld bc, GRTIS1
	add hl, bc
	ld (MAPLO2+1),hl ; fin cálculo dirección SET.
	ld bc,12 ; colocamos en GRPIE y GRCASA las direcciones de los gráficos que vamos a usar.
	add hl, bc
	ld a,(hl)
	ld (GRPIE),a
	inc hl
	ld a,(hl)
	ld (GRPIE+1),a
	inc hl
	ld a, (hl)
	ld (GRCASA),a
	inc hl
	ld a,(hl)
	ld (GRCASA+1),a ; fin cálculo para GRPIE y GRCASA
	pop hl
MAPLIN:	ld de,0
MAPLOOP:ld a,(hl)
	cp 255
	ret z
	cp 252
	jr z, MAPCS1
	cp 8
	jr z, MAPCS1
	
	and a
	jr nz, MAPLO1
	push hl
	push de
	call DIRATR
	xor a
	ld (hl),a
	inc hl
	ld (hl),a
	ld de,32
	add hl,de
	ld (hl),a
	dec hl
	ld (hl),a
	pop de
	pop hl
	jr MAPCS1

MAPLO1:	push hl
	push de
	ld h,0
	ld l,a
	add hl, hl
MAPLO2:	ld bc, 0 ; dirección de la tabla de gráficos del set.
	add hl,bc
	push de
	ld e,(hl)
	inc hl
	ld d,(hl)
	ex de, hl
	pop de
	call GRAF
	pop de
	pop hl
MAPCS1:	inc hl
	inc e
	inc e
	ld a,e
	cp 32
	jr nz, MAPLOOP
	ld e,0
	inc d
	inc d
	jr MAPLOOP


; FIN MAPEA
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; GRAF:	Imprime gráficos de 16x16 pixels más sus 4 atributos correspondientes.
; Esta rutina se debe emplear para los tiles y los sprites, ya que es más rápida que la
; de impresión de gráficos normales, como los logos
;
; Entrada:	D: Línea
;		E: Columna
;		HL: Dirección del gráfico en memoria.

GRAF:		push de
		call DIRDF
		ld b, 2
GRAF01:		push bc
		ld b,8
GRAF02:		ld a, (hl)
		ld (de), a
		inc hl
		inc de
		ld a,(hl)
		ld (de),a
		inc hl
		dec de
		inc d
		djnz GRAF02
		dec d
		call SIGL
		pop bc
		djnz GRAF01
		pop de
		push hl
		call DIRATR
		pop de
		ld a,(de)
		ld (hl),a
		inc hl
		inc de
		ld a,(de)
		ld (hl),a
		ld bc,31
		add hl, bc
		inc de
		ld a,(de)
		ld (hl),a
		inc hl
		inc de
		ld a,(de)
		ld (hl),a
		ret

; FIN GRAF
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; GRAFNO:	Imprime gráficos del tamaño indicado más sus atributos correspondientes.
; Esta rutina se empleará para los gráficos de cualquier tamaño a excepción de los tiles
; El gráfico deberá estar precedido de 3 bytes que indican:
;		1: Alto en pixels del gráfico
;		2: Alto en caracteres.
;		3: Ancho en caracteres.
;
; Entrada:	D: Línea
;		E: Columna
;		HL: Dirección del gráfico en memoria.
;
; La rutina se encarga de poner el ancho y alto del gráfico en su lugar correspondiente:
;		GRAFNOAL+1: Alto del gráfico en pixels.
;		GRAFNO03+1: Alto del gráfico en caracteres.
;		GRAFNOAN+1 y GRAFNO05+1: Ancho del gráfico en caracteres.

GRAFNO:		ld a,(hl)
		ld (GRAFNOAL+1), a
		inc hl
		ld a,(hl)
		ld (GRAFNO03+1),a
		inc hl
		ld a,(hl)
		ld (GRAFNOAN+1),a
		ld (GRAFNO05+1),a
		inc hl
		push de
		call DIRDF
GRAFNOAL:	ld b, 0 ; Alto del gráfico en pixels.
GRAFNO01:	push bc
GRAFNOAN:	ld b,0 ; Ancho del gráfico en caracteres
		push de
GRAFNO02:	ld a, (hl)
		ld (de), a
		inc hl
		inc de
		djnz GRAFNO02
		pop de
		call SIGL
		pop bc
		djnz GRAFNO01
		pop de ; imprimir los atributos.
		push hl
		call DIRATR
		pop de
GRAFNO03:	ld b, 0 ; Alto del gráfico en caracteres.
GRAFNO04:	push bc
		push hl
GRAFNO05:	ld b, 0 ; Ancho del gráfico en caracteres.
GRAFNO06:	ld a,(de)
		ld (hl),a
		inc hl
		inc de
		djnz GRAFNO06
		pop hl
		ld bc, 32
		add hl, bc
		pop bc
		djnz GRAFNO04
		ret

; FIN GRAFNO
;
;-----------------------------------------------------------------------




;-----------------------------------------------------------------------
;
;SIGL: Calcula la dirección en pantalla de la siguiente línea a una dada.
;
;	Entrada:	DE: dirección de memoria en la pantalla actual.
;	Salida:		DE: dirección de la siguiente línea.

SIGL:   INC     D
        LD      A,D 
        AND     7 
        RET     NZ 
        LD      A,E 
        ADD     A,32 
        LD      E,A 
        RET     C 
        LD      A,D 
        SUB     8 
        LD      D,A 
        RET

; FIN SIGL
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; DIRDF: CALCULA LA DIRECCIÓN DE PANTALLA EN BASE A COL Y FIL EN BAJA RESOLUCIÓN.
;
; Entrada:	D: Línea
;		E: Columna.
; Salida:	DE: Dirección de pantalla

DIRDF:	ld a,d
	and 24
	add a, 64
	ld b,a
	ld a,d
	rrca
	rrca
	rrca
	and 224
	add a,e
	ld e,a
	ld d,b
	ret

; FIN DIRDF
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; DIRATR: CALCULA LA DIRECCIÓN EN EL ATTR EN BASE A COL Y FIL EN BAJA RESOLUCIÓN.
;
; Entrada:	D: Línea.
;		E: Columna,
; Salida:	HL: Dirección de memoria del atributo.

DIRATR:	ld l,d
	ld h,0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld b,88
	ld c,e
	add hl, bc
	ret

; FIN DIRATR
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; PRINTB: Escribe en pantalla una cadena de caracteres mediante la rutina PRINT.

PRINTB:	ld de,0
PRINTB1:ld a,(hl)
	cp 255
	ret z
	cp 22
	jr nz, PRINTB2
	inc hl
	ld d,(hl)
	inc hl
	ld e,(hl)
	inc hl
	ld (PRPOSI), de
	jr PRINTB1
PRINTB2:cp 16
	jr nz, PRINTB3
	inc hl
	ld a,(hl)
	ld (PRATTR),a
	inc hl
	jr PRINTB1
PRINTB3:inc hl
	push hl
	ld h,0
	ld l,a
	call PRINT
	pop HL
	jr PRINTB1


; FIN PRINTB
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; PRINT: Escribe un caracter con sus atributos en pantalla.

PRINT:	ld bc, CHARSET -256
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, bc
	push hl
	ld de,(PRPOSI)
	call DIRATR
	ld a,(PRATTR)
	ld (hl),a
	pop hl
	push de
	call DIRDF
	ld b,8
PRINTBC	ld a,(hl)
	ld (de),a
	inc d
	inc hl
	djnz PRINTBC
	POP DE
	ld a,e
	inc a
	and 31
	ld e,a
	ld (PRPOSI),de
	ret nz
	inc d
	ld a,d
	cp 24
	ret c
	ld d,0
	ld (PRPOSI),de
	ret 

; FIN PRINT
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; INT2ASCII: Procesa un valor entero y devuelve una cadena ASCII
;
;	Entrada: HL valor.
;	Salida: ASCII cadena de 5 caracteres rellena con ceros a la izquierda
;

INT2ASCII:
	push hl
	ld hl, ASCII
	ld de, ASCII+1
	ld bc, 4
	ld a, 48
	ld (hl),a
	ldir
	pop hl
	ld b,5
	ld de, ASCII+4
INTA01:	push bc
	push de
	ld de, 10
	call DIVIDE
	ld a,e
	add a,48
	pop de
	ld (de),a
	dec de
	pop bc
	djnz INTA01
	ret

; FIN INT2ASCII
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; MULTIPLI: Multiplica DE*BC
;
;	Entrada:	DE: Multiplicando
;			BC: Multiplicador
;	Salida:		HL: Resultado.

MULTIPLI:
	ld hl,0
MULTI01:add hl,de
	dec bc
	ld a,b
	or c
	jr nz, MULTI01
	ret
	
; FIN MULTIPLI
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; DIVIDE: Divide HL/DE
;	Entrada: 	HL Dividendo
;		 	DE Divisor
;	Salida:		HL Cociente
;			DE Resto
;

DIVIDE:	ld c,l
        ld a,h
        ld hl,0
        ld b,16
        or a
DIVI01: rl c
        rla
        rl l
        rl h
        push hl
        sbc hl, de
        ccf
        jr c, DIVI02
        ex (sp), hl
DIVI02: inc sp
        inc sp
        djnz  DIVI01
        ex de, hl
        rl c
        ld l,c
        rla
        ld h,a
        ret

; FIN DIVIDE
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; INIT2: Rutina de interrupciones, toca la música.
;

INIT2:	push af
	push hl
	push bc
	push de
	push ix

	call 60005
INITEND:
	pop ix
	pop de
	pop bc
	pop hl
	pop af
	ei
	RETI

; FIN INIT2
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; KEYBOARD: Explora el teclado, detecta la pulsación de una tecla y devuelve el valor ASCII de la tecla pulsada.
;	Retorno: A = Código ASCII de la letra pulsada. "-" si es tecla de control, espacio o enter

KEYBOARD:
	call STECLA
KEYBO00:ld e,127
	ld b,8
KEYBO01:ld a,e
	in a,(254)
	or 224
	cpl
	ld d,a
	and a
	jr nz, KEYBO03
	rrc e
	djnz KEYBO01
	jr KEYBO00
KEYBO03:srl a
	jr nc, KEYBO03
	jr nz, KEYBOARD ; si solo hay una tecla pulsada continua, en otro caso sigue con el bucle.
KEYBO04:dec b
	ld c,b
	ld b,0
	ld hl,0
	add hl,bc
	add hl,bc
	add hl,bc
	add hl,bc
	add hl,bc
	ld bc, TABLET
	add hl, bc
	ld a,d
KEYBO05:rra
	jr c, KEYBO06
	inc hl
	jr KEYBO05
KEYBO06:ld a,(hl)
	ret
	

; FIN KEYBOARD
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; CONTROLES: Lee el teclado o el joy para el movimiento del personaje en tiempo de juego.
;

CONTROLES:

	ld a, (CONTROL)
	ld b,0 ; para almacenar el valor de las pulsaciones.

KEMPSTON:
	cp 1
	jr nz, KEYBO ; si el control no es Kempston salta a leer teclado.
	in a, (31)
	jr MOVE00

; Detecta las pulsaciones de teclas para el movimiento.
; Tanto de Keyboard, Cursor o Sinclair 1 y 2

KEYBO:	

DERECHA:
DER01:	ld a, 223
	in a,(254)
DER02:	bit 0,a
	jr nz, IZQUIERDA
	set 0,b

IZQUIERDA:
IZQ01:	ld a,223
	in a,(254)
IZQ02:	bit 1,a
	jr nz, ARRIBA
	set 1,b
	
ARRIBA:
ARR01:	ld a, 251
	in a, (254)
ARR02:	bit 0,a
	jr nz, ABAJO
	set 3,b

ABAJO:
ABA01:	ld a, 253
	in a, (254)
ABA02:	bit 0,a
	jr nz, FUEGO
	set 2,b

FUEGO:
FUE01:	ld a, 127
	in a, (254)
FUE02:	bit 0,a
	jr nz, MOVE
	set 4,b

MOVE:	ld a,b
MOVE00:	ld (DIRECC), a
	ret

; FIN CONTROLES
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; ZOOM: Imprime un gráfico de 16x16 al doble de su tamaño, para fondos.
; No sirve si el gráfico cambia de tercio.
;
; Entrada:	DE: dirección de pantalla a imprimir
;		HL: dirección del gráfico.

ZOOM:	ld b, 16
ZOOM01:	push bc
	push de
	ld b,2
ZOOM04:	push bc
	ld a,(hl)
	ld b,2
ZOOM02:	push bc
	ld b,4
	ld c,0
ZOOM03:	rla
	push af
	rl c
	pop af
	rl c
	djnz ZOOM03
	ex af,af'
	ld a,c
	ld (de),a
	inc d
	ld (de),a
	dec d
	ex af,af'
	pop bc
	inc de
	djnz ZOOM02
	inc hl
	pop bc
	djnz ZOOM04
	pop de
	call SIGL
	call SIGL
	pop bc
	djnz ZOOM01
	ret

; FIN ZOOM
;
;-----------------------------------------------------------------------





;-----------------------------------------------------------------------
;
; FONDITO: Pone el fondo de la pantalla de juego.
;

FONDITO:
	ld b,12
	ld hl, FONDOTAB
FOND01:	push bc
	ld e,(hl)
	inc hl
	ld d,(hl)
	inc hl
	ld c,(hl)
	inc hl
	ld b,(hl)
	inc hl
	push hl
	ld h,b
	ld l,c
	call ZOOM
	pop hl
	pop bc
	djnz FOND01

	ld d, 0
	ld e,11
	ld hl, LOGOSOKOPEQ
	call GRAFNO
	ld d, 0
	ld e,22
	ld hl, LOGOSOKOPEQ
	call GRAFNO
	ld d, 22
	ld e,1
	ld hl, LOGOSOKOPEQ
	call GRAFNO
	ld d, 22
	ld e,12
	ld hl, LOGOSOKOPEQ
	call GRAFNO
	
	ld hl, 22528
	ld de, 22529
	ld bc,767
	ld (hl),1
	ldir

	ld de, 0
	ld hl, LOGOSOKOPEQ
	call GRAFNO
	ld d, 22
	ld e, 23
	ld hl, LOGOSOKOPEQ
	call GRAFNO

	ret

; FIN FONDITO
;
;-----------------------------------------------------------------------
