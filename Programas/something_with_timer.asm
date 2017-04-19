	processor 16f877A
	include<p16f877A.inc>

	org 	0
	goto 	inicio
	org	5
inicio:
	molw	H'35'
	movwf	T1CON
	
esperar:
	goto	esperar			
	end