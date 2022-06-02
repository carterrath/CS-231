		.data 	 			# start of data
border:		.asciiz 	"================================================================================"
descr: 		.asciiz 	"\nProgram Description:\tencrypt and decrypt a 9 chatacter line of text"
auth:		.asciiz 	"\nAuthor:\t\t\tCarter Rath"
date: 		.asciiz 	"\nCreation Date:\t\t10/22/2021\n"
prompt:		.asciiz 	"\nPlease enter a message to be sent:\n "
encrresult: 	.asciiz		"Your encrypted message is:\n "
decrresult:	.asciiz		"\nYour decrypted message is:\n "
message: 	.byte 	 	' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '
encrypted: 	.byte 	 	' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '
decrypted: 	.byte 	 	' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '
		.text
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
 		la 	$s0, message 	 	#array pointer for the message string
 		la 	$s1, encrypted 	 	#array pointer to encrypt message string
 		la 	$s2, encrypted 	 	#array pointer for encrypted string to be decrypted
 		la 	$s3, decrypted 	 	#array pointer to decrypt encrypted string 
 		li 	$t0, 0 	 	 	#initialize counter to zero
 		li 	$t1, 10 	 	#array size
 		li 	$t2, 10 	 	#key for encryption and decryption
 		
 		li 	$v0, 4 	 	 	#prompt user to enter message
 		la 	$a0, prompt
 		syscall
 		
 		li 	$v0, 8 	 	 	#to collect user input for message string
 		la 	$a0, message
 		li 	$a1, 10
 		syscall
 		
loop1: 	 	beq 	$t0, $t1, print1 	#checks if counter is equal to 10, if so end loop
		lb 	$t3, 0($s0) 	 	#load byte from message string
		xor 	$t4, $t3, $t2 	 	#xor byte by the key 
		sb 	$t4, 0($s1) 	 	#store byte into the encrypted array
		li 	$t3, 0 	 	 	#initialize register back to zero
		li 	$t4, 0 	 	 	#initialize register back to zero
		addi 	$s0, $s0, 1 	 	#increment array pointer for message
		addi 	$s1, $s1, 1 	 	#increment array pointer for encrypted
		addi 	$t0, $t0, 1 	 	#increment counter 
		j 	loop1 	 	 	#loop
		
print1: 	li 	$v0, 4 	 	 	#print encrypted result
		la 	$a0, encrresult
		syscall
		
		li 	$v0, 4 	 	 	#print encrypted string
		la 	$a0, encrypted
		syscall
		
loop2: 	 	beq 	$t0, $0, print2 	#checks if counter is equal to zero, if so end loop
		lb 	$t3, 0($s2) 	 	#load byte from encrypted string
		xor 	$t4, $t3, $t2 	 	#xor byte by the key  
		sb 	$t4, 0($s3) 	 	#store byte into decrypted array
		li 	$t3, 0 	 	 	#initialize register back to zero
		li 	$t4, 0 	 	 	#initialize register back to zero
		addi 	$s2, $s2, 1 	 	#increment array pointer for encrypted
		addi 	$s3, $s3, 1 	 	#increment array pointer for decrypted
		addi 	$t0, $t0, -1 	 	#decrement counter 
		j 	loop2 	 	 	#loop 	
		
print2:		li 	$v0, 4 	 	 	#print decrypted result
		la 	$a0, decrresult
		syscall
		
		li 	$v0, 4 	 	 	#print decrypted string
		la 	$a0, decrypted
		syscall
 		
		#end of program
 		li 	$v0, 10		
	 	syscall
