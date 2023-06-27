;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 023
; TA: Shirin Shirazi
; 
;=================================================
.orig x3000

LD R5, DATA_PTR		;Loads #65 into register R3
LDR R3, R5, #0
LDR R4, R5, #0		;Loads x41 into register R4

ADD R3, R3, #1
ADD R4, R4, #1

STR R3, R5, #0		;Stores #65 to address x4000
STR R4, R5, #1		;Stores x42 to address x4001



HALT				;Terminates the program

;-------------
; Local Data
;-------------
DATA_PTR .fill x4000	;Puts address x4000 in memory here


.orig x4000
;-------------
; Remote Data
;-------------

NEW_DATA_PTR .FILL #65



.END