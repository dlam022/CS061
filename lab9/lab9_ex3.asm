;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 9, ex 3
; Lab section: 023
; TA: Shirin
; 
;=================================================

; test harness
.orig x3000
LD R4, BASE
LD R5, MAX
LD R6, TOS

PUSH_LOOP
	AND R0, R0, #0
	GETC
	OUT
;LEA R0, PUSHPROMPT
;PUTS
;GETC
;OUT
	
;LD R2, ASCII2
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	
	LD R1, SUB_STACK_PUSH
	JSRR R1
	
	ADD R3, R3, #0
	BRnz PUSH_LOOP
	BRp CALL_SUB_MUL
	
CALL_SUB_MUL
	LD R1, SUB_RPN_MULTIPLY
	JSRR R1
	
;LD R0, NEWLINE4
;OUT

;LEA R0, PUSHPROMPT
;PUTS
;GETC
;OUT

;ADD R0, R0, #-12
;ADD R0, R0, #-12
;ADD R0, R0, #-12
;ADD R0, R0, #-12

;LD R3, SUB_STACK_PUSH
;JSRR R3

;LD R0, NEWLINE4
;OUT

;LEA R0, OPERATION_PROMPT
;PUTS
;GETC
;OUT

;LD R0, NEWLINE4
;OUT
	
	
;LD R3, SUB_RPN_MULTIPLY
;JSRR R3
;LD R3, SUB_STACK_POP
;JSRR R3
;ADD R1, R0, #0
;LD R3, SUB_PRINT_DECIMAL_PTR
;JSRR R3
	

	 
				 
			 
				 
				 
halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
SUB_STACK_PUSH	.FILL	x3200
BASE			.FILL	xA000
MAX				.FILL	xA005
TOS				.FILL	xA000
;ASCII2			.FILL	#-48
PUSHPROMPT		.STRINGZ	"PUSH VALUE\n"
SUB_STACK_POP	.FILL	x3400
;OPERATION_PROMPT	.STRINGZ	"ENTER AN OPERATION:\n"
SUB_RPN_MULTIPLY	.FILL	x3600
SUB_PRINT_DECIMAL_PTR	.FILL	x3800
;NEWLINE4				.FILL	'\n'

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

AND R3, R3, #0
AND R1, R1, #0

ADD R1, R6, #0	
NOT R1, R1
ADD R1, R1, #1
ADD R1, R1, R5
BRnz ERROR
ADD R6, R6, #1
STR R0, R6, #0
;LEA R0, NEWLINE
;PUTS
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
;NEWLINE			.STRINGZ		"\n"


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
;LD R2, ASCII2
;ADD R0, R0, R2
;OUT
ADD R6, R6, #-1
;LEA R0, NEWLINE2
;PUTS
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
;NEWLINE2		.STRINGZ	"\n"
;ASCII2			.FILL	x0030
POP_UNDERFLOW	.STRINGZ	"\nStack is underflowing.\n"


;===============================================================================================

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    multiplied them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R6 ← updated TOS address
;------------------------------------------------------------------------------------------
.orig x3600
ST R7, BACKUP_R7_3600
ST R2, BACKUP_R2_3600
ST R3, BACKUP_R3_3600
;ST R4, BACKUP_R4_3600
;ST R5, BACKUP_R5_3600
;ST R6, BACKUP_R6_3600
ST R1, BACKUP_R1_3600
ST R0, BACKUP_R0_3600	

AND R2, R2, #0
AND R3, R3, #0
LD R1, SUB_STACK_POP_PTR
JSRR R1
ADD R2, R2, R0
LD R1, SUB_STACK_POP_PTR
JSRR R1
ADD R3, R3, R0


AND R1, R1, #0
ADD R1, R1, R0
ADD R2, R2, #-1
MULT_LOOP1
	ADD R1, R1, R3 
	ADD R2, R2, #-1
	BRp MULT_LOOP1
	
AND R0, R0, #0
ADD R0, R0, R1
LD R2, SUB_PRINT_DECIMAL
JSRR R2
LD R2, SUB_STACK_PUSH_PTR
JSRR R2



