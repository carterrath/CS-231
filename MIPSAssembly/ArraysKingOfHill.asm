		.data 	 			# start of data
border:		.asciiz 	"================================================================================"
descr: 		.asciiz 	"\nProgram Description:\tto find the largest element of an array, array size less than or equal to 10."
auth:		.asciiz 	"\nAuthor:\t\t\tCarter Rath"
date: 		.asciiz 	"\nCreation Date:\t\t09/23/2021\n"
prompt: 	.asciiz 	"\nEnter the number of elements: "
error1: 	.asciiz 	"Too many elements!! Must be 10 or less, try again."
error2: 	.asciiz 	"Not enough elements!! Must be greater than 0, try again."
enter: 	 	.asciiz 	"Enter number "
colon: 	 	.asciiz 	":\t"
arr: 	 	.word 	 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0 	
largest: 	.asciiz 	"\nThe largest element is: "
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
ReadSize: 	li 	$v0, 4 	 		#ask user to enter the number of elements
 		la 	$a0, prompt
 		syscall
 		
 		li 	$v0, 5 	 		#read integer into register $v0
 		syscall
 		
 		add 	$t0, $v0, $0 		#store $v0 into $t0, this is the array size
 		
 		bgt 	$t0, 10, Error1 	#checks if bigger than 10, if so then jump to error 1
		ble 	$t0, $0, Error2 	#check if num is positive, if not jump to error 2
		
		li 	$t1, 0 	 	 	#initialize counter to zero
		
		la 	$s0, arr 	 	#$s0 points to first location of array(index zero) with address arr
		
		j 	ReadArr
		
Error1: 	li 	$v0, 4 	 	 	#display error message that num is too big
 	 	la 	$a0, error1
 	 	syscall
 	 	
 	 	j 	ReadSize 	 	 #jump back to Read so user can try again
 	 	
Error2: 	li 	$v0, 4 	 	 	#display error message that num must be positive
		la 	$a0, error2
		syscall
		
		j 	ReadSize		#jump back to Read so user can try again
	
ReadArr: 	beq 	$t0, $t1, CallFunc 	#checks if counter is equal to array size. If so, end loop
 	 	
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
		
		addi 	$s0, $s0, 4 		#increment $s0 (the arraypointer) by 4 to point to the next position
		
		j  	ReadArr 	 	 #loop
		
CallFunc: 	la 	$s0, arr 	 	#$s0 points to first location of array(index zero) with address arr

		add 	$a0, $t1, $0 	 	#pass counter to function by $a0
		
 	 	add 	$a1, $s0, $0 	 	#pass array pointer to function by $a1
 	 	
 	 	jal 	FindMax 	 	#go to FindMax subroutine
		
		add 	$s1, $v1, $0 	 	#return largest
		
		li 	$v0, 4 	 	 	#print largest
		la  	$a0, largest
		syscall
		
		li 	$v0, 1 			#output the content of one element of array
		add 	$a0, $0, $s1
		syscall

 		#end of program
 		li 	$v0, 10		
	 	syscall
#***********************************************start of FindMax**************************************************************************
FindMax: 	
		add 	$t1, $a0, $0 	 	#pass counter to function by $a0
		
 	 	add 	$t4, $a1, $0 	 	#pass array pointer to function by $a1
 	 	
 	 	lw  	$t2, 0($t4) 		#Take first element out of array and load it to register $t2, this is largest
 	 	
Loop: 	 	beq 	$t1, 0, Stop 	 	#checks if counter is equal to zero, if so end loop

 	 	addi	$t1, $t1, -1 	 	#decrement counter by 1
 	 	
 	 	addi 	$t4, $t4, 4 		#increment $s0 (the arraypointer) by 4 to point to the next position
 	 	
 	 	lw  	$t3, 0($t4) 		#Take element out of array and load it to register $t3
 	 	
 	 	bgt 	$t3, $t2, NewLarge 	#checks if element is greater than current largest, if so jump to NewLarge
 	 	
 	 	j 	Loop 	 	 	#jump to loop
 	 	
NewLarge: 	add 	$t2, $t3, $0 	 	#set element to be largest

 	 	j 	Loop 	 	 	#jump to loop
 	 	
Stop: 	 	add 	$v1, $t2, $0 	 	#return largest to main

		jr 	$ra
		
 	 	
