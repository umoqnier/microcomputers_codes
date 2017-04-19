		processor 16f877A
		include <p16f877.inc>

cont_col	equ		H'20'
cont_pos	equ		H'21'
tecla		equ		H'22'
dato		equ		H'23'


		org 	0
		goto 	inicio
		org		5
inicio:
		bsf		STATUS,RP0
		clrf	TRISC ; Configurando como salidas
		movlw	H'FF' 
		movwf	TRISD ; Configurado como entradas
		bcf		STATUS,RP0
loop:
		clrf	cont_col
		clrf	cont_pos
activa_col:
		;activa columna
		movf	cont_col,w
		call	Tabla_Acti
		movwf	PORTC
		;Lee BUS de datos
		movf	PORTD,w
		andlw	H'0F'
		movwf	dato

		;¿Es pos_0?
		btfsc	dato,0
		goto	preg_pos1
		goto	identifica
preg_pos1:
		;¿Es pos_1?
		btfsc	dato,1
		goto	preg_pos2

		incf	cont_pos,f
		goto	identifica
preg_pos2:
		;¿Es pos_2?
		btfsc	dato,2
		goto	preg_pos3

		incf	cont_pos,f
		incf	cont_pos,f
		goto	identifica
preg_pos3:
		;¿Es pos_3?
		btfsc	dato,3
		goto	aumenta_col

		incf	cont_pos,f
		incf	cont_pos,f
		incf	cont_pos,f
		goto	identifica

aumenta_col:
		incf	cont_col,f
		clrf	cont_pos
		btfss	cont_col,2	; Mitiga cuando se pasa el contador a 100
		goto	activa_col
		clrf	cont_col
		goto	activa_col

identifica:
		rlf		cont_col,f
		rlf		cont_col,w	; Doble corrimiento a la izquierda
		iorwf	cont_pos,w	
		call	Tabla		; Regresa el valor posicional en el acumulador w
		movwf	tecla
		goto	loop

Tabla: ; Tabla que retorna la col-pos de la tecla
		addwf	PCL,f
		retlw	H'03'
		retlw	H'07'
		retlw	H'0B'
		retlw	H'0F'
		retlw	H'02'
		retlw	H'06'
		retlw	H'0A'
		retlw	H'0E'
		retlw	H'01'
		retlw	H'05'
		retlw	H'09'
		retlw	H'0D'
		retlw	H'00'
		retlw	H'04'
		retlw	H'08'
		retlw	H'0C'

Tabla_Acti: ; Tabla que retorna la columna activa
		addwf	PCL,f
		retlw	H'0E'
		retlw	H'0D'
		retlw	H'0B'
		retlw	H'07'

		end	

