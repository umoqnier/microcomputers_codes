;Programa que despliega en dos displays de 7 segmentos con un retardo de 8.33ms
;Uso de 
	processor 16f877A
	include<p16f877A.inc>

N	equ	H'53'
regl	equ	H'20'
resH	equ	H'21'
nL	equ	H'30'
nH	equ	H'31'
reg1 equ H'32'
	org 0
	goto inicio
	org	5

inicio:
	bsf	STATUS,RP0	; Cambio al banco 1
	clrf	TRISB		; Config como salida puerto B
	bcf	TRISD,0		
	bcf	TRISD,1		; Para encender un display a la vez. Limpios en principio
	bcf	STATUS,RP0	; Cambio al banco 0

loop:
	movf	resH,w		; Carga lo que tenga resH en w
	andlw 	H'0F'		; Enmascaramiento para el nemles low
	movwf 	nL		; Carga lo que tenga w en nL [nmles low]
	movf	resH,w
	andlw	H'F0'		; Enmascaramiento para el nemles high
	movwf	nH		; Carga lo que tenga w en nH
	swapf	nH,f		; Cambio de nibles 30H-->03H y dejalo en f [registro]
	
	;ENCENDIDO DEL PRIMER DISPLAY
	movf	nL,w
	call	Tabla
	movwf	PORTB
	bcf	PORTD,1		; Apaga el segundo display
	bsf	PORTD,0		; Enciende el primer display
	;call 	retardo
	;ENCENDIDO DEL SEGUNDO DISPLAY
	movf	nH,w
	call	Tabla
	movwf	PORTB
	bcf	PORTD,0		; Apaga el primer display		
	bsf	PORTD,1		; Enciende el segundo display
	;call 	retardo		; Llamada a la subrutina retardo
	goto 	loop

Tabla:
	addwf	PCL,f
	retlw	H'A0'
	retlw	H'A1'
	retlw	H'A2'
	retlw	H'A3'
	retlw	H'A4'
	retlw	H'A5'
	retlw	H'A6'
	retlw	H'A7'
	retlw	H'A8'
	retlw	H'A9'
	retlw	H'AA'
	retlw	H'AB'
	retlw	H'AC'
	retlw	H'AD'
	retlw	H'AE'
	retlw	H'AF'

retardo:
	movlw	N
	movwf	reg1
	nop
loop1:
	decfsz	reg1,1
	goto    loop1
	goto	loop
	nop

	end
