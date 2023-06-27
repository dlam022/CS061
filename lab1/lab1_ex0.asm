;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 1, ex 0
; Lab section: 23
; TA: Shirin Shirazi
; 
;=================================================
.orig x3000
;---------------
; Instructions
;---------------
	LEA R2, LABEL1
	LD R3, LABEL2
	LDR R4, R3, #0
	LDI R5, LABEL3
	
	HALT
;---------------
; Local data
;---------------
	;MSG_TO_PRINT   .STRINGZ   "Hello world!!!\n"
	LABEL1	.FILL	xB100
	LABEL2	.FILL	xC100
	LABEL3	.FILL	xC000
	
.END
	
