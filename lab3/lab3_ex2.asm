;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 3, ex 2
; Lab section: 023
; TA: Shirin Shirazi
; 
;=================================================
.orig x3000
;----------------
;Instruction
;---------------
LD R5, DATA_PTR
LD R2, ARRAY_SIZE

DO_WHILE_LOOP
	TRAP x20
	STR R0, R5, #0
	ADD R5, R5, #1
	ADD R2, R2, #-1
	BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP

HALT


;--------------
;Local Data
;-------------
DATA_PTR	.FILL	x4000
ARRAY_SIZE	.FILL	#10


ARRAY 	.BLKW 	#10

.END
