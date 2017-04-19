	processor 16f877A
	include <p16f877A.inc>
D1	equ	H'20'
D2	equ	H'21'
Res	equ	H'22'
Aca	equ	H'23'

	org 0
	goto inicio
	org 5

inicio:
	movlw	H'06'	;Cargando a w = 06H
	movwf	D1	;[Move w to a file]Mueve w a D1
	
	movlw	H'02'	;Cargando a w = 02H
	movwf	D2	;[Move w to a file]Mueve w a D2
	;Los datos estan cargados

	movf	D1,0	;Moviendo el registro al acumulador w = D1 [d = 0::w d = 1::D1]
	addwf	D2,0	;Sumando al acumlador un registro w = w + D2
	
	btfss	STATUS,0;Salto si el bit 0 [c] esta encendido del registro STAUS
	goto	no_hubo
	goto	si_hubo

no_hubo:
	movwf	Res	;Res = w
	clrf	Aca	;Limpia el registro Aca
	goto	inicio

si_hubo:
	movwf	Res	;Res = w
	movlw	H'01'	;w = 01H
	mvwf	Aca	;Aca = w Lo que esta en w ponlo en Aca
	goto inicio

	end