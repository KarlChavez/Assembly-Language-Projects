#Karl Chavez

.file "part3.s"

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



#For Part1

#Printing the result
print_result:
        .string "\nThe shortest string is: \n"

#Creates a tab after the string is printed to make it look nice
tab:
        .string "\n\n"
#For Part2

#Printing a statement
print_result_2:
        .string "\nThe string with the fewest words is: \n"

#Printing the number of words in the string
print_num_2:
        .string "\nThe number of words is: %i\n\n"

#Creates a tab after the string is printed to make it look nice
tab_2:
        .string "\n"

#For Part3

string1:
	.string "\nThe structure's alightment is %i bytes.\n\n"

string2:
	.string "Spacing for %i bytes.\n"

string3:
        .string "%s for %i bytes.\n"

string4:
	.string "\nThe total space structure takes %i bytes.\n\n" 

testt:
	.string "%i\n"

.data

#The length of the array
num:
        .quad 0

int_string:
	.string "int"

double_string:
        .string "double"

long_string:
        .string "long"

char_string:
	.string "char"

float_string:
        .string "float"

short_string:
        .string "short"

#Part1 Function
.globl part1
        .type part1, @function
part1:
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
.size part1, .-part1

#Part2 Function
.globl part2
        .type part2, @function
part2:
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


        main_loop_2: #Iterates through all of the string addresses
                cmpq $0, %r12 #Check if r12 is 0
                je exit_main_loop_2 #Exit loop if all the strings have been popped

                movq $0, %r14 #Holds a character

                popq %r13 #Stores the string address in r13

                movq %r13, %r9 #Holds current character

                movq %r13, %r10 #Saves the string address

                movb (%r13), %r14b #moves the first character value of the string to r14

                movq $0, %rbx #Holds the number of words

                movq $0, %r8 #Checks for empty strings

                string_loop_2: #Iterates through the string
                        cmpq $0, %r14 #Check if the character is 0 (end of string)
                        je exit_string_loop_2 #Exit loop if reached end of string
			cmpq $32, %r14 #Check if the character is a space (end of the word)
                                setne %r8b #Set to 1 if it's a letter
                                je exit_if_statement_1_2 #Jump if it is a space

                                incq %r9 #Go to the next character

                                movb (%r9), %r14b #Stores the next character in r14

                                cmpq $0, %r14 #Check if the character is 0 (end of string)
                                je exit_string_loop_2 #Exit loop if reached end of string

                                cmpq $32, %r14 #Check if the character is a space (end of the word)
                                jne exit_if_statement_1_2 #Jump if it isn't a space

                                incq %rbx #Increment the number of words by 1   

                                exit_if_statement_1_2: #When If Statement isn't satisfied

                        incq %r13 #Go to the next character

                        movq %r13, %r9 #Saves the character     

                        movb (%r13), %r14b #Stores the next character in r14

                        movq $0, %r8 #Resets r8

                        jmp string_loop_2 #Iterates back to the loop      
                exit_string_loop_2: #End of string loop

                addq %r8, %rbx #Increment the number of words by 1 if r8 is set to 1

                cmpq %r15, %rbx #Checks if it's smaller than the current smallest length
                jg exit_if_statment_2_2 #Jump if the current string is bigger than the current smallest length

                         movq %rbx, %r15 #Replaces the smallest length with the current length          
                         movq %r10, %r11 #Replaces the shortest string with the current string

                exit_if_statment_2_2: #When If statement isn't satisfied

                decq %r12 #Decrement num for the loop
                jmp main_loop_2 #Jump back to the main loop
        exit_main_loop_2: #End of iteration through the strings

        pushq %r11 #Save the string

        #Printing out message
        movq $print_result_2, %rdi
        movq $0, %rax
        call printf

        popq %r11 #Obtain the string

        #Printing out the shortest string
        movq %r11, %rdi
        movq $0, %rax
        call printf

        #Printing out tab to make it look nicer
        movq $tab_2, %rdi
        movq $0, %rax
        call printf
	
	#Return the number of words
        movq %r15, %rax

        #Undo Stack Frame
        leave
        ret
.size part2, .-part2

.globl main
        .type main, @function		

#Part3 Function
.globl part3
	.type part3, @function
.text