;LD R3, SUB_STACK_POP_PTR
;JSRR R3
;ADD R1, R0, #0
;LD R3, SUB_STACK_POP_PTR
;JSRR R3
;LD R3, SUB_MULTPLY_PTR
;JSRR R3
;LD R3, SUB_STACK_PUSH_PTR
;JSRR R3


	LD R7, BACKUP_R7_3600
				 
	LD R0, BACKUP_R0_3600
	LD R1, BACKUP_R1_3600
	LD R2, BACKUP_R2_3600
	LD R3, BACKUP_R3_3600
	;LD R4, BACKUP_R4_3600
	;LD R5, BACKUP_R5_3600
	;LD R6, BACKUP_R6_3600	
				 
				 
				 
				 
ret
;-----------------------------------------------------------------------------------------------
; SUB_RPN_MULTIPLY local data
BACKUP_R7_3600	.BLKW	#1
BACKUP_R0_3600	.BLKW	#1
BACKUP_R1_3600	.BLKW	#1
BACKUP_R2_3600	.BLKW	#1
BACKUP_R3_3600	.BLKW	#1
;BACKUP_R4_3600	.BLKW	#1
;BACKUP_R5_3600	.BLKW	#1
;BACKUP_R6_3600	.BLKW	#1
SUB_STACK_PUSH_PTR	.FILL	x3200
SUB_STACK_POP_PTR	.FILL	x3400
SUB_PRINT_DECIMAL	.FILL	x3800
SUB_MULTPLY_PTR		.FILL	x4000


;===============================================================================================



; SUB_MULTIPLY		

;.orig x4000
;ST R7, BACKUP_R7_4000
;ST R2, BACKUP_R2_4000
;ST R3, BACKUP_R3_4000
;ST R4, BACKUP_R4_4000
;ST R5, BACKUP_R5_4000
;ST R6, BACKUP_R6_4000
;ST R1, BACKUP_R1_4000
;ST R0, BACKUP_R0_4000	

;ADD R2, R0, #0
;AND R0, R0, x0

;MULT_LOOP
;	ADD R1, R1, #-1
;	BRn END_MULT
;	
;	ADD R0, R0, R2
;	BR MULT_LOOP
;	
;END_MULT

;	LD R7, BACKUP_R7_4000
;				 
;	LD R0, BACKUP_R0_4000
;	LD R1, BACKUP_R1_4000
;	LD R2, BACKUP_R2_4000
;	LD R3, BACKUP_R3_4000
	;LD R4, BACKUP_R4_4000
	;LD R5, BACKUP_R5_4000
	;LD R6, BACKUP_R6_4000
	
;RET


;===
;DATA
;====
;BACKUP_R7_4000	.BLKW	#1
;BACKUP_R0_4000	.BLKW	#1
;BACKUP_R1_4000	.BLKW	#1
;BACKUP_R2_4000	.BLKW	#1
;BACKUP_R3_4000	.BLKW	#1
;BACKUP_R4_4000	.BLKW	#1
;BACKUP_R5_4000	.BLKW	#1
;BACKUP_R6_4000	.BLKW	#1

; SUB_GET_NUM		
;==============
;SUBROUTINE SUB_PRINT_DECIMAL
;this algorithm is suppose to take the number that was put into R1, which was added by 1 in main,
;and output the number to the console. So it is taking the number out of the register and outputing it 
;to the console. Basically a backward algorithm of subroutine 1
;==============
; SUB_PRINT_DECIMAL		Only needs to be able to print 1 or 2 digit numbers. 
;						You can use your lab 7 s/r.

.orig x3800
;ST R1, BACKUP_R1_3800
ST R7, BACKUP_R7_3800
ST R2, BACKUP_R2_3800
ST R3, BACKUP_R3_3800
ST R4, BACKUP_R4_3800
ST R5, BACKUP_R5_3800
ST R6, BACKUP_R6_3800
ST R0, BACKUP_R0_3800

LD R3, COUNTER2
AND R5, R5, #0
AND R4, R4, #0
AND R6, R6, #0
ADD R6, R1, #0					;put the number in register 1 into r6 as temporary

ADD R5, R5, #0					;checking the flag whether it is negative or positve
BRp PRINTNEG		
BRz MINUS_TENTHOUSAND

