		.data 	 			# start of data
border:		.asciiz 	"================================================================================"
descr: 		.asciiz 	"\nProgram Description:\tProgram to ask user to input the number of elements of array."
auth:		.asciiz 	"\nAuthor:\t\t\tCarter Rath"
date: 		.asciiz 	"\nCreation Date:\t\t09/23/2021\n"
prompt: 	.asciiz 	"\nEnter the number of elements: "
error1: 	.asciiz 	"Error: array can't have more than 10 elements, try again!!"
error2: 	.asciiz 	"Error: array size must be a positive amoubt, try again!!"
enter: 	 	.asciiz 	"Enter number "
colon: 	 	.asciiz 	":\t"
arr: 	 	.word 	 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0 	
newLine: 	.asciiz 	"\n" 	
reverse: 	.asciiz 	"\nThe content of the array in reverse order is:\n"
 	 	.text 	  			# start of code
main:
		li	$v0, 4
 		la 	$a0, border
 		syscall
 		li	$v0, 4
 		la 	$a0, descr
 		syscall
 		li	$v0, 4
 		la 	$a0, auth
 		syscall
 		li	$v0, 4
 		la 	$a0, date
 		syscall
 		li	$v0, 4
 		la 	$a0, border
 		syscall
 		#end of header
Read: 		li 	$v0, 4 	 	 	#ask user to enter number of elements
 		la 	$a0, prompt
 		syscall
 		
 		li 	$v0, 5			#read integer from user into $v0
		syscall
		
		add  	$t0, $v0, $0 		#store $v0 into $t0
		
		bgt 	$t0, 10, Error1 	#checks if bigger than 10, if so then jump to error 1
		ble 	$t0, $0, Error2 	#check if num is positive, if not error 2
		
		li	$v0, 4
 		la 	$a0, border
 		syscall
 
  	 	li 	$t1, 0 	 	 	#initialize counter to zero
		
		la 	$s0, arr 	 	#$s0 points to first location of array(index zero) with address arr
		
		li 	$v0, 4 			#go to next line
		la 	$a0, newLine
		syscall
		 	
		j 	Loop 	 	 	#jump to loop 

Error1: 	li 	$v0, 4 	 	 	#display error message
		la 	$a0, error1
		syscall
		
		j 	Read 	 	 	#jump back to read
		
Error2: 	li 	$v0, 4 	 	 	#display error message
		la 	$a0, error2
		syscall
		
		j 	Read 	 	 	#jump back to read
		
Loop: 	 	beq 	$t0, $t1, Stop1 	 #checks if counter is equal to num, if so end loop and go to second loop

		addi 	$t1, $t1, 1 	 	#increment counter
		
		li	$v0, 4 	 	 	#ask user for element(s)
 		la 	$a0, enter 	 	
 		syscall
 		li 	$v0, 1			#display counter
		add 	$a0,$t1,$0
		syscall
		li	$v0, 4 	 	 	
 		la 	$a0, colon 	 	
 		syscall
 		
 		li  	$v0, 5 			#Get input from user
		syscall
		sw  	$v0, 0($s0) 		#Store the number into the array
		
		
		addi 	$s0, $s0, 4 		#increment $s2 (the arraypointer) by 4 to point to the next position
		
		j  	Loop 	 	 	#loop
		
Stop1: 	 	li	$v0, 4
 		la 	$a0, border
 		syscall	 	
 		li	$v0, 4
 		la 	$a0, reverse
 		syscall
 		li	$v0, 4
 		la 	$a0, border
 		syscall
		j 	Reverse
		
Reverse: 	beq 	$t1, $0, Stop2 	 	#checks if counter is equal to zero, if so end loop
	
		add $t1, $t1, -1 		#update the counter
		add $s0, $s0, -4 		#increment $s2 (the array pointer) by 4 to point to the next position
		
		li 	$v0, 4 			#go to next line
		la 	$a0, newLine
		syscall
		
		lw  	$s1, 0($s0) 		#Take the element out of array and load it to register $s1
		
		li 	$v0, 1 			#output the content of one element of array
		add 	$a0, $0, $s1
		syscall
		
		j 	Reverse
		
Stop2:		li 	$v0, 4 			#go to next line
		la 	$a0, newLine
		syscall
		li	$v0, 4
 		la 	$a0, border
 		syscall
 		
		#end of program
 		li 	$v0, 10		
	 	syscall
