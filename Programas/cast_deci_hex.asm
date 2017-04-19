	processor 16f877A
	include<p16f877A.inc>

D_H		equ	H'20' ; Declaracion de constantes
D_M		equ	H'21'
D_L		equ	H'22'
cent	equ	H'30'	
dece	equ	H'31'
unid	equ	H'32'
resu	equ H'35'
count 	equ H'36'
num_hex equ H'40'

	org 0
	goto inicio
	org	5

inicio:
	; Castear
	movf	D_H,w
	andlw	H'0F'
	movwf 	cent

	movf	D_M,w
	andlw	H'0F'
	movwf 	dece

	movf	D_L,w
	andlw	H'0F'
	movwf 	unid

	call	mul_10
	call	mul_100

	; Aqui se hace la suma de todos los registros
	movf	unid,w
	addwf	dece,w
	addwf	cent,w
	movwf	num_hex
fin:
	goto 	fin
	
mul_10:
	movlw	H'09'
	movwf 	count
	movf 	dece,w
loop_10:
	addwf	dece,f
	decfsz	count,f
	goto	loop_10
	return

mul_100:
	movlw	H'63'
	movwf 	count
	movf 	cent,w
loop_100:
	addwf	cent,f
	decfsz	count,f
	goto	loop_10
	return
	
	end