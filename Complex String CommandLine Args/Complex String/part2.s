#Karl Chavez

.file "part2.s"

.section .rodata



### Grader Editable Section     ### 
### Section Starts Here         ###

### UPDATE
### Add/remove strings as needed 
s1:
	.string "I'm big fan of small word. No like big word or good grammar. Grammar too hard."
s2: 
	.string "I really hate how nice the weather is getting."
s3:
	.string "What" 
s4:
	.string "Amazing, isn't? With just the slightest touch the material warps around the skin effortlessly."
s5:
	.string "Can you believe how much ligma is going around this year?"

### Grader Editable Section     ###
### Section Ends Here           ###



#Printing a statement
print_result:
	.string "\nThe string with the fewest words is: \n" 

#Printing the number of words in the string
print_num:
	.string "\nThe number of words is: %i\n\n"

#Creates a tab after the string is printed to make it look nice
tab:
	.string "\n"
.data

#The length of the array
num:
	.quad 0
.text

#simple complex function
.globl complex
	.type complex, @function
complex:
	#Stack frame
	pushq %rbp
	movq %rsp, %rbp



	### Grader Editable Section     ### 
        ### Section Starts Here         ###
        
        ### UPDATE
        ### Add/remove statements as needed 
        ### Pushes the addresses of strings onto the stack
        pushq $s1
        pushq $s2
        pushq $s3
	pushq $s4
	pushq $s5
	
        ### UPDATE
        ### Move the number of string addresses into num
        movq $5, num

        ### Grader Editable Section     ###
        ### Section Ends Here           ###

		
	
	movq num, %r12 #r12 holds the value of num
	movq $9999999, %r15 #r15 holds the integer value of the fewest words
	movq $0, %r11 #r11 holds the shortest string

	
	movq $0, %r9 #Holds one icharacter for the next character

	
	main_loop: #Iterates through all of the string addresses
		cmpq $0, %r12 #Check if r12 is 0
		je exit_main_loop #Exit loop if all the strings have been popped
			
		movq $0, %r14 #Holds a character
		
		popq %r13 #Stores the string address in r13

		movq %r13, %r9 #Holds current character

		movq %r13, %r10 #Saves the string address
		
		movb (%r13), %r14b #moves the first character value of the string to r14

		movq $0, %rbx #Holds the number of words
		
		movq $0, %r8 #Checks for empty strings
		
		string_loop: #Iterates through the string
			cmpq $0, %r14 #Check if the character is 0 (end of string)
			je exit_string_loop #Exit loop if reached end of string

				cmpq $32, %r14 #Check if the character is a space (end of the word)
				setne %r8b #Set to 1 if it's a letter
				je exit_if_statement_1 #Jump if it is a space
				
				incq %r9 #Go to the next character

				movb (%r9), %r14b #Stores the next character in r14
	
				cmpq $0, %r14 #Check if the character is 0 (end of string)
				je exit_string_loop #Exit loop if reached end of string

				cmpq $32, %r14 #Check if the character is a space (end of the word)
				jne exit_if_statement_1 #Jump if it isn't a space

				incq %rbx #Increment the number of words by 1	
					
				exit_if_statement_1: #When If Statement isn't satisfied

			incq %r13 #Go to the next character
		
			movq %r13, %r9 #Saves the character	
			
			movb (%r13), %r14b #Stores the next character in r14
			
			movq $0, %r8 #Resets r8
			
			jmp string_loop #Iterates back to the loop	
		exit_string_loop: #End of string loop
	
		addq %r8, %rbx #Increment the number of words by 1 if r8 is set to 1
			
		cmpq %r15, %rbx #Checks if it's smaller than the current smallest length
		jg exit_if_statment_2 #Jump if the current string is bigger than the current smallest length
		
			 movq %rbx, %r15 #Replaces the smallest length with the current length		
			 movq %r10, %r11 #Replaces the shortest string with the current string
				
		exit_if_statment_2: #When If statement isn't satisfied
			
		decq %r12 #Decrement num for the loop
		jmp main_loop #Jump back to the main loop
	exit_main_loop: #End of iteration through the strings
	
	pushq %r11 #Save the string
	
	#Printing out message
	movq $print_result, %rdi
        movq $0, %rax
        call printf

	popq %r11 #Obtain the string

	#Printing out the shortest string
	movq %r11, %rdi
        movq $0, %rax
        call printf

	#Printing out tab to make it look nicer
	movq $tab, %rdi
        movq $0, %rax
        call printf

	#Return the number of words
	movq %r15, %rax

	#Undo Stack Frame
	leave
        ret
.size complex, .-complex
	
.globl main
        .type main, @function

#Main
main:
	
	#Stack frame
	pushq %rbp
	movq %rsp, %rbp

	call complex #call the function

	#rax has the number of words for the string with the fewest words
	
	#Printing out the number of words
	movq $print_num, %rdi	
	movq %rax, %rsi
	movq $0, %rax
	call printf 

	#Undo Stack Frame
	movq $0, %rax
	leave
	ret
.size main, .-main

	
