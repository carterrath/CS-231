	.data
space:    .asciiz "\n"
	.text

main:
	li      	$s1, 10	
	li      	$s2, 2

	div	$s1, $s2		#divide $s1 by $s2 and place the quotient 
				#into “lo” and remainder in “hi” registers 
	mfhi	$t0		#move the value of hi register into $t0 
	mflo	$t1		#move the value of lo register into $t1
	
	li 	$v0, 1
	add	$a0, $t1, $0
	syscall	



	li 	$v0, 1
	add	$a0, $t0, $0
	syscall
