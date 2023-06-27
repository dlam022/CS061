;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 5, ex 1
; Lab section: 023
; TA: Shirin
; 
;=================================================
.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

LD R2, SUB_BIT_PTR_3200	
JSRR R2					;calling the function basically


HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xCB00	; The address where value to be displayed is stored
SUB_BIT_PTR_3200 .FILL x3200

.ORIG xCB00					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.

;----------------------------------------------------------------------------------------
; Subroutine: SUB_BITS_PTR_3200
; Parameter: the parameter is the value, fill with xABCD
; Postconditions: the subroutine gets the 16 bit two's complement binary from the value
; Return Value: 16 bit two's complement binary 
;---------------------------------------------------------------------------------------
.orig x3200					; use the starting address as part of the sub name

;backup r7 or any register the subroutine changes
ST R0, BACKUP_R0_3200
ST R1, BACKUP_R1_3200
ST R4, BACKUP_R4_3200
ST R5, BACKUP_R5_3200
ST R7, BACKUP_R7_3200


;-----------------------
; subroutine algorithms
;-----------------------
LD R3, ASCII				;switch decimal to ascii
LD R4, SPACE_COUNTER		;counts down from 4 in order to add a space
LD R5, SPACE_COUNTER2		;counts down from 16 since there are 16 bits


FIRST_LOOP					;like an if else statment
	ADD 	R1, R1, #0		;using value in register
	BRn		IS_NEGATIVE		;checking if value is negative, go to negative loop
	ADD 	R1, R1, #0		;using value in the register
	BRzp 	IS_POSITIVE		;checking if value is positve, go to positive loop

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
	
SHIFT_LOOP
	ADD R1, R1, R1			;left shift
	ADD R5, R5, #-1			;checking if 16 bits
	BRz PRINT_NEWLINE
	ADD R4, R4, #-1			;decrement counter
	BRz PRINT_SPACE			;if counter is equal to 0
	ADD R0, R5, #0
	BRp FIRST_LOOP			;go back to first loop
	
PRINT_SPACE
	LEA R0, SPACE			;print space
	PUTS
	LD R4, SPACE_COUNTER	;reset the counter to 4
	ADD R1, R1, #0			;reset R1 to 0
	ADD R0, R5, #0			;Check if it hit 0
	BRp FIRST_LOOP			;go back to the first loop
	
	
PRINT_NEWLINE
	LD R0, newline			;end of the program, no more loops
	OUT
	
	
;-------------------------
; restore backup register
;-------------------------
LD R0, BACKUP_R0_3200
LD R1, BACKUP_R1_3200
LD R4, BACKUP_R4_3200
LD R5, BACKUP_R5_3200
LD R7, BACKUP_R7_3200

RET



;----------------------
; subroutine data
;----------------------
BACKUP_R0_3200 	.BLKW 	#1
BACKUP_R1_3200	.BLKW 	#1
BACKUP_R4_3200	.BLKW	#1
BACKUP_R5_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1
ASCII 		.FILL #48
SPACE_COUNTER	.FILL	#4
SPACE_COUNTER2	.FILL	#16
newline			.FILL	#10
SPACE 			.FILL	' '
;---------------	
;END of PROGRAM
;---------------	
.END