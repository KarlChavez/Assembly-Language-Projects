/*Karl Chavez*/

.file "decode.s"

.section .rodata

get_char:
	.string "%c"
.data

/*integer array that has a space of 7*/
integer_array:
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0

.text

/*Function Decode*/
.globl decode
        .type decode, @function
decode:
        /*%rdi has the first value of the array*/

	/*Stack frame*/
        pushq %rbp
        movq %rsp, %rbp

	/*Push the stack values onto the stack*/
        pushq %rdi
	        
	/*Counter variable*/
	movq $7, %r12
	
	/*Index Counter*/
	movq $0, %r13

	/*The 8th character*/
	movq $0, %r14
	
	/*Holds the array*/
	movq %rdi, %r15

	/*Left shift counter*/
	movb $0, %cl
		
	/*For loop that does the decryption*/
	for_loop:

		/*Saves the character's value*/
		movq (%r15, %r13, 8), %rbx

		/*Right shift by 7*/
		shrb $7, (%r15, %r13, 8)
	
		/*Left shift to get 8th character bit on the right position*/
		shlb %cl, (%r15, %r13, 8)

		/*Builds the 8th character*/
		orq (%r15, %r13, 8), %r14
		
		/*Makes the first bit of each character back to 0*/
		andq $127, %rbx
		
		/*Push shift counter on the stack*/
		pushq %rcx
	
		/*Prints the first 7 characters*/
		movq %rbx, %rsi
		movq $get_char, %rdi
		movq $0, %rax
		call printf

		/*Pop shift counter on the stack*/
		popq %rcx
		
		/*Increment left shift counter*/
		incb %cl
			
		/*Incrementing index counter*/
		incq %r13
	
		/*Decrementing the counter variable to leave for loop*/
		decq %r12
		jne for_loop
	
	/*Prints the 8th character*/
                movq %r14, %rsi
                movq $get_char, %rdi
                movq $0, %rax
                call printf	

	/*Undo Stack frame*/
        movq $0, %rax
	leave
        ret
.size decode, .-decode

.globl main
	.type main, @function

/*Main function*/
main: 
	/*Creating the stack frame*/
	pushq %rbp
	movq %rsp, %rbp

	/*Counter for the while loop*/
	movq $7, %r12

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
			movq $7, %r15	
			
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
		
		/*IF Statement: Checking if getchar has obtained 7 characters*/
		cmpq $7, %r14
		
			/*Jump it getchar hasn't obtained 7 characters*/
			jne if2

			/*Pushing callee saved registers onto the stack*/
			pushq %r12
			pushq %r13
			pushq %r14
			
			/*Put array into the 1st parameter*/
			movq %r13, %rdi

			/*Encodes the 8 characters*/
			call decode	
	
			/*Popping callee saved registers out of the stack*/
			popq %r14
			popq %r13
			popq %r12

			/*Reset the loop counter*/
			movq $8, %r12

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

