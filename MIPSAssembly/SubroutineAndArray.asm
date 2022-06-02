		.data 	 			# start of data
border:		.asciiz 	"================================================================================"
descr: 		.asciiz 	"\nProgram Description:\tPass through two functions"
auth:		.asciiz 	"\nAuthor:\t\t\tCarter Rath"
date: 		.asciiz 	"\nCreation Date:\t\t10/04/2021\n"
prompt: 	.asciiz 	"\nEnter the number of elements, n (2<n<11): "
error1: 	.asciiz 	"Too many elements!! Must be 10 or less, try again."
error2: 	.asciiz 	"Not enough elements!! Must be 3 or more, try again."
enter: 	 	.asciiz 	"Enter number "
colon: 	 	.asciiz 	":\t"
arr: 	 	.word 	 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0 	
sum: 	 	.asciiz 	"The sum of the elements is: "
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
		blt 	$t0, 3, Error2 		#check if num is less than 3, if so jump to error 2
		
		la 	$t1, arr 	 	#$t1 points to first location of array(index zero) with address arr
		
		add 	$a0, $t0, $0 	 	#pass counter to function by $a0
 	 	add 	$a1, $t1, $0 	 	#pass array pointer to function by $a1
 	 	jal 	FillArray 	 	#go to FillArray subroutine
 	 	
 	 	add 	$t1, $v1, $0 	 	#return array pointer
 	 	
 	 	add 	$a0, $t0, $0 	 	#pass counter to function by $a0
 	 	add 	$a1, $t1, $0 	 	#pass array pointer to function by $a1
 	 	jal 	AddElements 	 	#go to AddElements subroutine
 	 	
 	 	add 	$t4, $v1, $0 	 	#return sum
 	 	
 	 	li 	$v0, 4
 	 	la 	$a0, sum
 	 	syscall
 	 	li 	$v0, 1			#display sum
		add 	$a0,$t4,$0
		syscall
 	 	j 	End
		
Error1: 	li 	$v0, 4 	 	 	#display error message that num is too big
 	 	la 	$a0, error1
 	 	syscall
 	 	j 	ReadSize 	 	 #jump back to Read so user can try again
 	 	
Error2: 	li 	$v0, 4 	 	 	#display error message that num must be positive
		la 	$a0, error2
		syscall
		j 	ReadSize		#jump back to Read so user can try again
		
 		#end of program
 End:		li 	$v0, 10		
	 	syscall
#***********************************************start of FillArray*********************************************************************
FillArray:	add 	$t0, $a0, $0 	 	#pass counter to function by $a0
 	 	add 	$t1, $a1, $0 	 	#pass array pointer to function by $a1
 	 	li 	$t2, 0 			#initialize counter zerp
 	 		 		
Loop: 	 	beq 	$t0, $t2, Stop 		#checks if counter is equal to array size. If so, end loop
 	 	addi 	$t2, $t2, 1 	 	#increment counter
		li	$v0, 4 	 	 	#ask user for element(s)
 		la 	$a0, enter 	 	
 		syscall
 		li 	$v0, 1			#display counter
		add 	$a0,$t2,$0
		syscall
		li	$v0, 4 	 		#colon 	
 		la 	$a0, colon 	 	
 		syscall
 		li  	$v0, 5 			#Get input from user
		syscall
		sw  	$v0, 0($t1) 		#Store the number into the array
		addi 	$t1, $t1, 4 		#increment $t1 (the arraypointer) by 4 to point to the next position
		j  	Loop 	 	 	#loop
		
Stop:          	add 	$v1, $t1, $0 	 	#return array pointer
		jr 	$ra 	 	 	#jump to main
		
#***********************************************start of AddElements*********************************************************************
AddElements: 	add 	$t0, $a0, $0 	 	#pass counter to function by $a0
 	 	add 	$t1, $a1, $0 	 	#pass array pointer to function by $a1
 	 	li 	$t4, 0 	 		#initialize sum to zero
 	 	
SumUp: 		blt 	$t0, $0, Done  	 	#checks if counter equal to zero, if so jump to done
 	 	lw 	$t3, 0($t1) 		##Take element out of array and load it to register $t3
 	 	add 	$t4, $t4, $t3 	 	#Add element to sum register
 	 	addi 	$t1, $t1, -4 	 	#decrement $t1 (the arraypointer) by 4 to point to the next position
 	 	addi 	$t0, $t0, -1 	 	#decrement counter
 	 	j 	SumUp
 	 	
 Done: 	 	add 	$v1, $t4, $0 	 	#return array pointer
		jr 	$ra 	 	 	#jump to main
