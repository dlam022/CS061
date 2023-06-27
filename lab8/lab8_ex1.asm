;=================================================
; Name: Derick Lam
; Email: dlam052@ucr.edu
; 
; Lab: lab 8, ex 1 & 2
; Lab section: 023
; TA: Shirin
; 
;=================================================

; test harness
.orig x3000
LD R6, SUB_PRINT_OPCODE_TABLE
JSRR R6
 
LD R6, SUB_FIND_OPCODE_3600
JSRR R6
				 
				 
halt
;-----------------------------------------------------------------------------------------------
; test harness local data:

SUB_PRINT_OPCODE_TABLE	.FILL	x3200
SUB_FIND_OPCODE_3600	.FILL	x3600	


;===============================================================================================


; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE_TABLE
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;				 and corresponding opcode in the following format:
;					ADD = 0001
;					AND = 0101
;					BR = 0000
;					…
; Return Value: None
;-----------------------------------------------------------------------------------------------
.orig x3200
ST R0, BACKUP_R0_3200
ST R1, BACKUP_R1_3200
ST R2, BACKUP_R2_3200
ST R3, BACKUP_R3_3200
ST R4, BACKUP_R4_3200
ST R5, BACKUP_R5_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200

LD R1, opcodes_po_ptr
LD R3, instructions_po_ptr
LD R4, COUNTER
	
START_LOOP
	LDR R0, R3, #0					;printing out instructions from address x4100
	ADD R0, R0, #0
	BRz END_PRINT
	
	OUT
	
	ADD R3, R3, #1					;get the next instruction
	BR START_LOOP

END_PRINT
	
	ADD R3, R3, #1			
	
	LEA R0, EQUALSIGN				;get the equal sign
	PUTS
	
	LDR R2, R1, #0					;R2 points to value in R1
	LD R6, SUB_PRINT_OPCODE_3400	;go next subroutine to print out the binary
	JSRR R6
	
	LD R0, NEWLINE2
	OUT
	
	ADD R1, R1, #1					;get next address
	LDR R2, R1, #0					;have r2 point to it					
	ADD R4, R4, #-1					;decrement counter
	BRzp START_LOOP

LD R0, BACKUP_R0_3200
LD R1, BACKUP_R1_3200
LD R2, BACKUP_R2_3200
LD R3, BACKUP_R3_3200
LD R4, BACKUP_R4_3200
LD R5, BACKUP_R5_3200
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200		
				 
				 
				 
				 
ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE_TABLE local data
opcodes_po_ptr		.fill x4000				; local pointer to remote table of opcodes
instructions_po_ptr	.fill x4100				; local pointer to remote table of instructions
BACKUP_R0_3200		.BLKW	#1
BACKUP_R1_3200		.BLKW	#1
BACKUP_R2_3200		.BLKW	#1
BACKUP_R3_3200		.BLKW	#1
BACKUP_R4_3200		.BLKW	#1
BACKUP_R5_3200		.BLKW	#1
BACKUP_R6_3200		.BLKW	#1
BACKUP_R7_3200		.BLKW	#1
EQUALSIGN			.STRINGZ  " = "
SUB_PRINT_OPCODE_3400		.FILL	x3400
NEWLINE2					.FILL  #10
COUNTER						.FILL	#16

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
.orig x3400
ST R0, BACKUP_R0_3400
ST R1, BACKUP_R1_3400
ST R2, BACKUP_R2_3400
ST R3, BACKUP_R3_3400
ST R4, BACKUP_R4_3400
ST R5, BACKUP_R5_3400
ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400


LD R4, DEC_3
FIRST_LOOP
	LD R3, DEC_4			;number of bits counter
	INNER_LOOP
		LD R5, DEC_1		;16bit 2's complement 
		LD R0, ASCII
		
		ADD R4, R4, #0		;counter
		BRp END_LOOP		
		

		AND R5, R5, R2		;comparing R5 and R2
		BRn IS_NEGATIVE
		
	IS_POSITIVE
		ADD R0, R0, #0		;print out 0
		OUT
		BR END_LOOP
	IS_NEGATIVE
		ADD R0, R0, #1		;print out 1
		OUT
	END_LOOP
		ADD R2, R2, R2		;bit-shift
		ADD R3, R3, #-1		;decrement counter
		BRp INNER_LOOP
	END_OF_INNER
		ADD R4, R4, #-1		;decrement bit counter
		BRn END_PROGRAM
		BR FIRST_LOOP
			
