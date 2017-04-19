	processor 16f877A
	include<p16f877A.inc>

RESH	equ	H'20
		
		org 0
		goto inicio
		org	5

inicio:
	bsf		STATUS,RP0 ; Cambio al banco 1
	clrf	TRISB
	clrf	ADCON1
	bcf	    STATUS,RP0 ;Regreso al banco 0
	
	movlw	H'01'
	movwf	ADCON0 ; Configuracion del ADCON0
convertir:
	bsf		ADCON0,2 ; Pon uno en el bit dos del registro ADCON2 [ORDENA CONVERSION]
pregunta:
	btfsc	ADCON0,2 ; revisa el bit dos y si es 0 salta
	goto	pregunta
	movf	RESH,W ; Mueve lo que tenga ADRESH a w
	movwf	PORTB	 ;Mueve lo que tenga w a PORTB	
	goto	convertir

	end