part3: 
	#Stack Frame
	pushq %rbp
	movq %rsp, %rbp

	movq %rdi, %r12 #r12 holds the number of arguments

	pushq %r12 #Saves the value of the number of arguments
	
	movq %rsi, %r13 #r13 points to the first argument

	pushq %r13 #Saves the value of the pointer

	movq $0, %r14 #Holds the largest data structure

	movq $0, %r15 #Holds the current number data type

	loop_arg: #Iterates through all of the arguments and finds the largest type
	
		cmpq $0, %r12 #Check if r12 is 0 
		
		je exit_loop #Jump if you have iterated all the arguments
	
		#int
		movq (%r13), %rdi #Move argument to first parameter
		movq $int_string, %rsi #Move string to second parameter	
		movq $0, %rax #0 floaiting point registers
		call strcmp #Compare two strings
		cmpq $0, %rax #If the data type is an int
		jne double #Jump it isn't an int
		movq $4, %r15 #Store 4 into current data type 
		jmp exit
	
		#double
		double: 
		movq (%r13), %rdi #Move argument to first parameter
		movq $double_string, %rsi #Move string to second parameter 
		movq $0, %rax #0 floaiting point registers
		call strcmp #Compare two strings
                cmpq $0, %rax #If the data type is a double
                jne short #Jump it isn't an double
                movq $8, %r15 #Store 8 into current data type 
                jmp exit
		
		#short
		short:
                movq (%r13), %rdi #Move argument to first parameter
                movq $short_string, %rsi #Move string to second parameter 
                movq $0, %rax #0 floaiting point registers
                call strcmp #Compare two strings
                cmpq $0, %rax #If the data type is a short
                jne long #Jump it isn't a short
                movq $2, %r15 #Store 2 into current data type 
                jmp exit

		#long
                long:
                movq (%r13), %rdi #Move argument to first parameter
                movq $long_string, %rsi #Move string to second parameter 
                movq $0, %rax #0 floaiting point registers
                call strcmp #Compare two strings
                cmpq $0, %rax #If the data type is a long
                jne float #Jump it isn't a long
                movq $8, %r15 #Store 8 into current data type 
                jmp exit
	
		#float
                float:
                movq (%r13), %rdi #Move argument to first parameter
                movq $float_string, %rsi #Move string to second parameter 
                movq $0, %rax #0 floaiting point registers
                call strcmp #Compare two strings
                cmpq $0, %rax #If the data type is a float
                jne char #Jump it isn't a float
                movq $4, %r15 #Store 4 into current data type 
                jmp exit

		#char
                char:
                movq (%r13), %rdi #Move argument to first parameter
                movq $char_string, %rsi #Move string to second parameter 
                movq $0, %rax #0 floaiting point registers
                call strcmp #Compare two strings
                cmpq $0, %rax #If the data type is a char
                jne exit #Jump it isn't a char
                movq $1, %r15 #Store 1 into current data type 
                jmp exit

		exit:
		
		cmpq %r14, %r15 #Checks if current type is bigger than largest type
                jl exit_less_than #Jump if it isn't bigger

                         movq %r15, %r14 #Replaces the largest type with the current type         

                exit_less_than: #When If statement isn't satisfied	
			
		addq $8, %r13 #Go to the next string
		
		movq $0, %r15 #Reset the current argument
		
		decq %r12 #Decrease the number of arguments by 1
	
		jmp loop_arg #Jump back to the start of the loop
	
	exit_loop:

	#Pringint the structure's alignment
	movq %r14, %rsi 
	movq $string1, %rdi
	movq $0, %rax
	call printf

	popq %r13 #Obtain the pointer to the arguments
	addq $8,  %r13
	
	popq %rbx #Obtain the number of arguments
	decq %rbx
	
	#r14 holds the largest type

	movq $0, %r15 #Holds the total space
	
	movq $0, %r12 #Holds current structure alignment

	movq $0, %r11 #Holds current type

	loop_arg_2: #Iterates through all of the arguments and aligns the structure
		
		cmpq $0, %rbx #Check if rbx is 0 

		je exit_loop_2 #Jump if you have iterated all the arguments
		
		#int
                movq (%r13), %rdi #Move argument to first parameter
                movq $int_string, %rsi #Move string to second parameter 
                movq $0, %rax #0 floaiting point registers
                call strcmp #Compare two strings
                cmpq $0, %rax #If the data type is an int
                jne char_2 #Jump it isn't an int
                addq $4, %r12 #Add to the current structure alignment
		addq $4, %r15 #Add to the total space
		movq $4, %r11 
		pushq %r11 #Save the type
		pushq $int_string
		jmp exit_2

		#char
		char_2:
                movq (%r13), %rdi #Move argument to first parameter
                movq $char_string, %rsi #Move string to second parameter 
                movq $0, %rax #0 floaiting point registers
                call strcmp #Compare two strings
                cmpq $0, %rax #If the data type is an char
                jne double_2 #Jump it isn't an char
                addq $1, %r12 #Add to the current structure alignment
                addq $1, %r15 #Add to the total space
                movq $1, %r11
                pushq %r11 #Save the type
                pushq $char_string
		jmp exit_2

		#double
                double_2:
                movq (%r13), %rdi #Move argument to first parameter
                movq $double_string, %rsi #Move string to second parameter 
                movq $0, %rax #0 floaiting point registers
                call strcmp #Compare two strings
                cmpq $0, %rax #If the data type is an double
                jne long_2 #Jump it isn't a double
                addq $8, %r12 #Add to the current structure alignment
                addq $8, %r15 #Add to the total space
                movq $8, %r11
                pushq %r11 #Save the type
                pushq $double_string
		jmp exit_2
	
		#long
                long_2:
                movq (%r13), %rdi #Move argument to first parameter
                movq $long_string, %rsi #Move string to second parameter 
                movq $0, %rax #0 floaiting point registers
                call strcmp #Compare two strings
                cmpq $0, %rax #If the data type is a long
                jne short_2 #Jump it isn't a long
		addq $8, %r12 #Add to the current structure alignment
                addq $8, %r15 #Add to the total space
                movq $8, %r11
                pushq %r11 #Save the type
                pushq $long_string
                jmp exit_2
	
		#short
                short_2:
                movq (%r13), %rdi #Move argument to first parameter
                movq $short_string, %rsi #Move string to second parameter 
                movq $0, %rax #0 floaiting point registers
                call strcmp #Compare two strings
                cmpq $0, %rax #If the data type is a short
                jne float2 #Jump it isn't a short
		addq $2, %r12 #Add to the current structure alignment
                addq $2, %r15 #Add to the total space
                movq $2, %r11
                pushq %r11 #Save the type
                pushq $short_string
                jmp exit_2
			
		#float2
                float2:
                movq (%r13), %rdi #Move argument to first parameter
                movq $float_string, %rsi #Move string to second parameter 
                movq $0, %rax #0 floaiting point registers
                call strcmp #Compare two strings
                cmpq $0, %rax #If the data type is a short
                jne exit_2 #Jump it isn't a short
		addq $4, %r12 #Add to the current structure alignment
                addq $4, %r15 #Add to the total space
                movq $4, %r11
                pushq %r11 #Save the type
                pushq $float_string
                jmp exit_2
		
		exit_2:

		cmpq %r12, %r14 #Check if current alignment is equal to alignment boundary
		jne exceed#Jump if they aren't equal

			movq $0, %r12 #Reset current alignment
			jmp exit_less_equal
			
		exceed:
		cmpq %r12, %r14 #Check if we exceeded the alightment boundary
		jg exit_less_equal #Jump if we haven't
	
			movq %r14, %r10 #Temporary holder of the largest type
			subq %r11, %r12 #Subtract what we just added
			subq %r12, %r10 #Calculate the spacing
			addq %r10, %r15 #Add spacing to the total structure space				
			
			movq $0, %r12 #Reset current alignment
			addq %r11, %r12 #Add to current alignment	
	
			
			cmpq %r11, %r14 #Check if the type is as large as the biggest type
			jne equal_big #Jump it isn't 
			
				movq $0, %r12 #Reset current alignment
		
			jmp equal_big	
			equal_big:

			cmpq $0, %r10 #Check if spacing is 0
			je exit_less_equal #Don't print if it's 0
	
			#Print Spacing
			movq $string2, %rdi 
                        movq %r10, %rsi 
                        movq $0, %rax 
			call printf
				
		exit_less_equal:

		popq %rsi #Obtain type and store it to second parameter 
              	popq %rdx #Obtain number and store it to third parameter
		movq $string3, %rdi #Move string to first parameter
                movq $0, %rax #0 floaiting point registers
                call printf

		addq $8, %r13 #Go to the next string
		decq %rbx #Decrease the number of arguments by 1
		cmpq $0, %rbx #Check if you iterated all the arguments
		jne exit_end#Jump if you haven't
		cmpq %r12, %r14 #Check if you need spacing at the last data type
		jle exit_end #Jump if you dont
		cmpq $0, %r12 #Check if current alignment is 0
                je exit_end #Jump if it is 0
                subq %r12, %r14 #Calculate the spacing
		addq %r14, %r15 #Add to the total space
		
		#Print spacing
		movq $string2, %rdi
                movq %r14, %rsi
                movq $0, %rax 
                call printf

		exit_end:
                jmp loop_arg_2 #Jump back to the start of the loop
	
	exit_loop_2:

	#Print the total space structure
	movq %r15, %rsi
	movq $string4, %rdi
	movq $0, %rax
	call printf
	
	#Undo Stack Frame
	movq $0, %rax
	leave
	ret
.size part3, .-part3

#Main Function
.globl main
	.type main, @function

main:

	#Creating the stack frame
	pushq %rbp
	movq %rsp, %rbp

	movq %rdi, %r12 #Obtain the number of arguments

	cmpq $1, %r12 #Check how many arguments there are
	je call_1_2 #Jump if there is

	#Do part3 if there are arguments
	call part3
	jmp exit_main

	#Do part1 and part2 if there are no arguments
	call_1_2:
	call part1
	call part2
	
	#rax has the number of words for the string with the fewest words

        #Printing out the number of words
        movq $print_num_2, %rdi
        movq %rax, %rsi
        movq $0, %rax
        call printf
		
	exit_main:

	#Undo Stack Frame
	movq $0, %rax
	leave	
	ret
.size main, .-main
	
