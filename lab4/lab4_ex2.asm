;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 4, ex 2
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
	BRnp DO_WHILE_LOOP		;if it isn't non-zero number, end loop
END_WHILE_LOOP

LD R6, DATA_PTR
ADD R6, R6, #6				;R6 points to element 7 (i.e 6)
LDR R2, R6, #0				;increment the 7th element into r2 from r6

LD R6, ASCII
LD R1, DATA_PTR
LD R3, SIZE

OUT_WHILE_LOOP
	LDR R0, R1, #0			;loading value R1 to R0
	ADD R0, R0, R6 			;converting decimal to ascii
	OUT						;output to the console
	ADD R1, R1, #1			;points to the next value
	ADD R3, R3, #-1			;Subtract the size of the array by 1
	BRnp OUT_WHILE_LOOP		;if it isn't a non-zero number, end loop
END_OUT_WHILE_LOOP

LD R0, NEWLINE				;newline after the recent output
OUT

HALT
	


;-------------
;Local Data
;-------------
DATA_PTR .FILL  x4000		;starting at x4000 in memory
NUMBER	.FILL	#0			;fills NUMBER with 0
SIZE	.FILL	#10			;size of the array
ASCII	.FILL	#48			;for switching ascii to decimal
NEWLINE .FILL	'\n'		;newline after the recent output



;------------
;Remote Data
;------------
.orig x4000

ARRAY .BLKW #10				;initialize the empty array of 10

.end
