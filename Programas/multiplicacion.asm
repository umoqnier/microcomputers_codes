	processor 16f877A
	include<p16f877A.inc>

ACUM	equ	H'20'
CONT	equ	H'21'
AUX	equ	H'22'


	org 0
	goto inicio
	org	5
inicio:

	clrf	AUX 	; Limpia auxiliar
loop:
	movf	AUX,w 	; Carga lo que tenga aux en w
	addwf	ACUM,w	; Sumale lo que tenga ACUM a w
	movwf	AUX	; Lo que tenga w carglo en AUX
	decfsz	CONT	; Decrementa y salta si es cero
	goto	loop
	goto	fin

fin:
	goto	fin

	end