		.data 	 		# start of data
border:		.asciiz 	"================================================================================"
descr: 		.asciiz 	"\nProgram Description:\tSums up positive multiples of 6 between 1 and 100 entered by a user"
auth:		.asciiz 	"\nAuthor:\t\t\tCarter Rath"
date: 		.asciiz 	"\nCreation Date:\t\t09/15/2021\n"
prompt: 	.asciiz 	"\nHow many positive numbers that are divisable by 6 do you want to add?\n"
enterNums: 	.asciiz 	"Enter a number: "
result: 	.asciiz 	"The sum of the positive numbers between 1 and 100 that are divisible by 6 is: "
notPositive: 	.asciiz 	" is not a positive number. Enter another number.\n"
notRange: 	.asciiz 	" is not in the range of 1 to 100. Enter another number.\n"
notDivisible: 	.asciiz 	" is not divisible by 6. Enter another number.\n"
isDivisible: 	.asciiz 	" is divisible by 6.\n"
error:	 	.asciiz 	"**** ERROR: "
arrow: 	 	.asciiz 	"==> "
 	 	.text 	 	 	#start of code
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
 		li 	$v0, 4 	 	#ask user how many nums
 		la 	$a0, prompt
 		syscall
 		
 	 	li 	$v0, 5		#read integer from user into $v0
		syscall
		
		add 	$t0,$v0,$0	#store $v0 into $t0
		add 	$t1,$0,0 	#store 0 into $t1
		add 	$t2,$0,100 	#store 100 into $t2
		add 	$t3,$0,6 	#store 6 into $t3
		
begin: 	 	beq 	$t0,$t1,stop 	#check if $t0 and $t1 are not equal, end loop if equal

 		li 	$v0, 4 	 	#prompt user to enter num
		la 	$a0, enterNums
		syscall
		
		li 	$v0, 5		#read integer from user into $v0
		syscall
		
		add 	$t4,$v0,$0	#store $v0 into $t4
		
		blt 	$t4,$0,error1 	#checks if num is negative, if so jumps to error1
		beq 	$t4,$0,error2 	#checks if num is 0, if so jumps to error2
		bgt 	$t4,$t2,error2 	#checks if num is greater than 100, if so jumps to error2
		
		div 	$t4,$t3 	#divide num by 6
		mfhi 	$s0		#move value of hi register into $s0, this is the remainder
		mflo 	$s1		#move value of lo register into $s1, this is the quotient
		bne 	$s0,$0,error3 	#checks if remainder is not equal to 0, if so jumps to error3
		
		li 	$v0, 4  	#arrow
 	 	la 	$a0, arrow
 	 	syscall
 	 	
 	 	li 	$v0, 1		#display num
		add 	$a0,$t4,$0
		syscall
		
		li 	$v0, 4  	#is divisible by 6
 	 	la 	$a0, isDivisible
 	 	syscall
 	 	
		add 	$t1,$t1,1 	#add 1 to $t1
		add 	$t5,$t5,$t4
		j 	begin 	 	#loop
		
error1: 	li 	$v0, 4  	#arrow
 	 	la 	$a0, arrow
 	 	syscall
 	 	
 	 	li 	$v0, 4  	#error
 	 	la 	$a0, error
 	 	syscall
 	 	
 	 	li 	$v0, 1		#display num
		add 	$a0,$t4,$0
		syscall
		
		li 	$v0, 4  	#negative num
 	 	la 	$a0, notPositive
 	 	syscall
 	 	
		j 	begin 	 	#loop
		
error2: 	li 	$v0, 4 	 	#arrow
 	 	la 	$a0, arrow 	
 	 	syscall
 	 	
 	 	li 	$v0, 4  	#error
 	 	la 	$a0, error
 	 	syscall
 	 	
 	 	li 	$v0, 1		#display num
		add 	$a0,$t4,$0
		syscall
		
		li 	$v0, 4  	#not less than 100
 	 	la 	$a0, notRange
 	 	syscall
 	 	
	 	j 	begin 	 	#loop
	 	
error3:  	li 	$v0, 4  	#arrow
 	 	la 	$a0, arrow
 	 	syscall
 	 	
 	 	li 	$v0, 4  	#error
 	 	la 	$a0, error
 	 	syscall
 	 	
 	 	li 	$v0, 1		#display num
		add 	$a0,$t4,$0
		syscall
		
		li 	$v0, 4  	#not divisible by 6
 	 	la 	$a0, notDivisible
 	 	syscall
		
		j 	begin 	 	#loop
		
stop: 	 	li 	$v0, 4 	 	#end loop
		la 	$a0, result
		syscall	
		
		li 	$v0, 1		#display num
		add 	$a0,$t5,$0
		syscall
		
		#li	$v0, 4
 		#la 	$a0, border
 		#syscall
 		
 		#end of program
 		li 	$v0, 10		
	 	syscall
