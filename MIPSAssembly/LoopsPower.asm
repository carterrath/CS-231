		.data 	 			# start of data
border:		.asciiz 	"================================================================================"
descr: 		.asciiz 	"\nProgram Description:\tUse assemble language to write power function x^y"
auth:		.asciiz 	"\nAuthor:\t\t\tCarter Rath"
date: 		.asciiz 	"\nCreation Date:\t\t09/20/2021\n"
promptX: 	.asciiz 	"\nEnter a positive number below 12 ==> "
promptY: 	.asciiz 	"\nEnter a positive power below 12 to raise the number to ==> "
error1: 	.asciiz 	"ERROR: the number you entered is not below 12. Try again."
error2: 	.asciiz 	"ERROR: the number you entered is not positive. Try again."
result: 	.asciiz 	"The result is ==> "

		.text				# start of code
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
 		li 	$s0, 1
 Read1: 	li 	$v0, 4 	 		#ask user for x
 		la 	$a0, promptX
 		syscall
 		
 		li 	$v0, 5			#read integer from user into $v0
		syscall
		
		add  	$t0, $v0, $0 		#store $v0 into $t0
		
		bge 	$t0, 12, Errorx1 	#check if x is less than 12, if not error
		blt 	$t0, $0, Errorx2 	#check if x is positive, if not error
		j 	Read2 	 	 	#number works, jump to Read2
		
Errorx1: 	li 	$v0, 4 	 	 	#tell user number entered was greater than 12 
 	 	la 	$a0, error1
 	 	syscall
 	 	j 	Read1 	 	 	#jump back to Read1 so user can try again
 	 	
Errorx2: 	li 	$v0, 4 	 	 	#tell user number entered was negative
		la 	$a0, error2		#jump back to Read1 so user can try again
		syscall
 		j 	Read1
 
Read2: 		li 	$v0, 4 	 		#ask user for y
 		la 	$a0, promptY
 		syscall
 		
 		li 	$v0, 5			#read integer from user into $v0
		syscall
		
		add  	$t1, $v0, $0 		#store $v0 into $t1
		
		bge 	$t1, 12, Errory1 	#check if y is less than 12, if not error
		blt 	$t1, $0, Errory2 	#check if y is positive, if not error
 	 	j 	Begin 	 	 	#power works, jump to Begin 
		
Errory1: 	li 	$v0, 4 	 	 	#tell user number entered was greater than 12 
 	 	la 	$a0, error1
 	 	syscall
 	 	j 	Read2 	 	 	#jump back to Read2 so user can try again
 	 	
Errory2: 	li 	$v0, 4 	 	 	#tell user number enetered was negative
 	 	la 	$a0, error2
 	 	syscall
 	 	j 	Read2 	 	 	#jump back to Read1 so user can try again
 	 	
Begin: 	 	ble 	$t1, $0, Stop 	 	#checks to see if counter is not zero, if so end loop
 	 	mult 	$s0, $t0 	 	#multiply $s0 and $t0
 	 	mflo 	$s0 	 	 	#store value of lo to $s0
 	 	sub 	$t1, $t1, 1 	 	#decrement counter y
 	 	j 	Begin 	 	 	#loop
 	 	
Stop: 	 	li 	$v0, 4 	 		#display result
 		la 	$a0, result
 		syscall 
 			
 		li 	$v0, 1			#display num
		add 	$a0,$s0,$0
		syscall
 		
 		#end of program
 		li 	$v0, 10		
	 	syscall
