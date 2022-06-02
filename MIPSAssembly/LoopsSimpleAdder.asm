		.data 	 		# start of data
border:		.asciiz 	"================================================================================"
descr: 		.asciiz 	"\nProgram Description:\tPrint Output"
auth:		.asciiz 	"\nAuthor:\t\t\tCarter Rath"
date: 		.asciiz 	"\nCreation Date:\t\t09/13/2021\n"
promptStr: 	.asciiz 	"\nHow many integers would you like to add together? "
enterNums: 	.asciiz 	"Enter the integers one by one:\n"
resultStr: 	.asciiz 	"The sum of the even numbers is "

		.text			# start of code
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
 		li 	$v0, 4		#ask user for the number of integers to be added
 		la 	$a0, promptStr
 		syscall
 		li 	$v0, 5		#read integer from user into $v0
		syscall
		
		add 	$t0,$v0,$0	#store $v0 into $t0
		add 	$t1,$0,2 	#store 2 into $t1
		add 	$t2,$0,0 	#store 0 into $t2
		
		li 	$v0, 4 	 	#prompt user to start entering integers one by one
		la 	$a0, enterNums
		syscall
		
begin:	 	beq 	$t0,$t2,stop 	#check if $t0 and $t2 are not equal, end loop if equal

		li 	$v0, 5		#read integer from user into $v0
		syscall
		add 	$t2,$t2,1 	#add 1 to $t2 
	
		add 	$t3, $v0,$0	#store $v0 into $t3

		div 	$t3,$t1 	#divide $t3 and $t1, then store results into lo and hi
		
		mfhi 	$s0		#move value of hi register into $s0, this is the remainder
		mflo 	$s1		#move value of lo register into $s1, this is the quotient
		
		bne 	$s0,$0,begin 	#check to see if remainder is 0, if it is not, skip addition and loop
		add 	$t4,$t4,$t3
		
		j 	begin	 	#loop
		
stop: 	 	li 	$v0, 4 	 	#end of loop
		la 	$a0, resultStr
		syscall
		
		li 	$v0, 1		#display sum
		add 	$a0,$t4,$0
		syscall
 		
 		#end of program
 		li 	$v0, 10		
	 	syscall
 		
 		
