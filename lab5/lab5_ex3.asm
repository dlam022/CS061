;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 5, ex 3
; Lab section: 023
; TA: Shirin
; 
;=================================================
.orig x3000
	
ERROR_LOOP
	LD R7, check			;checking if the first input is b
	ADD R0, R0, R7			;if the ascii number equal to 0, then it is b, if not, try again
	BRz INPUT_LOOP			;go back to input and keep going if r0 is 0, which mean it is b
	LD R0, NEWLINE2			
	OUT
	LEA R0, ERROR			;output error code saying it is not b
	PUTS
	LD R0, NEWLINE2
	OUT
	BRnzp STARTING_LOOP		;start the code after b is inputed into the console
CHECK_NOT_ZERO				;loop for checking if the input is 1
	ADD R6, R6, #-1			;-1 to make r6 = -48 since 1 is 49 so -1 to -48 to make it -49
	ADD R5, R0, R6			;should equal zero
	BRz RETURN_LOOP			;if zero, go back to loop, if not, go to invalid loop
	
CHECK_NOT_ONE
	LD R6, ASCII			;reset ascii to -48
	ADD R5, R0, R6			;48 is 0 so should be zero if input is 0
	BRz RETURN_LOOP			;return loop
INVALID_LOOP				;if not 1 or 0
	LD R0, NEWLINE2			
	OUT
	LEA R0, DOAGAIN			;output string to tell user to input again
	PUTS
	
CHECK_SPACE
	ADD R1, R1, #1		;add 1 to the counter to ignore
	BRnzp INPUT_LOOP	;go back to input loop
	
STARTING_LOOP
	LD	R1, max			;counter
	AND	R4,R4,#0		;this will get the input
INPUT_LOOP
	GETC				;get input from user
	OUT					;to see the input and compare
	ADD	R1,R1,#-1		;decrease counter
	ADD	R2,R1,#-16		;-16 to take away the b in front
	ADD	R2,R2,#0		;add itself to find out if r2 is zero
	BRz ERROR_LOOP		;go to error loop if 0
;	BRz	INPUT_LOOP		;if zero, go look again

	LD R7, CHARR		;gets the value -32, 32 is space
	ADD R6, R0, R7		;if it is 0, then go to check space
	BRz CHECK_SPACE

	LD R6, ASCII		;checking 1
	ADD R5, R0, R6		;convert ascii to decimal
	BRnp CHECK_NOT_ZERO
	
	ADD R6, R6, #-1		;checking 0
	ADD R5, R0, R6		;convert ascii to decimal
	BRnp CHECK_NOT_ONE
	
RETURN_LOOP
	ADD R5, R0, R6
	ADD	R3,R1,#0			;put the counter into r3
	LD	R2,ASCII			;ascii number
	ADD	R0,R0,R2			;convert ascii to decimal


SHIFT_LOOP2	
	ADD	R3,R3,#0		;getting the counter from r1
	BRz	AFTER_LOOP	;if zero, go to post compute
	ADD	R0,R0,R0		;bit shift
	ADD	R3,R3,#-1		;decrease 1 to the counter
	BRp	SHIFT_LOOP2		;go to loop two if the counter is positive
AFTER_LOOP
	ADD	R4,R4,R0		;puts the input into register 4
	ADD	R1,R1,#0		;gets the counter
	BRp	INPUT_LOOP			;back to loop if counter is positive

	ADD	R2,R4,#0		;move the final value to R2
	ADD R1,R2,#0		;puts input into r1 to begin outputing in subroutine
	
	
LD	R3,SUB_BIT_ADDRESS_3200			;subroutine register
LD	R0,NEWLINE2			;newline after the input for the output
OUT						;out the newline on console
JSRR R3					;goes to subroutine to output the final value without b

	HALT

	

;-------------
; LOCAL DATA
;-------------
max					.FILL	#17
ASCII				.FILL	#-48
SUB_BIT_ADDRESS_3200			.FILL	x3200
NEWLINE2			.FILL	#10
check			.FILL	#-98
ERROR		.STRINGZ	"first input is not b"
DOAGAIN		.STRINGZ	"ONLY 0 OR 1"
CHARR			.FILL	#-32

;----------------------------------------------------------------------------------------
; Subroutine: SUB_BITS_PTR_3200
; Parameter: none, getting value from user
; Postconditions: the subroutine gets the 17 ascii character from the user
;				  and transform it into a single 16-bit value which is store into r2
; Return Value: having the bit-value store in R2 when the subroutine is done
;---------------------------------------------------------------------------------------
.orig x3200

;backup any register the subroutine is changing
ST R7, BACKUP_R7_3200
ST R0, BACKUP_R0_3200
ST R1, BACKUP_R1_3200
ST R4, BACKUP_R4_3200



LD R3, ascii				;switch decimal to ascii
LD R4, SPACE_COUNTER		;counts down from 4 in order to add a space






FIRST_LOOP					;like an if else statment
	ADD 	R1, R1, #0		;using value in register
	BRzp	IS_POSITIVE		;checking if value is negative, go to negative loop
	ADD 	R1, R1, #0		;using value in the register
	BRn 	IS_NEGATIVE		;checking if value is positve, go to positive loop

SHIFT_LOOP
	ADD R1, R1, R1			;left shift
	ADD R4, R4, #-1			;checking if 16 bits
	BRp FIRST_LOOP			;if positive, go back to first-loop
	LD R0, newline			;if not, newline and end program
	OUT
	BRnzp PRINT_NEWLINE

IS_NEGATIVE
	AND R0, R0, #0			;setting R0 to 0
	ADD R0, R0, #1			;setting R0 to 1
	ADD R0, R0, R3			;converting decimal to ascii
	OUT						;output '1'
	BRnzp SHIFT_LOOP		;go to the shift loop after
	
IS_POSITIVE
	AND R0, R0, #0
	ADD R0, R0, R3			;converting decimal to ascii
	OUT						;print to console '0'
	BRnzp SHIFT_LOOP		;go to the shift loop after
	

	
	
PRINT_NEWLINE				;end of program

;-------------------------
; restore backup register
;-------------------------	
LD R0, BACKUP_R0_3200
LD R1, BACKUP_R1_3200
LD R4, BACKUP_R4_3200
LD R7, BACKUP_R7_3200

	ret
;----------------------
; subroutine data
;----------------------
BACKUP_R0_3200 	.BLKW 	#1
BACKUP_R1_3200	.BLKW 	#1
BACKUP_R4_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1
ascii 		.FILL 		#48
SPACE_COUNTER	.FILL	#16
newline			.FILL	#10


.END
