		.data 	 			# start of data
border:		.asciiz 	"================================================================================"
descr: 		.asciiz 	"\nProgram Description:\tto convert integer to binary."
auth:		.asciiz 	"\nAuthor:\t\t\tCarter Rath"
date: 		.asciiz 	"\nCreation Date:\t\t10/01/2021\n"
input: 		.asciiz 	"\nPlease enter an integer in decimal form: "
error: 	 	.asciiz 	"Integer cannot be negative. Try again."
binary: 	.asciiz 	"\nThe integer in binary is: "
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
Read: 		li 	$v0, 4 	 		#ask user to enter num
 		la 	$a0, input
 		syscall
 		
 		li 	$v0, 5 	 		#read integer into register $v0
 		syscall
 		
 		add 	$t0, $v0, $0 		#store $v0 into $t0, this is the decimal number

		blt 	$t0, $0, Error		#check if num is negative, if so jump to error
		
		 
		li	$v0, 4
 		la 	$a0, binary
 		syscall
		
		add 	$a0, $t0, $0 	 	#pass num to function by $a0
		
		jal 	BaseChange 	 	#call base change function to convert to binary
		
		j 	End 	 	 	#jump to end of program
		
Error: 	 	li 	$v0, 4 	 	 	#display error message that num is negative
 	 	la 	$a0, error
 	 	syscall
 	 	
 	 	j 	Read 	 		#jump back to Read so user can try again
 		
 		#end of program
 End:		li 	$v0, 10		
	 	syscall
#***********************************************start of BaseChange**************************************************************************
BaseChange: 	add 	$t0, $a0, $0 	 	#pass counter to function by $a0
		li 	$t1, 0 	 		#initialize counter to zero
		li 	$t2, 2 	 	 	#initialize divider to two
		li 	$t5, 0 	 	 	#initialize counter to zero
		li 	$t6, 32 	 	#initialize num of zeros to 32
		
Convert: 	ble 	$t0, 0, Zeros	 	#if quotient is greater than zero, keep converting
		div 	$t0, $t2 		#divide $t0 by $t2, then store results into lo and hi 
		mfhi 	$t3			#move value of hi register into $s3, this is remainder
		mflo 	$t4			#move value of lo register into $s4, this is quotient
		add 	$t0, $t4, $0 	 	#update new quotient
		addi 	$t1, $t1, 1 	 	#update counter
		addi 	$t6, $t6, -1 	 	#decrement num of zeros
		addi 	$sp, $sp, -4 	 	#update stack pointer
		sw 	$t3, 0($sp) 	 	#push remainder to stack
		j 	Convert 	 	#loop
		
Zeros: 	 	bge 	$t5, $t6, Binary 	#if counter equal to zeros, jump to print
		li 	$v0, 1			#display zero
		add 	$a0,$0,$0
		syscall 
		addi  	$t5, $t5, 1
		j 	Zeros 	 	 	#loop
		
Binary: 	ble 	$t1, $0, Done 	 	#checks if counter is equal to zero, if so end loop
		lw 	$t7, 0($sp)
		li 	$v0, 1			#display binary
		add 	$a0,$t7,$0
		syscall 
		addi 	$sp, $sp, 4 	 	#increment stack pointer
		addi 	$t1, $t1, -1 	 	#decrement counter
		j 	Binary 	 	 	#loop
		
Done: 	 	jr 	$ra 	 	 	#jump back to main
		
		
		
