;--------------------------------
;Name: Derick Lam
;Login: dlam052
;Email address: dlam052@ucr.edu
;Assignment: assn1
;Lab Section 023
;TA: Shirin Shirazi

;I attest that this code was
;totally given to me and that I 
;didn't come up with any of it =P
;----------------------------------

;-------------------------------------------
;REG VALUES     R0 R1  R2  R3 R4 R5 R6  R7
;--------------------------------------------
;Pre-loop	     0  6  12  0   0  0  0  1168
;Iteration 01    0  5  12  12  0  0  0  1168
;Iteration 02    0  4  12  24  0  0  0  1168

;Iteration 04    0  3  12  36  0  0  0  1168
;Iteration 05    0  2  12  48  0  0  0  1168
;Iteration 06    0  1  12  60  0  0  0  1168
;End of program  0  0  12  72  0  0  0 	DEC_0
;---------------------------------------------

.ORIG x3000                ;Program begins here
;-------------
;Instructions
;-------------
LD R1, DEC_6			   ;R1 <--6
LD R2, DEC_12              ;R2 <--12
AND R3, R3, x0             ;R3 <--0

DO_WHILE  ADD R3, R3, R2   ;R3 <-- R3 + R2
		  ADD R1, R1, #-1  ;R1 <--R1 - 1
		  BRp DO_WHILE     ;if(LMR > 0) goto DO_WHILE
		  
HALT                       ;Terminate the program
;--------
;Data
;--------
DEC_0     .FILL    #0      ;Put the value 0 into memory here
DEC_6     .FILL	   #6      ;Put the value 6 into memory here
DEC_12    .FILL    #12     ;Put the value 12 into memory here

.END