END_PROGRAM

	LD R0, BACKUP_R0_3400
	LD R1, BACKUP_R1_3400
	LD R2, BACKUP_R2_3400
	LD R3, BACKUP_R3_3400
	LD R4, BACKUP_R4_3400
	LD R5, BACKUP_R5_3400
	LD R6, BACKUP_R6_3400
	LD R7, BACKUP_R7_3400		
				 			 
				 
				 
				 
	ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data
BACKUP_R0_3400		.BLKW	#1
BACKUP_R1_3400		.BLKW	#1
BACKUP_R2_3400		.BLKW	#1
BACKUP_R3_3400		.BLKW	#1
BACKUP_R4_3400		.BLKW	#1
BACKUP_R5_3400		.BLKW	#1
BACKUP_R6_3400		.BLKW	#1
BACKUP_R7_3400		.BLKW	#1
DEC_3				.FILL	#3
DEC_4				.FILL	#4
DEC_1				.FILL	#-32768
ASCII				.FILL	#48


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
.orig x3600
ST R0, BACKUP_R0_3600
ST R1, BACKUP_R1_3600
ST R2, BACKUP_R2_3600
ST R3, BACKUP_R3_3600
ST R4, BACKUP_R4_3600
ST R5, BACKUP_R5_3600
ST R6, BACKUP_R6_3600
ST R7, BACKUP_R7_3600			 


FOR_LOOP
	LEA R2, STORE_ARR				;making another array
	LD R6, SUB_GET_STRING_3800		;call the get string palindrome
	JSRR R6
	
	LD R1, opcodes_fo_ptr
	LD R3, instructions_fo_ptr
	
	SEARCH_LOOP
		LEA R2, STORE_ARR
		BR COMPARE_LOOP
		
		WRONG_LOOP
			LDR R4, R3, #0			;r4 point to value in r3
			ADD R4, R4, #0			
			BRz SECOND_COMPARE_LOOP
			ADD R3, R3, #1			;get the next address
			BR WRONG_LOOP
		COMPARE_LOOP
			LDR R5, R3, #0			
			LDR R4, R2, #0
			ADD R4, R4, #0
			BRnp CHECK_STRING
			
			ADD R5, R5, #0
			BRz RIGHT_LOOP
			BR WRONG_LOOP
		CHECK_STRING
			NOT R4, R4
			ADD R4, R4, #1			;taking two's complement
			ADD R5, R5, R4			;minus the two to see if it is equal to each other
			BRnp WRONG_LOOP			;if not, go to wrong loop
			
			ADD R2, R2, #1			;increment address of the input
			ADD R3, R3, #1			;increment address
			BR COMPARE_LOOP
		SECOND_COMPARE_LOOP
			ADD R3, R3, #1			;increment address
			ADD R1, R1, #1			;increment address
			LDR R0, R1, #0			;r0 equal the opcode
			ADD R0, R0, #0
			BRzp SEARCH_LOOP
			
		END_SUB_LOOP
			LEA R0, INVALIDINSTRUCTIONS		;if invalid, print out invalid instruction
			PUTS
			BR ENDING_LOOP
			
		RIGHT_LOOP
			LEA R0, STORE_ARR		;print out the instruction
			PUTS
			LEA R0, EQUAL_SIGN		
			PUTS
			LDR R2, R1, #0
			LD R6, SUB_PRINT_OPCODE_PTR_3400		;go to last subroutine to print out the bits
			JSRR R6
			LD R0, NEWLINEEE
			OUT
		ENDING_LOOP
			BR FOR_LOOP

LD R0, BACKUP_R0_3600				 
LD R1, BACKUP_R1_3600
LD R2, BACKUP_R2_3600
LD R3, BACKUP_R3_3600
LD R4, BACKUP_R4_3600
LD R5, BACKUP_R5_3600
LD R6, BACKUP_R6_3600
LD R7, BACKUP_R7_3600					 
				 
