;-----------------------------------------------------------------------
;-----------------------------------------------------------------------
;********** TEXTOS **********

; textos menu.
TEXOPT:	defb 16,4
	defb 22,8,6
	DEFM "1. CONTROLES:"
	defb 22,10,6
	DEFM "2. SET GRiFICO:"
	defb 22,12,6
	defm "3. UNDOS:"
	defb 22,14,6
	defm "4. FONDO:"
	defb 22,16,6
	defm "5. MmSICA:"
	defb 22,18,6
	defm "0. VOLVER AL MENm"
	defb 255

TEXMEN:	defb 16,2
	defb 22,10,9
	DEFM "1. JUGAR"
	defb 22,12,9
	DEFM "2. CARGAR NIVEL"
	defb 22,14,9
	defm "3. OPCIONES"
	defb 22,16,9
	DEFM "4. CRjDITOS"
COPYTE:	defb 16,3
	defb 22,23,4
	defb 91
	defm " COMPILER SOFTWARE 2006"
	DEFB 255

;textos créditos.
CREDITE:defb 16,3
	defb 22,0,25
	DEFM "ClDIGO"
	DEFB 22,3,3
	DEFM "GRiFICOS Y PANTALLA DE CARGA"
	DEFB 22,6,25
	DEFM "MmSICA"
	DEFB 22,9,14
	DEFM "DISEnO DE NIVELES"
	DEFB 22,17,16
	DEFM "AGRADECIMIENTOS"
	DEFB 22,21,5
	DEFM "POR PROBAR Y SUGERIR IDEAS"
	DEFB 16,67
	DEFB 22,1,9
	DEFM "MIGUEL A. GARCkA PRADA"
	DEFB 22,4,15
	DEFM "JAVIER VISPE MUR"
	DEFB 22,7,5
	DEFM "FEDERICO J. iLVAREZ VALERO"
	DEFB 22,10,19
	DEFM "DAVID MURIEL"
	DEFB 22,13,15
	DEFM "JAVIER VISPE MUR"
	DEFB 22,11,15
	DEFM "EVGENY GRIGORIEV"
	defb 22,12,15
	DEFM "DAVID W. SKINNER"
	DEFB 22,14,10
	DEFM "JUAN PABLO LlPEZ-GRAO"
	DEFB 22,15,9
	DEFM "MIGUEL A. GARCkA PRADA"
	DEFB 22,20,10
	DEFM "JUAN PABLO LlPEZ-GRAO"
	DEFB 22,19,10
	DEFM "JOSj LEANDRO NOVELLlN"
	DEFB 22,18,16
	DEFM "JOSETXU MALANDA"
	DEFB 255

CONKEY:	defb 16,68
	defb 22,8,20
	defm "TECLADO   "
	defb 255
CONKEM: defb 16,68
	defb 22,8,20
	defm "KEMPSTON  "
	defb 255
CONCUR: defb 16,68
	defb 22,8,20
	defm "CURSORES  "
	defb 255
CONSI1:	defb 16,68
	defb 22,8,20
	defm "SINCLAIR 1"
	defb 255
CONSI2:	defb 16,68
	defb 22,8,20
	defm "SINCLAIR 2"
	defb 255

GRAFUT:	defb 16,68
	defb 22,10,22
	defm "FUTURIST "
	defb 255
GRASPE:	defb 16,68
	defb 22,10,22
	defm "SPECTRUM "
	defb 255
GRASCR: defb 16,68
	defb 22,10,22
	defm "SCREWS   "
	DEFB 255
GRASPR:	defb 16,68
	defb 22,10,22
	defm "OH,SHIT! "
	defb 255
GRAGRA:	defb 16,68
	defb 22,10,22
	defm "GRAVEYARD"
	defb 255
GRASUR:	defb 16,68
	defb 22,10,22
	defm "SURGEON  "
	defb 255
GRATOW:	defb 16,68
	defb 22,10,22
	defm "THE TOWER"
	defb 255
GRATUB:	defb 16,68
	defb 22,10,22
	defm "KILLTBILL"
	defb 255


UNDO1TE:defb 16,68
	defb 22,12,16
	defm "NO "
	defb 255
UNDO2TE:defb 16,68
	defb 22,12,16
	defm "Sk "
	defb 255

BACK1TE:defb 16,68
	defb 22,14,16
	defm "NO "
	defb 255
BACK2TE:defb 16,68
	defb 22,14,16
	defm "Sk "
	defb 255

MUSI1TE:defb 16,68
	defb 22,16,17
	defm "NO "
	defb 255
MUSI2TE:defb 16,68
	defb 22,16,17
	defm "Sk "
	defb 255

ASCII:	defb 48,48,48,48,48,255	; Cadena donde se almacena la conversión INT a ASCII

