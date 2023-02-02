#Karl Chavez

.file "part1.s"

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



#Printing the result
print_result:
	.string "\nThe shortest string is: \n" 

#Creates a tab after the string is printed to make it look nice
tab:
	.string "\n\n"
.data

#The length of the array
num:
	.quad 0
.text

#simple string function
.globl simple
	.type simple, @function
simple:
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
	movq $9999999, %r15 #r15 holds the smallest length
	movq $0, %r11 #r11 holds the shortest string
	
	main_loop: #Iterates through all of the string addresses
		cmpq $0, %r12 #Check if r12 is 0
		je exit_main_loop #Exit loop if all the strings have been popped
			
		movq $0, %r14 #Holds a character
		
		popq %r13 #Stores the string address in r13

		movq %r13, %r10 #Saves the string address
		
		movb (%r13), %r14b #moves the first character value of the string to r14

		movq $0, %rbx #Holds the value of the length of string
		
		string_loop: #Iterates through the string
			cmpq $0, %r14 #Check if the character value is 0 (end of string)
			je exit_string_loop #Exit loop if reached end of string

			incq %rbx #Increment the length by 1
			
			incq %r13 #Go to the next character
			
			movb (%r13), %r14b #Stores the next character in r14
			
			jmp string_loop #Jump back to the loop
		exit_string_loop: #End of string loop
		
		cmpq %r15, %rbx #Checks if it's smaller than the current smallest length
		jg exit_if_statment #Jump if the current string is bigger than the current smallest length
		
			 movq %rbx, %r15 #Replaces the smallest length with the current length		
			 
			 movq %r10, %r11 #Replaces the shortest string with the current string
				
		exit_if_statment: #When If statement isn't satisfied
		
		
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

	#Undo Stack Frame
        movq $0, %rax
	leave
        ret
.size simple, .-simple
	
.globl main
        .type main, @function

#Main
main:
	
	#Stack frame
	pushq %rbp
	movq %rsp, %rbp

	call simple #call the function

	#Undo Stack Frame
	movq $0, %rax
	leave
	ret
.size main, .-main

	
