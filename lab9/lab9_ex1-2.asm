;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 9, ex 1 & 2
; Lab section: 023
; TA: Shirin
; 
;=================================================

; test harness
.orig x3000
		
LD R4, BASE
LD R5, MAX
LD R6, TOS


LOOP
	LEA R0, PUSHPROMPT
	PUTS
	AND R0, R0, #0
	GETC
	OUT
	
	LD R2, ASCII
	ADD R0, R0, R2
	
	LD R1, SUB_STACK_PUSH
	JSRR R1
	
	ADD R3, R3, #0
	BRnz LOOP
	BRp POP_LOOP

POP_LOOP
	LEA R0, POPPROMPT
	PUTS
	
	LD R1, SUB_STACK_POP
	JSRR R1
	ADD R3, R3, #0
	BRnz POP_LOOP
	BRp END_PROGRAM
	
END_PROGRAM

	 
				 
halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
SUB_STACK_PUSH	.FILL	x3200
BASE			.FILL	xA000
MAX				.FILL	xA005
TOS				.FILL	xA000
ASCII			.FILL	#-48
PUSHPROMPT		.STRINGZ	"PUSHVALUE\n"
SUB_STACK_POP	.FILL	x3400
POPPROMPT		.STRINGZ	"POP VALUE\n"

.orig xA000
STACK	.BLKW	#5

;===============================================================================================


; subroutines:

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3200
ST R7, BACKUP_R7_3200
ST R2, BACKUP_R2_3200
;ST R3, BACKUP_R3_3200
;ST R4, BACKUP_R4_3200
;ST R5, BACKUP_R5_3200
;ST R6, BACKUP_R6_3200
ST R1, BACKUP_R1_3200
;ST R0, BACKUP_R0_3200

AND R1, R1, #0
ADD R1, R6, #0	
NOT R1, R1
ADD R1, R1, #1
ADD R1, R1, R5
BRnz ERROR
ADD R6, R6, #1
STR R0, R6, #0
LEA R0, NEWLINE
PUTS
BRnzp END_LOOP

ERROR
	ADD R3, R3, #1
	LEA R0, ERROR_OVERFLOW
	PUTS
END_LOOP
	LD R7, BACKUP_R7_3200
				 
	;LD R0, BACKUP_R0_3200
	LD R1, BACKUP_R1_3200
	LD R2, BACKUP_R2_3200
	;LD R3, BACKUP_R3_3200
	;LD R4, BACKUP_R4_3200
	;LD R5, BACKUP_R5_3200
	;LD R6, BACKUP_R6_3200
				 
				 
				 
ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data
BACKUP_R7_3200	.BLKW	#1
;BACKUP_R0_3200	.BLKW	#1
BACKUP_R1_3200	.BLKW	#1
BACKUP_R2_3200	.BLKW	#1
;BACKUP_R3_3200	.BLKW	#1
;BACKUP_R4_3200	.BLKW	#1
;BACKUP_R5_3200	.BLKW	#1
;BACKUP_R6_3200	.BLKW	#1
ERROR_OVERFLOW	.STRINGZ	"Error:Overflow!\n"
NEWLINE			.STRINGZ		"\n"





;===============================================================================================


;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3400
ST R7, BACKUP_R7_3400
ST R2, BACKUP_R2_3400
;ST R3, BACKUP_R3_3400
;ST R4, BACKUP_R4_3400
;ST R5, BACKUP_R5_3400
;ST R6, BACKUP_R6_3400
ST R1, BACKUP_R1_3400
;ST R0, BACKUP_R0_3400			 

AND R3, R3, #0
AND R1, R1, #0
AND R0, R0, #0

ADD R1, R1, R6
NOT R1, R1
ADD R1, R1, #1
ADD R1, R1, R4
BRz ERROR1

LDR R0, R6, #0
LD R2, ASCII2
ADD R0, R0, R2
OUT
ADD R6, R6, #-1
LEA R0, NEWLINE2
PUTS
BR END_LOOP2

ERROR1
	ADD R3, R3, #1
	LEA R0, POP_UNDERFLOW
	PUTS
	
END_LOOP2
	LD R7, BACKUP_R7_3400
				 
	;LD R0, BACKUP_R0_3400
	LD R1, BACKUP_R1_3400
	LD R2, BACKUP_R2_3400
	;LD R3, BACKUP_R3_3400
	;LD R4, BACKUP_R4_3400
	;LD R5, BACKUP_R5_3400
	;LD R6, BACKUP_R6_3400
				 
				 
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data
BACKUP_R7_3400	.BLKW	#1
;BACKUP_R0_3400	.BLKW	#1
BACKUP_R1_3400	.BLKW	#1
BACKUP_R2_3400	.BLKW	#1
;BACKUP_R3_3400	.BLKW	#1
;BACKUP_R4_3400	.BLKW	#1
;BACKUP_R5_3400	.BLKW	#1
;BACKUP_R6_3400	.BLKW	#1
NEWLINE2		.STRINGZ	"\n"
ASCII2			.FILL	x0030
POP_UNDERFLOW	.STRINGZ	"\nStack is underflowing.\n"


;===============================================================================================
.end
