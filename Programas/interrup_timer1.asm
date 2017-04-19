	processor 16f877A
	include<p16f877A.inc>

	org 	0
	goto 	inicio
	org		4  ; Para el vector de interrupciones
	goto	ISR
	org		5
inicio:
	bsf		STATUS,RP0  ; Cambio al banco 1 para configurar PIE1
	clrf	TRISB  ; Puerto B como salida
	bsf		PIE1,TMR1IE  ; Activando la interrupcion
	; Con fines de simulacion alteramos los registros TMR1L y TMR1H
	movlw	H'FF'
	movwf	TMR1H
	movlw	H'FE'
	movwf	TMR1L
	movlw	H'01'
	movwf	PORTB
	movlw	H'35'
	movwf	T1CON  ; Cuando se desborde el contador ira a org 4
	; Activando interruptores globales
	bsf		INTCON,PEIE
	bsf		INTCON,GIE
	
esperar:
	goto	esperar

ISR:
	; Como sabemos que solo hay una interrupcion no es necesario leer banderas
	bcf		INTCON,GIE	; Desactivando interrupciones
	rlf		PORTB,f 	; Codigo que hace si hay interrupcion, en este caso un corrimiento
	movlw	H'FF'
	movwf	TMR1H
	movlw	H'FE'
	movwf	TMR1L
	bcf		PIR1,TMR1IF		; Limpiando banderas de interrupcion	
	bsf		INTCON,GIE
	goto	esperar
	end