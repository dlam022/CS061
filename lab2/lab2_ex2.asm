;=================================================
; Name: Derick Lam	
; Email: dlam052@ucr.edu
; 
; Lab: lab 2, ex 2
; Lab section: 023
; TA: Shirin Shirazi
; 
;=================================================
.orig x3000
LDI R3, DEC_65_PTR		;Loads #65 (indirectly) into register R3
;LDI R4, HEX_41_PTR		;Loads x41 (indirectly) into register R4

;ADD R3, R3, #1
;ADD R4, R4, #1
STI R3, DEC_65_PTR		;Stores #66 (indirectly) to address x4000
;STI R4, HEX_41_PTR		;Stores x52 (indirectly) to address x4001


HALT					;Terminates the program

;-------------
; Local Data
;-------------
DEC_65_PTR .fill xC100	;Puts address x4000 in memory here
;HEX_41_PTR .fill x4001	;Puts address x4001 in memory here

;.orig x4000
;-------------
; Remote Data
;-------------

;NEW_DEC_65 .FILL #65
;NEW_HEX_41 .FILL x41


.END