PRINTNEG						;printing out negative sign if the number is negative
	LD R4, NEGSIGN2
	AND R0, R0, #0
	ADD R0, R0, R4
	OUT
	NOT R1, R1					;2's complement to print out the number
	ADD R1, R1, #1
	ADD R6, R1, #0
	

MINUS_TENTHOUSAND				
	LD R2, MINUS10000			;checking the ten thousand place to see if there is a number
	ADD R1, R1, R2				;minus 10,000 to check the ten thousand place
	BRzp WHILE_LOOP				;if number is zero or positive, go to next loop
	LD R0, ASCII
	ADD R0, R0, R3				;ascii to print out R3
	OUT
	ADD R1, R6, #0				;reset r1 to r6
	LD R3, COUNTER2				;reset counter to 0
	BRnzp MINUS_THOUSAND
	
WHILE_LOOP
	ADD R6, R1, #0				;change r6
	ADD R3, R3, #1				;adding one to the counter. The counter is the one that checks what number is in the ten thousand place, so the loop keeps minusing the number until we get a negative number
	BRnzp MINUS_TENTHOUSAND
	
MINUS_THOUSAND
;	ADD R1, R6, #0
	LD R2, MINUS1000			
	ADD R1, R1, R2				;minus 1000 to check for the hundred place
;	BRn MINUS_HUNDRED
	BRzp WHILE_LOOP2
	LD R0, ASCII
	ADD R0, R0, R3
	OUT
	ADD R1, R6, #0
	LD R3, COUNTER2
	BRnzp MINUS_HUNDRED
	
WHILE_LOOP2
	ADD R6, R1, #0
	ADD R3, R3, #1				
	BRnzp MINUS_THOUSAND
	
MINUS_HUNDRED
;	ADD R1, R6, #0
	LD R2, MINUS100
	ADD R1, R1, R2				;minus 100 to check for the hundred place, keeps looping if the hundred place is high number
;	BRn MINUS_TEN
	BRzp WHILE_LOOP3
	LD R0, ASCII
	ADD R0, R0, R3
	OUT
	ADD R1, R6, #0
	LD R3, COUNTER2
	BRnzp MINUS_TEN
	
WHILE_LOOP3
	ADD R6, R1, #0
	ADD R3, R3, #1
	BRnzp MINUS_HUNDRED
	
MINUS_TEN
;	ADD R1, R6, #0
	LD R2, MINUS10
	ADD R1, R1, R2
	BRzp WHILE_LOOP4
	LD R0, ASCII
	ADD R0, R0, R3
	OUT
	ADD R1, R6, #0
	LD R3, COUNTER2
	BRnzp MINUS_ONE
	
WHILE_LOOP4
	ADD R6, R1, #0
	ADD R3, R3, #1
	BRnzp MINUS_TEN
	
MINUS_ONE
;	ADD R1, R6, #0
	LD R0, ASCII
	ADD R0, R0, R1
	OUT
	BRnzp END2
	
END2
	LD R0, NEWLINE5
	OUT
	
;LD R1, BACKUP_R1_3800
LD R7, BACKUP_R7_3800		 
LD R0, BACKUP_R0_3800
LD R2, BACKUP_R2_3800
LD R3, BACKUP_R3_3800
LD R4, BACKUP_R4_3800
LD R5, BACKUP_R5_3800
LD R6, BACKUP_R6_3800	

RET


;=====
;data
;=====
;BACKUP_R1_3800	.BLKW	#1
BACKUP_R7_3800	.BLKW	#1
BACKUP_R0_3800	.BLKW	#1
BACKUP_R2_3800	.BLKW	#1
BACKUP_R3_3800	.BLKW	#1
BACKUP_R4_3800	.BLKW	#1
BACKUP_R5_3800	.BLKW	#1
BACKUP_R6_3800	.BLKW	#1
ASCII			.FILL	#48
MINUS10000		.FILL	#-10000
MINUS1000		.FILL	#-1000
MINUS100		.FILL	#-100
MINUS10			.FILL	#-10
COUNTER2		.FILL	#0
NEWLINE5		.FILL	#10
NEGSIGN2		.FILL	#45

