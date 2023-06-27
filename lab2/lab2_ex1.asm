;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 2. ex 1
; Lab section: lab023
; TA: Shirin Shirazi
; 
;=================================================
.orig x3000
LD R3, DEC_65		;Loads #65 into register R3
LD R4, HEX_41		;Loads x41 into register R4
ST R3, DEC_65		;Stores #65 to address x3000
ST R4, HEX_41		;Stores x42 to address x3001



HALT				;Terminates the program

;-------------
; Local Data
;-------------
DEC_65 .fill #65	;Puts address x4000 in memory here
HEX_41 .fill x41	;Puts address x4001 in memory here


.END



