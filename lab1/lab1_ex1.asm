;=================================================
; Name: Derick Lam	
; Email: dlam052@ucr.edu
; 
; Lab: lab 1, ex 1
; Lab section: 23
; TA: Shirin Shirazi
; 
;=================================================
.orig x3000
	;--------------
	;Instructions
	;--------------
	
	AND R1, R1, x0			   ;R1 <- (R1)AND x0000
	LD R2, DEC_12
	LD R3, DEC_6
	
	DO_WHILE_LOOP
		ADD R1, R1, R2         ;R1 <- R1 + R2
		ADD R3, R3, #-1		   ;R3 <- R3 - #1
		BRp DO_WHILE_LOOP      ;if (R3 > 0): goto DO_WHILE_LOOP
	END_DO_WHILE_LOOP
	
	HALT
	;------------
	;Local data
	;------------
	DEC_0	.FILL	#0         	; put #0 into memory here
	DEC_12	.FILL	#12			; put #12 into memory here
	DEC_6	.FILL	#6			; put #6 into memory here
	
.END
