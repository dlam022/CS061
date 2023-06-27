;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 6, ex 1
; Lab section: 023
; TA: Shirin
; 
;=================================================
.ORIG x3000

;=============
;Instruction
;=============
LD R1, ARRAY_ADDRESS
LD R6, SUB_GET_STRING_3200
JSRR R6


HALT


;=====
;DATA
;=====
SUB_GET_STRING_3200		.FILL	x3200
ARRAY_ADDRESS			.FILL	x4000

;============
;Remote Data
;============
ARRAY					.BLKW	#1

;===================================================================================
;Subroutine: SUB_GET_STRING
;Parameter (R1): The starting address of the character array
;Postcondition: The subroutine has prompted the user to input a string,
;				terminated by the [ENTER] key (the "sentinel"), and has stored
;				the received characters in an array of characters starting at (R1)
;				the array is NULL-terminated; the sentinel character is NOT stored.
;Return Value (R5): The number of non-sentinel characters read from the user.
;					R1 contains the starting address of the array unchanged.
;====================================================================================
.ORIG x3200

;========================
;SUBROUTINE INSTRUCTIONS
;========================
ST R7, BACKUP_R7_3200
;ST R5, BACKUP_R5_3200
ST R0, BACKUP_R0_3200
ST R1, BACKUP_R1_3200
ST R2, BACKUP_R2_3200

LEA R0, INTRO
PUTS
LD R0, NEWLINE
OUT

ADD R2, R1, #0
LD R5, COUNTER					;R5 contains the number of non-sentinel characters
LD R3, ASCIINEWLINE				;ascii decimal for enter is 10



GET_STRING
	GETC						;get string from user
	OUT							;output the string
	
	ADD R6, R0, #0				;reset R6
	ADD R6, R6, R3				;checking for user if press enter
	BRz END_STRING				;go to end string with r6 is 0
	
	STR R0, R2, #0				;stores character into the array
	ADD R2, R2, #1				;increment the array address by 1
	ADD R5, R5, #1				;increment the counter
	BRnp GET_STRING				;go back to get_string loop to get another character
	
END_STRING
	LD R3, ENTER				
	STR R3, R2, #0				;stores null at the end of the array
	ADD R5, R5, #0

;========
;BACKUP
;========
LD R7, BACKUP_R7_3200
;LD R5, BACKUP_R5_3200
LD R0, BACKUP_R0_3200
LD R1, BACKUP_R1_3200
LD R2, BACKUP_R2_3200

RET

;===============
;SUBROUTINE DATA
;===============
BACKUP_R7_3200	.BLKW	#1
;BACKUP_R5_3200	.BLKW	#1
BACKUP_R0_3200	.BLKW	#1
BACKUP_R1_3200	.BLKW	#1
BACKUP_R2_3200	.BLKW	#1
COUNTER			.FILL	#0
ASCIINEWLINE	.FILL	#-10
ENTER			.FILL	#0
INTRO			.STRINGZ	"Enter a string. When done, press enter"
NEWLINE			.FILL	#10		

.end

