	processor 16f877A
	include<p16f877A.inc>

N		equ	H'53'
reg1	equ	H'20'
reg2    equ H'21'
reg3	equ H'22'

	org 0
	goto inicio
	org	5

inicio:
	movlw	H'96'
	movwf	reg3
loop_3:
	movlw	H'FF'
	movwf	reg2
loop_2:
	movlw	N
	movwf	reg1
loop_1:
	decfsz	reg1,1
	goto	loop
	decfsz	reg2,1
	goto	loop_2
	decfsz	reg3,1
	goto 	loop_3
	
	nop
	end
