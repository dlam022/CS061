;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 6, ex 3
; Lab section: 023
; TA: Shirin
; 
;=================================================
;=============
;main
;===========

(R1) <- xABCD		;(b1010 1011 1100 1101)
[call the right-shift subroutine]
[now (r1) -- x55e6 == b0101 0101 1110 0110]


;===========
;subroutine
;===========

r4 = counter

loop
	take the bit and rotate to the left (b1010 1011 1100 1101)
	most significant number is now the the second bit (b0101 0111 1001 1011)
	have a counter for 15
	keep going through the loop 15 times so that the bits rotate 15 times
	at the end, we would get b1101 0101 1110 0110
	then switch the most significant number to 0 to make it a positive number
	