	processor 16f877A
	include<p16f877A.inc>

	org 0
	goto inicio
	org	5
inicio:
	bsf		STATUS,5;Cambiando al Banco 1 Rp0=1 --> bsf[bit set file] register, bit
	clrf	TRISB;Carga ceros en el registro TRISB (TODO SALIDAS PARA PORTB)
	bcf		STATUS,5;Cambiando al BANCO 0 Rp0=0

loop2:
	movlw	H'01';carga en w un 0
	movwf	PORTB;lo que tenga w ponlo en PORTB
	call	retardo;Llamando a la subrutina "retardo"
	clrf	PORTB
	call	retardo	
	goto	loop2


retardo:
	movlw	N
	movwf	reg1
	
loop:
	decfsz	reg1,1
	goto	loop
	return	;Regresa a la siguiente linea de donde fue llamado
	
	end