ret
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
opcodes_fo_ptr			.fill x4000
instructions_fo_ptr		.fill x4100
BACKUP_R0_3600		.BLKW	#1
BACKUP_R1_3600		.BLKW	#1
BACKUP_R2_3600		.BLKW	#1
BACKUP_R3_3600		.BLKW	#1
BACKUP_R4_3600		.BLKW	#1
BACKUP_R5_3600		.BLKW	#1
BACKUP_R6_3600		.BLKW	#1
BACKUP_R7_3600		.BLKW	#1
STORE_ARR				.BLKW	#100
SUB_GET_STRING_3800	.FILL	x3800
INVALIDINSTRUCTIONS	.STRINGZ	"Invalid Instruction\n"
EQUAL_SIGN			.STRINGZ	" = "
SUB_PRINT_OPCODE_PTR_3400	.FILL	x3400
NEWLINEEE			.FILL	'\n'

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
.orig x3800
ST R0, BACKUP_R0_3800
ST R1, BACKUP_R1_3800
ST R2, BACKUP_R2_3800
ST R3, BACKUP_R3_3800
ST R4, BACKUP_R4_3800
ST R5, BACKUP_R5_3800
ST R6, BACKUP_R6_3800
ST R7, BACKUP_R7_3800				 

INPUT_LOOP
	LD R3, NEWLINE3
	NOT R3, R3
	ADD R3, R3, #1
	
	GETC
	OUT
	
	ADD R3, R0, R3
	BRz END_LOOP_3800
	
	STR R0, R2, #0
	ADD R2, R2, #1
	BR INPUT_LOOP
	
END_LOOP_3800
	AND R0, R0, #0
	STR R0, R2, #0
	






LD R0, BACKUP_R0_3800				 
LD R1, BACKUP_R1_3800
LD R2, BACKUP_R2_3800
LD R3, BACKUP_R3_3800
LD R4, BACKUP_R4_3800
LD R5, BACKUP_R5_3800
LD R6, BACKUP_R6_3800
LD R7, BACKUP_R7_3800					 
				 
				 
ret
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data
BACKUP_R0_3800		.BLKW	#1
BACKUP_R1_3800		.BLKW	#1
BACKUP_R2_3800		.BLKW	#1
BACKUP_R3_3800		.BLKW	#1
BACKUP_R4_3800		.BLKW	#1
BACKUP_R5_3800		.BLKW	#1
BACKUP_R6_3800		.BLKW	#1
BACKUP_R7_3800		.BLKW	#1
NEWLINE3			.FILL	'\n'

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
.ORIG x4000			; list opcodes as numbers from #0 through #15, e.g. .fill #12 or .fill xC
; opcodes
.fill	#1		;ADD 0001  #1	
.fill	#5		;AND 0101  #5	
.fill	#0		;BR  0000  #0	
.fill	#12		;JMP 1100  #12	
.fill	#4		;JSR 0100  #4
.fill	#2		;LD  0010  #2	
.fill	#10     ;LDI 1010  #10	
.fill	#6		;LDR 0110  #6	
.fill	#14     ;LEA 1110  #14	
.fill	#9      ;NOT 1001  #9	
.fill	#12		;RET 1100  #12	
.fill	#8		;RTI 1000  #8	
.fill	#3      ;ST  0011  #3	
.fill   #11		;STI 1011  #11	
.fill	#7		;STR 0111  #7	
.fill	#15		;TRAP 1111 #15	
.fill	#13		;RESERVED 1101 #13	


.ORIG x4100			; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
								 		; - be sure to follow same order in opcode & instruction arrays!
; instructions	
.stringz "ADD"	;ADD 0001  #1
.stringz "AND"  ;AND 0101  #5
.stringz "BR"   ;BR  0010  #0
.stringz "JMP"  ;JMP 1100  #12
.stringz "JSR"  ;JSR 0100  #4
.stringz "LD"   ;LD  0010  #2
.stringz "LDI"  ;LDI 1010  #10
.stringz "LDR"  ;LDR 0110  #6
.stringz "LEA"  ;LEA 1110  #14
.stringz "NOT"  ;NOT 1001  #9
.stringz "RET"  ;RET 1100  #12
.stringz "RTI"  ;RTI 1000  #8
.stringz "ST"   ;ST  0011  #3
.stringz "STI"  ;STI 1011  #11
.stringz "STR" 	;STR 0111  #7
.stringz "TRAP"	;TRAP 1111  #15
.stringz "RESERVED"	;RESERVED 1101 #13
.fill #-1
;===============================================================================================