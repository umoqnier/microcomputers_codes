	processor 16f877++o´,m.
	include <p16f877A.inc>
aux		equ	H'24'
cont	equ	H'25'

	org 0
	goto inicio
	org 5

inicio:
	movlw	H'20'	;Mueve a w = 20
	movwf	FSR		;Mueve w a FSR
	clrf	aux		;Limpia aux
	movlw	H'04'
	movwf	cont	;Mueve w a cont
loop:
	incf	aux,1	;Incrementa aux registro en si mismo [1]	
	movf	aux,0	;Mueve el registro aux al acumuladors [0]
	movwf	INDF	;Mueve w al registro INDF
	incf	FSR,1	;Incrementa el registro FSR en si mismo [1]
	decfsz	cont,1	;Decrementa cont en si mismo y salta si es cero [decrement file skip if zero]
	goto	loop
	goto	fin		
fin:
	goto	fin

	end