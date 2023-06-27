;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 5, ex 2
; Lab section: 023
; TA: Shirin
; 
;=================================================
.orig x3000
	
	LD	R1, counter		;counter
	AND	R4,R4,#0		;this will get the input
INPUT_LOOP
	GETC				;get input from user
	OUT					;to see the input and compare
	ADD	R1,R1,#-1		;decrease counter
	ADD	R2,R1,#-16		;-16 to take away the b in front
	ADD	R2,R2,#0		;add itself to find out if r2 is zero
	BRz	INPUT_LOOP			;if zero, go loop again

ADD	R3,R1,#0			;put the counter into r3

LD	R2,ASCII			;ascii number
ADD	R0,R0,R2			;convert ascii to decimal


SHIFT_LOOP2	
	ADD	R3,R3,#0		;getting the counter from r1
	BRz	AFTER_LOOP		;if zero, go to AFTER_LOOP
	ADD	R0,R0,R0		;bit shift
	ADD	R3,R3,#-1		;decrease 1 to the counter
	BRp	SHIFT_LOOP2			;go to loop two if the counter is positive
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
counter				.FILL	#17
ASCII				.FILL	#-48
SUB_BIT_ADDRESS_3200			.FILL	x3200
NEWLINE2			.FILL	#10

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
