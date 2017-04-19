processor 16f877
include   <p16f877.inc>

	org 	0 ;Vector reset para poder utilizar push botons
	goto 	inicio
	org 	5

inicio:
	bsf		STATUS,RP0	;Cambio al banco 1 RP0 = 1 y RP1 = 0
	movlw 	H'01'		;Carga en w un cero
	movwf 	TRISB		;Configurando puerto B como b'00000001'
	bcf		STATUS,RP0	;Cambiando al banco 0 RP0 = 0
	
	bcf 	PORTB,7		;Limpia el bit 7 del PORTB
	
pregunta:
	btfsc	PORTB,0
	goto	no_oprimido
	goto	oprimido

no_oprimido:
	bcf		PORTB,7
	goto	pregunta

oprimido:
	bsf		PORTB,7	;Pone '1' en el bit 7 del PORTB
	goto	pregunta
	
	end
 
	
	