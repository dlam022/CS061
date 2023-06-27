;=================================================
; Name: Derick Lam	
; Email: dlam052@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 023
; TA: Shirin
; 
;=================================================
.orig x3000

;=============
;Instructions
;=============

LEA R0, PROMPT
PUTS
LD R0, NEWLINE
OUT

AND R1, R1, #0
GETC
OUT

ADD R1, R0, #0

LD R0, NEWLINE
OUT

LD R6, SUBROUTINE_3200
JSRR R6

LEA R0, NUMBEROFONES
PUTS

LD R0, ASCII
ADD R0, R0, R3
OUT

LD R0, NEWLINE
OUT

HALT


;=============
;DATA
;=============
PROMPT		.STRINGZ	"Enter a character: "
NEWLINE		.FILL	#10
SUBROUTINE_3200		.FILL	x3200
NUMBEROFONES		.STRINGZ	"The number of 1's is: "
ASCII				.FILL	#48



;==================================================================================
;SUBROUTINE
;counts the number of binary 1's in the value stored in a given register
;should return the number of binary 1's in the input character in another register
;==================================================================================
.orig x3200

ST R7, BACKUP_R7_3200

LD R3, CNT					;counter for how many 1s in the binary
LD R4, BITCNT				;16 bit binary number counter

FIRST_LOOP
	ADD R1, R1, #0			;R1 is last used
	BRzp ZERO_LOOP			;positive number = 0
	ADD R1, R1, #0			;check R1 again 
	BRn ONE_LOOP			;negative number = 1
	
ZERO_LOOP
	ADD R1, R1, R1			;shift bits to the left
	ADD R4, R4, #-1			;decrement bit counter of 16 bit
	BRz END					;if zero, end loop
	BRp FIRST_LOOP
	
ONE_LOOP
	ADD R1, R1, R1			;shift bits to the left
	ADD R3, R3, #1			;increment counter for 1s 
	ADD R4, R4, #-1			;decrement bit counter
	BRz END 
	BRp FIRST_LOOP
	
END

LD R7, BACKUP_R7_3200

RET

;===============
;SUBROUTINE DATA
;===============
BACKUP_R7_3200		.BLKW	#1
CNT					.FILL	#0
BITCNT				.FILL	#16


.END










