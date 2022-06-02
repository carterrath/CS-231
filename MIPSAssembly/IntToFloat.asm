		.data 	 			# start of data
border:		.asciiz 	"================================================================================"
descr: 		.asciiz 	"\nProgram Description:\tPrompt the user for a temperature in Celsius and then display the result in Fahrenheit."
auth:		.asciiz 	"\nAuthor:\t\t\tCarter Rath"
date: 		.asciiz 	"\nCreation Date:\t\t10/13/2021\n"
prompt: 	.asciiz 	"\nPlease input a temperature in Celsius:\n"
arrow: 	 	.asciiz		"=> "
result:		.asciiz		"The temperature in Farenheit is:\n"
multFloat: 	.float 	 	1.8
addFloat: 	.float 	 	32
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
 	 	li 	$v0, 4 	 		# ask user for temperature in celsius
 	 	la 	$a0, prompt
 	 	syscall
 	 	
 	 	li 	$v0, 4 	 		# arrow
 	 	la 	$a0, arrow
 	 	syscall
 	 	
 	 	li 	$v0, 5 	 	 	# read integer into register $v0
 	 	syscall 
 	 	
 	 	add 	$t0, $v0, $0 	 	# store $v0 into register $t0
 	 	
 	 	mtc1 	$t0, $f0 	 	# move value from $t0 in coprocessor 0 to $f0 in coprocessor 1
 	 	
 	 	cvt.s.w	$f0, $f0 	 	# data conversion int to float
 	 	
 	 	l.s 	$f1, multFloat	 	# load 1.8 into register $f1
 	 	
 	 	mul.s 	$f0, $f0, $f1 	 	# multiply num by 1.8
 	 	
 	 	l.s 	$f2, addFloat 	 	# load 32 into register $f2
 	 	
 	 	add.s 	$f0, $f0, $f2 	 	# add 32 to num
 	 	
 	 	li 	$v0, 4 	 		# print result
 	 	la 	$a0, result
 	 	syscall
 	 	
 	 	li 	$v0, 4 	 		# arrow
 	 	la 	$a0, arrow
 	 	syscall
 	 	
 	 	li 	$v0, 2 	 	 	# move $f0 to register $f12 so it can print farenheit result to user
 	 	mov.s 	$f12, $f0
 	 	syscall
 	 	
		# end of program
		li 	$v0, 10		
	 	syscall
