/*Karl Chavez*/

.file "encode.s"

.section .rodata

get_char:
	.string "%c"
.data

/*integer array that has a space of 8*/
integer_array:
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0


.text

/*Function Encode*/
.globl encode
        .type encode, @function
encode:
        /*%rdi has the first value of the array*/

	/*Stack frame*/
        pushq %rbp
        movq %rsp, %rbp
	
	/*Counter variable*/
	movq $7, %r12
		
	/*Index counter*/
	movq $0, %r13
	
	/*Moves the last character in the array to %r14*/
	movq 56(%rdi), %r14

	/*Holds the array*/
	movq %rdi, %r15

	/*Right shift counter*/
	movb $0, %cl
		
	/*For loop that does the encryption*/
	for_loop:
	

		/*Push the last character on the stack*/
		pushq %r14

		/*Right shift on the last character by the right amount*/ 
		shrb %cl, %r14b

		/*Push shift counter on the stack*/
		pushq %rcx
		
		/*Left shift on the last character by 7 so it's next to the significant bit*/
		shlb $7, %r14b
		
		/*Builds the encrypted character*/
		orq %r14, (%r15, %r13, 8)	

		/*Prints the encrypted message*/
		movq (%r15, %r13, 8), %rsi
		movq $get_char, %rdi
		movq $0, %rax
		call printf

		/*Pop shift counter out of the stack*/
		popq %rcx

		/*Pop the last character out of the stack and restore the last character to %r14*/
		popq %r14
			
		/*Increment right shift counter*/
		incb %cl
	
		/*Increment index counter*/
		incq %r13
	
		/*Decrementing the counter variable to leave for loop*/
		decq %r12
        	jne for_loop	

        /*Undo Stack frame*/
        movq $0, %rax
	leave
        ret
.size encode, .-encode

.globl main
	.type main, @function

/*Main function*/
main: 
	/*Creating the stack frame*/
	pushq %rbp
	movq %rsp, %rbp

	/*Counter for the while loop*/
	movq $8, %r12

	/*Store array into r13*/
	movq $integer_array, %r13
	
	/*Index counter for the arrray*/
	movq $0, %r14
	
	/*While loop iterates until it reaches the end of the file*/
	while_loop:

		/*Obtains one character from the file*/	
		call getchar

		/*IF Statement to check whether getchar was EOF*/
		cmpl $-1, %eax
			
			/*Jump if getchar isn't EOF*/
			jne if1
	
			/*Counter variable for the For loop*/
			movq $8, %r15	
			
			/*Subtracting from the counter variable to know how many characters are in the array*/
			subq %r12, %r15
	
			/*Jump if the array is empty*/
			je exit
				
			/*Reset index counter*/
			movq $0, %r14
			
			/*For loop: Printing out words that aren't multiples of 8*/	
			for_loop_end:
				
				/*Printing the character*/	
				movq $get_char, %rdi
				movq (%r13, %r14, 8), %rsi
				movq $0, %rax
				call printf 

				/*Increment the index counter*/
				incq %r14

				/*Decrement %r15 to leave the for loop*/ 		
				decq %r15 
				jne for_loop_end

			/*Terminate the program*/
			jmp exit	
		
		/*Exiting out of the 1st IF statement*/
		if1:
		
		/*Adds character in the array*/	
		movq %rax, (%r13, %r14, 8)
	
		/*Increment index counter*/
		incq %r14
		
		/*IF Statement: Checking if getchar has obtained 8 characters*/
		cmpq $8, %r14
		
			/*Jump it getchar hasn't obtained 8 characters*/
			jne if2

			/*Pushing used callee saved registers onto the stack*/
			pushq %r12
			pushq %r13
			pushq %r14
			
			/*Put array into the 1st parameter*/
			movq %r13, %rdi

			/*Encodes the 8 characters*/
			call encode	
	
			/*Popping used callee saved registers out of the stack*/
			popq %r14
			popq %r13
			popq %r12

			/*Reset the loop counter*/
			movq $9, %r12

			/*Reset the index counter*/
			movq $0, %r14
		
	
		/*Exiting out of the 2nd IF statement*/
		if2:	
		
		/*Decrements r12 to leave loop*/	
		decq %r12
		jne while_loop			
	
	exit:

	/*Undo Stack Frame*/	
	movq $0, %rax
	leave	
	ret
.size main, .-main

