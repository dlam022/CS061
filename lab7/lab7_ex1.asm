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
;-------------
;Instructions
;-------------

LD R0, SUBROUTINE_3200
JSRR R0

ADD R1, R1, #1


LD R0, SUBROUTINE_3400
JSRR R0



HALT
;===================
;LOCAL DATA
;===================
SUBROUTINE_3200	.FILL	x3200
SUBROUTINE_3400	.FILL	x3400


;========================
;SUBROUTINE 1
;algorithm is suppose to get character from the user (5 digits max) and store it in R1
;It is suppose to ignore the + or - sign and only store the numbers. If it is a negative number
;take the two's complement of the number so the number store is a negative.
;range of digit that can be put into the program is [-32768, +32767]
;========================
.ORIG x3200

ST R7, BACKUP_R7_3200

; output intro prompt
RESTART
LD R4, TEXTCOUNTER
LD R2, introPromptPtr					;load address of the message into R2
INPUTPROMPT_LOOP						;intro loop
	LDR R3, R2, #0						;R3 points to the data in address R2	
	ADD R0, R0, R3						;outputting
	OUT
	AND R0, R0, #0						;reset R0
	ADD R2, R2, #1						;R2 gets the next address
	ADD R4, R4, #1						;text counter (yes i counted each letter and space :/)
	BRn INPUTPROMPT_LOOP
	
	
;LD R0, NEWLINE		
;OUT

AND R7, R7, #0
LD R4, COUNTER							;counter equal 5, maximum amount of number is 5
LD R3, ENTERCHECK						;checking whether the user press enter, sentinel character


AND R6, R6, #0							;clear r6
AND R1, R1, #0

FIRST_LOOP								;first loop to get +, -, "\n", or a number
	GETC	
	OUT
	
	ADD R6, R0, #0						;output is put into r6
	ADD R6, R6, R3						;check if it is newline
	BRnp CHECK_FIRST_CHAR				;if negative or postive, go to check_first_char loop
	BRz SPACE_QUIT_POSITIVE						;if it is a newline, quit the program (output no message)
	
CHECK_FIRST_CHAR
	AND R6, R6, #0						;reset r6
	LD R5, POSITIVESIGN					;positive sign ascii number
	ADD R6, R0, #0						;r6 gets the output
	ADD R6, R6, R5						;checking if it is the positive sign
	BRz PLUS_CHAR						;if it is, go to plus_char loop
	
	AND R6, R6, #0						;reset r6
	LD R5, NEGATIVESIGN					;check for negative sign now using the negative ascii number
	ADD R6, R0, #0
	ADD R6, R6, R5
	BRz MINUS_CHAR						;if there is a negative sign, go to minus_char loop
	BRp CHECK_FIRST_INPUT				;if it is a number first output to the console, go the check_first_input

	
CHECK_FIRST_INPUT
	AND R6, R6, #0						;reset r6
	ADD R6, R0, #0						;r6 gets output
	LD R5, ZERONEG						;negative ascii for the number 0
	ADD R6, R6, R5						;checking to see if it is less than zero's ascii number
	BRn INVALID_CHAR					;if it is less, than it is an invalid character since we already check for the signs
	
	AND R6, R6, #0
	ADD R6, R0, #0
	LD R5, NINENEG						;negative ascii for the number 9
	ADD R6, R6, R5						;checking to see if it is larger than nine's ascii number
	BRp INVALID_CHAR					;if it is, than it is an invalid character
		
	ADD R1, R1, R1						;multiplying R1 by 10 to hold big numbers
	ADD R2, R1, R1						;getting r2 to equal to 4x
	ADD R2, R2, R2						;than r2 adds itself to get 8x
	ADD R1, R1, R2						;r1 than gets 10x
	LD R5, ZERONEG						;converting ascii to decimal
	ADD R0, R0, R5
	ADD R1, R1, R0						;adding in the number
	ADD R4, R4, #-1						;decrement counter
	BRp PLUS_CHAR
	
	

PLUS_CHAR
	GETC
	OUT
	AND R6, R6, #0
	ADD R6, R0, #0
	ADD R6, R6, R3
	BRz SPACE_QUIT_POSITIVE						;if use sentinel character to end, mean jus halt the program
	
	AND R6, R6, #0
	ADD R6, R0, #0
	LD R5, ZERONEG
	ADD R6, R6, R5
	BRn INVALID_CHAR
	
	AND R6, R6, #0
	ADD R6, R0, #0
	LD R5, NINENEG
	ADD R6, R6, R5
	BRp INVALID_CHAR
	
	ADD R1, R1, R1
	ADD R2, R1, R1
	ADD R2, R2, R2
	ADD R1, R1, R2
	LD R5, ZERONEG
	ADD R0, R0, R5
	ADD R1, R1, R0
	
	ADD R4, R4, #-1
	BRp PLUS_CHAR
	BRz QUIT_POSITIVE							;quit has the newline at the end of the program
	
