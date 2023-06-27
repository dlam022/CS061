;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 2, ex 3
; Lab section: 023
; TA: Shirin Shirazi
; 
;=================================================
.orig x3000

LD R5, DEC_65	;Loads #65 into register R3
LD R6, HEX_41
LDR R3, R5, #0
LDR R4, R6, #0		;Loads x41 into register R4

ADD R3, R3, #1
ADD R4, R4, #1
STR R3, R5, #0		;Stores #65 to address x4000
STR R4, R6, #0		;Stores x42 to address x4001



HALT				;Terminates the program

;-------------
; Local Data
;-------------
DEC_65 .fill x4000	;Puts address x4000 in memory here
HEX_41 .fill x4001	;Puts address x4001 in memory here

.orig x4000
;-------------
; Remote Data
;-------------

NEW_DEC_65 .FILL #65
NEW_HEX_41 .FILL x41


.END
