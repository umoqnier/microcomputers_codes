	processor 16f877A
	include<p16f877A.inc>

Dato_in		equ H'20'
eval		equ	H'21'
casteado	equ H'22'

	org 0
	goto inicio
	org	5

inicio:
	clrf	eval
	bsf		Dato_in,5 ; Convierte a minuscilas
	call	evaluar
	btfsc	eval,0	  ; Si hay un 0 en la localidad eval salta 
	goto 	letra
	goto 	numero

letra:
	movf	Dato_in,w ; Mueve lo que tenga Dato_in a w
	andlw	H'0F'	  ; Enmascaramiento para obtener el nible bajo
	call	tabla
	movwf	casteado
	goto	fin

numero:
	movf	Dato_in,w ; Mueve lo que tenga Dato_in a w
	andlw	H'0F'	  ; Enmascaramiento para obtener el nible bajo
	movwf	casteado
	goto	fin

tabla:
	addwf	PCL,f
	retlw	H'00'	  ; 00
	retlw	H'0A'	  ; 01
	retlw	H'0B'	  ; 02
	retlw	H'0C'	  ; 03
	retlw	H'0D'	  ; 04
	retlw	H'0E'	  ; 05
	retlw	H'0F'	  ; 06

evaluar:
	movf	Dato_in,w ; Mueve lo que tenga Dato_in a w
	andlw	H'F0'	  ; Enmascaramiento5	
	xorlw	H'30'	  ; Verifica si es numero o letra
	btfss	STATUS,2  ; Si hay un cero [es un 30] salta
	goto	es_letra  
	goto	es_num
	return

es_letra:
	bsf 	eval,0
	goto	reg1
es_num:
	clrf	eval
reg1:
	return

fin:
	end