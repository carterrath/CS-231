		.data 	 		# start of data
border:		.asciiz 	"================================================================================"
descr: 		.asciiz 	"\nProgram Description:\tThis program is written to mimic a very basic calculator"
auth:		.asciiz 	"\nAuthor:\tCarter Rath"
date: 		.asciiz 	"\nCreation Date:\t09/10/2021\n"
str:  		.asciiz 	"\nPlease input two integers\n"
sum: 		.asciiz 	"Sum is:\t\t"
diff:		.asciiz		"\nDifference is:\t"
product:	.asciiz		"\nProduct is:\t"
quotient:	.asciiz		"\nQuotient is:\t"
remainder:	.asciiz		"\nRemainder is:\t"
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
 		
		li 	$v0, 4		#print string
		la 	$a0, str
		syscall
		
		li 	$v0, 5		#read first integer from user into $v0
		syscall
		
		add  	$t0,$0,$v0	#store $v0 into $t0
	
		
		li 	$v0, 5		#read second integer from user into $v0
		syscall
		
		add 	$t1,$0,$v0	#store $v0 into $t1
		
		li 	$v0, 4		#print sum string
		la  	$a0, sum
		syscall
		
		add 	$a0,$t0,$t1	#store sum of $t0 and $t1 into $a0
		
		li 	$v0,1		#display content of $a0
		syscall
		
		li 	$v0, 4		#print diff string
		la  	$a0, diff
		syscall
		
		sub 	$a0,$t0,$t1	#store difference of $t0 and $t1 into $a0
		
		li 	$v0,1		#display content of $a0
		syscall
		
		li 	$v0, 4		#print product string
		la  	$a0, product
		syscall
		
		mult 	$t0,$t1 	#multiply $t0 and $t1, then store results into lo and hi
		
		mfhi 	$s0		#move value of hi register into $s0
		mflo	$s1		#move value of lo register into $s1
		
		li	$v0, 1		#display product
		add 	$a0,$s1,$0
		syscall
		
		li 	$v0, 4		#print quotient string
		la  	$a0, quotient
		syscall
		
		div 	$t0,$t1 	#divide $t0 and $t1, then store results into lo and hi
		
		mfhi 	$s3		#move value of hi register into $s3
		mflo 	$s4		#move value of lo register into $s4
		
		li 	$v0, 1		#display quotient
		add 	$a0,$s4,$0
		syscall
		
		li 	$v0, 4		#print remainder string
		la  	$a0, remainder
		syscall
		
		li 	$v0, 1		#display remainder
		add 	$a0,$s3,$0
		syscall
		
	 	li 	$v0, 10		#end of program
	 	syscall