MINUS_CHAR
	GETC
	OUT
	AND R6, R6, #0
	ADD R6, R0, #0
	ADD R6, R6, R3	
	BRz TWO_COMPLEMENT_SPACE			;if ended if a space 
	
	AND R6, R6, #0
	ADD R6, R0, #0
	LD R5, ZERONEG
	ADD R6, R6, R5
	BRn INVALID_CHAR
	
	AND R6, R6, #0
	ADD R6, R0, #0
	LD R5, NINENEG
	ADD R6, R6, R5
	BRp INVALID_CHAR
	
	ADD R1, R1, R1
	ADD R2, R1, R1
	ADD R2, R2, R2
	ADD R1, R1, R2
	LD R5, ZERONEG
	ADD R0, R0, R5
	ADD R1, R1, R0
	
	ADD R4, R4, #-1
	BRp MINUS_CHAR
	BRz TWO_COMPLEMENT	
	
TWO_COMPLEMENT_SPACE
	NOT R1, R1							;taking twos compliment to make the number negative
	ADD R1, R1, #1
	BRnzp SPACE_QUIT_NEGATIVE
	
	
TWO_COMPLEMENT
	AND R5, R5, #0
	ADD R5, R5, #1
	NOT R1, R1
	ADD R1, R1, #1
	BRnzp QUIT_NEGATIVE
	
INVALID_CHAR
	AND R2, R2, #0
	AND R3, R3, #0
	LD R4, ERRORMESSAGECOUNTER
	LD R2, errorMessagePtr				;error message address is loaded into r2
	LD R0, NEWLINE
	OUT
	AND R0, R0, #0
	BRnzp INVALID_OUTPUT				;outputing invalid outputs
	
INVALID_OUTPUT
	LDR R3, R2, #0						;R3 points to the data in the R2
	ADD R0, R0, R3						;outputing the letters
	OUT
	AND R0, R0, #0
	ADD R2, R2, #1
	ADD R4, R4, #-1						;decrement counter by 1 of the message
	BRnp INVALID_OUTPUT
	BRz RESTART							;go back to the start
	
	
	

SPACE_QUIT_POSITIVE
;	LD R0, NEWLINE
;	OUT
	AND R5, R5, #0
	LD R7, BACKUP_R7_3200
	RET
						
; Set up flags, counters, accumulators as needed



; Get first character, test for '\n', '+', '-', digit/non-digit 	
					
					; is very first character = '\n'? if so, just quit (no message)!

					; is it = '+'? if so, ignore it, go get digits

					; is it = '-'? if so, set neg flag, go get digits
					
					; is it < '0'? if so, it is not a digit	- o/p error message, start over

					; is it > '9'? if so, it is not a digit	- o/p error message, start over
				
					; if none of the above, first character is first numeric digit - convert it to number & store in target register!
					
; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator

QUIT_POSITIVE					; remember to end with a newline!
	LD R0, NEWLINE
	OUT
	AND R5, R5, #0
	LD R7, BACKUP_R7_3200				
	RET

SPACE_QUIT_NEGATIVE
	AND R5, R5, #0
	ADD R5, R5, #1
	LD R7, BACKUP_R7_3200
	RET
	
QUIT_NEGATIVE
	AND R5, R5, #0
	ADD R5, R5, #1
	LD R0, NEWLINE
	OUT
	LD R7, BACKUP_R7_3200
	RET
;---------------	
; Program Data
;---------------

BACKUP_R7_3200		.BLKW	#1	
introPromptPtr		.FILL xB000
errorMessagePtr		.FILL xB200
NEWLINE				.FILL	#10
COUNTER				.FILL	#5
ENTERCHECK			.FILL	#-10
NEGATIVESIGN		.FILL	#-45
POSITIVESIGN		.FILL	#-43
ZERONEG				.FILL	#-48
NINENEG				.FILL	#-57
TEXTCOUNTER			.FILL	#-78
ERRORMESSAGECOUNTER	.FILL	#21


;------------
; Remote data
;------------
.ORIG xB000			; intro prompt
				.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

					
.ORIG xB200			; error message
					.STRINGZ	"ERROR: invalid input\n"
					

;==============
;SUBROUTINE 2
;this algorithm is suppose to take the number that was put into R1, which was added by 1 in main,
;and output the number to the console. So it is taking the number out of the register and outputing it 
;to the console. Basically a backward algorithm of subroutine 1
;==============
.orig x3400

ST R1, BACKUP_R1_3400
ST R7, BACKUP_R7_3400

LD R3, COUNTER2
AND R4, R4, #0
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
	LD R0, NEWLINE2
	OUT
	
LD R1, BACKUP_R1_3400
LD R7, BACKUP_R7_3400

RET

;=========================
;SUBROUTINE2 DATA
;=========================

BACKUP_R1_3400	.BLKW	#1
BACKUP_R7_3400	.BLKW	#1
ASCII			.FILL	#48
MINUS10000		.FILL	#-10000
MINUS1000		.FILL	#-1000
MINUS100		.FILL	#-100
MINUS10			.FILL	#-10
COUNTER2		.FILL	#0
NEWLINE2		.FILL	#10
NEGSIGN2		.FILL	#45

;---------------
; END of PROGRAM
;---------------
.END
