;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 4, ex 1
; Lab section: 023
; TA: Shirin Shirazi
; 
;=================================================
.orig x3000
LD R5, DATA_PTR			
LD R1, NUMBER
LD R4, SIZE

DO_WHILE_LOOP
	STR R1, R5, #0			;stores value into memory
	ADD R5, R5, #1			;Increment the pointer to point to the next num
	ADD R1, R1, #1			;Add 1 the value to get the next number
	ADD R4, R4, #-1			;Subtract the size by 1
	BRnp DO_WHILE_LOOP		;if it isn't positive or negative, end loop
END_WHILE_LOOP

LD R6, DATA_PTR
ADD R6, R6, #6
LDR R2, R6, #0				;increment the 7th element into r2 from r5

HALT
	


;-------------
;Local Data
;-------------
DATA_PTR .FILL  x4000		;starting at x4000 in memory
NUMBER	.FILL	#0			;fills dec_0 with 0
SIZE	.FILL	#10



;------------
;Remote Data
;------------
.orig x4000

ARRAY .BLKW #10				;initialize the empty array of 10

.end
