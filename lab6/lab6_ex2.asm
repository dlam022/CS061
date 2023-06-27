;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 023
; TA: Shirin
; 
;=================================================
.ORIG x3000

;=============
;Instruction
;=============
;LEA R0, FRONTSTRING
;PUTS

LD R1, ARRAY_ADDRESS
LD R6, SUB_GET_STRING_3200			;calls the subroutine to get string from user
JSRR R6



LD R6, SUB_IS_PALINDROME_3400
JSRR R6								;calls the subroutine to find out if it is a palindrome


AND R2, R2, #0						;reset r2
;ADD R2, R1, #0						;make r1 equal to address
LEA R0, FRONTSTRING					;output to console a string
PUTS
AND R0, R0, #0						;reset r0

FIRST_LOOP
	LDR R3, R1, #0					;R3 points to the letter in address R1
	ADD R0, R0, R3					;outputing letter
	OUT
	AND R0, R0, #0					;reset r0
	ADD R1, R1, #1					;adding 1 to the address
	ADD R5, R5, #-1					;decrement counter
	BRnp FIRST_LOOP

LD R2, ISUNO
NOT R2, R2							;r2 is equal to 1, make negative
ADD R2, R2, #1						
ADD R4, R4, R2						;if r4 - r2 is zero, it is a palindrome
BRz PRINTOUT

LEA R0, NOTPALINDROMEE				;else it is not a palindrome
PUTS

LD R0, NEWLINEEE
OUT


HALT

PRINTOUT
	LEA R0, PALINDROMEE
	PUTS
	LD R0, NEWLINEEE
	OUT
	HALT

;=====
;DATA
;=====
SUB_GET_STRING_3200		.FILL	x3200
ARRAY_ADDRESS			.FILL	x4000
SUB_IS_PALINDROME_3400	.FILL	x3400
ISUNO					.FILL	#1
NOTPALINDROMEE			.STRINGZ	" ' IS NOT A PALINDROME"
PALINDROMEE				.STRINGZ	" 'IS A PALINDROME"
FRONTSTRING				.STRINGZ	"THE STRING ' "
NEWLINEEE				.FILL	#10

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
ST R4, BACKUP_R4_3200

;LEA R0, INTRO
;PUTS
;LD R0, NEWLINE
;OUT

ADD R2, R1, #0
LD R4, COUNTER					;R5 contains the number of non-sentinel characters
LD R3, ASCIINEWLINE				;ascii decimal for enter is 10



GET_STRING
	GETC						;get string from user
	OUT							;output the string
	
	ADD R6, R0, #0				;reset R6
	ADD R6, R6, R3				;checking for user if press enter
	BRz END_STRING				;go to end string with r6 is 0
	
	STR R0, R2, #0				;stores character into the array
	ADD R2, R2, #1				;increment the array address by 1
	ADD R4, R4, #1				;increment the counter
	BRnp GET_STRING				;go back to get_string loop to get another character
	
END_STRING
	ADD R5, R4, #0
	LD R3, ENTER				
	STR R3, R2, #0				;stores null at the end of the array

;========
;BACKUP
;========
LD R7, BACKUP_R7_3200
;LD R5, BACKUP_R5_3200
LD R0, BACKUP_R0_3200
LD R1, BACKUP_R1_3200
LD R2, BACKUP_R2_3200
LD R4, BACKUP_R4_3200

RET

;===============
;SUBROUTINE DATA
;===============
BACKUP_R7_3200	.BLKW	#1
;BACKUP_R5_3200	.BLKW	#1
BACKUP_R0_3200	.BLKW	#1
BACKUP_R1_3200	.BLKW	#1
BACKUP_R2_3200	.BLKW	#1
BACKUP_R4_3200	.BLKW	#1
COUNTER			.FILL	#0
ASCIINEWLINE	.FILL	#-10
ENTER			.FILL	#0
;INTRO			.STRINGZ	"Enter a string. When done, press enter"
NEWLINE			.FILL	#10		








;============================================================================
;Subroutine: SUB_IS_PALINDROME
;Parameter (R1): The starting address of a null-terminated string
;Parameter (R5): The number of characters in the array.
;Postcondition: The subroutine has determined whether the string at (R1) is
;				a palindrome or not, and returned a flag to that effect
;Return value: R4 {1 if the string is a palindrome, 0 otherwise}
;============================================================================
.ORIG x3400

ST R1, BACKUP_R1_3400
ST R7, BACKUP_R7_3400
ST R5, BACKUP_R5_3400


AND R2, R2, #0				;reset r2 to 0
AND R3, R3, #0				;reset r3 to 0
ADD R4, R4, #1				;r4 is equal to 1
		
ADD R6, R5, R1				;r6 equal the last character
ADD R6, R6, #-1				;

PALINDROME
	LDR R2, R1, #0			;R2 points to number in address, r1 equal address
	LDR R3, R6, #0			;r3 points to number in address of r6, r6 equal address of last letter
	NOT R3, R3				;make negative
	ADD R3, R3, #1			;add 1 to check the same letter as r2
	ADD R2, R2, R3			;comparing r2 to r3 to see if they are equal
	BRnp NOT_PALINDROME		;if r1 - r3 doesnt equal zero, then it is not a palindrome
	ADD R1, R1, #1			;add one to the address to get the next letter
	ADD R6, R6, #-1			;decrement 1 from r6 to go backwards in the word
	ADD R5, R5, #-1			;decrement 1 from counter
	BRnp PALINDROME			;if non zero, go back and loop again
	BRz END					;if zero, go to end loop
	
NOT_PALINDROME				
	AND R4, R4, #0			;if not palindrome, r4 is equal to 0
	
END

	
LD R1, BACKUP_R1_3400
LD R7, BACKUP_R7_3400
LD R5, BACKUP_R5_3400

	
RET
	
;========================
;SUBROUTINE 2 DATA
;========================
BACKUP_R1_3400	.BLKW	#1
BACKUP_R7_3400	.BLKW	#1
BACKUP_R5_3400	.BLKW	#1








.END