; cadena donde se almacena el password de niveles en formato ASCII con posición de impresión y color.
PASSPRI:defb 22,19,13,16,70
PASSASCII:
	defs 6
	defb 255

;Textos del cambio de pantalla:

SCPASS:	defb 22,17,6,16,6
	defm " CLAVE PARA NIVEL "
	defb 255

SCTIN:	defb 22,9,16,16,67,255

SCTIT:	defb 22,9,26,16,67,255

SCUND:	defb 22,10,15,16,67,255

SCUNT:	defb 22,10,25,16,67,255

SCSCLE:	defb 22,11,20,16,67,255

SCTOT:	defb 22,14,20,16,68,255

SCTLE:	defb 22,17,24,16,70,255

; Textos de la pantalla ENTER PASSWORD

EPASSTEX:
	defb 22,9,9,16,66
	defm " TECLEA CLAVE "
	defb 22,11,7,16,66
	defm "PARA CARGAR NIVEL"
	defb 22,13,13,16,6
	defm "______"
	defb 255
EPASETEX:
	defb 22,15,12,16,66
	defm "C L A V E"
	defb 22,17,8
	defm "E R R l N E A !!!"
	defb 255

EPCUR:	defb 22,13,13,16,68,255

EPMENU:	defb 22,15,8,16,67
	defm "  PULSA N PARA  "
	defm 22,17,10
	defm " REINTENTAR "
	defm 22,19,6
	defm "O PULSA M PARA MENm"
	defb 255

; TEXTOS FINAL DE JUEGO CHUPI

ROBOT01:
	defb 22,12,12,16,68
	defm "OH, MIERDA!!"
	defb 22,13,12
	defm "MiS TRABAJO."
	defb 255

ROBOT02:
	defb 22,13,6,16,68
	defm "NO SOY UN ESCLAVO, PERRA"
	defb 22,14,6
	defm "UN REGALITO PARA TI"
	defb 255

ROBOT03:
	defb 22,13,6,16,0
	defm "                        "
	defb 22,14,6
	defm "                        "
	defb 255

ROBOT04:
	defb 22,14,6,16,66
	defm "BRBRBRBRBRB!!!!"
	defb 255

ROBOT05:
	defb 22,14,0,16,0
	defm "  "
	defb 22,15,0
	defm "  "
	defb 255

; Textos de niveles.
LEVTEX:

LEVT01:	defb 22,7,7,16,1
	defm "POR MIGUEL G. PRADA"
	defb 255

LEVT02:	defb 22,7,8,16,1
	defm "POR JAVIER VISPE"
	defb 255

LEVT03:	defb 22,7,6,16,1
	defm "POR EVGENY GRIGORIEV"
	defb 255

LEVT04:	defb 22,7,8,16,1
	defm "POR DAVID MURIEL"
	defb 255

LEVT05: defb 22,7,4,16,1
        defm "POR JUAN PABLO LlPEZ-GRAO"
        defb 255

LEVT06:	defb 22,7,6,16,1
	defm "POR DAVID W. SKINNER"
	defb 255

INTROTEXT:
	defb 16,0
	defb 22,6,12
	defm "PRESENTA"
	defb 22,8,9
	defm "UN PROYECTO DE"
	defb 22,10,9
	defm "MIGUEL G PRADA"
	defb 22,12,15
	defm "Y"
	defb 22,14,8
	defm "JAVIER VISPE MUR"
	defb 22,16,11
	defm "MmSICA  DE"
	defb 22,18,9
	defm "FEDE J iLVAREZ"
	defb 255

MARCO:
	defb 22,5,8,16,7
	defb 96 
	defm "dddddddddddddda"
	defb 22,16,8
	defm "beeeeeeeeeeeeeec"
	defb 22,6,8,102
	defb 22,7,8,102
        defb 22,8,8,102
        defb 22,9,8,102
        defb 22,10,8,102
        defb 22,11,8,102
        defb 22,12,8,102
        defb 22,13,8,102
        defb 22,14,8,102
        defb 22,15,8,102
	defb 22,6,23,103
        defb 22,7,23,103
        defb 22,8,23,103
        defb 22,9,23,103
        defb 22,10,23,103
        defb 22,11,23,103
        defb 22,12,23,103
        defb 22,13,23,103
        defb 22,14,23,103
        defb 22,15,23,103
	defb 22,6,22,16,71,104
	defb 22,6,10,16,70
	defm "SOKOBAN"
	defb 22,8,10,16,68
	defm "Z GRiFICOS"
	defb 22,10,10
	defm "X REINICIAR"
	defb 22,12,10
	defm "C CONTINUAR"
	defb 22,14,10
	defm "V MENm"
	defb 255
