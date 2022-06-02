		.data 	 			# start of data
border:		.asciiz 	"================================================================================"
descr: 		.asciiz 	"\nProgram Description:\tprogram for a grocery store to calculate the total charge for customers."
auth:		.asciiz 	"\nAuthor:\t\t\tCarter Rath"
date: 		.asciiz 	"\nCreation Date:\t\t10/08/2021\n"
prompt1: 	.asciiz 	"\nPlease enter the number of items you are purchasing:\n "
prompt2: 	.asciiz 	"Please enter the number of coupons you want to use:\n"
error1: 	.asciiz 	"Sorry, too many items to purchase!! Try again.\n"
error2: 	.asciiz 	"Sorry, coupon amount is not the same as item amount!! Try again.\n"
error3: 	.asciiz 	"This coupon is not acceptable.\n"
enter1: 	.asciiz 	"Please enter the price of item "
enter2: 	.asciiz 	"Please enter the amount of coupon "
colon: 	 	.asciiz 	": "
ItemArr: 	.word 	 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
CouponArr: 	.word 	 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
total: 	 	.asciiz 	"\nYour total charge is: $"
thankyou: 	.asciiz 	"\nThank you for shopping with us!"
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
Back1: 	 	li 	$v0, 4 	 		#ask user to enter the number of items
 		la 	$a0, prompt1
 		syscall
 		
 		li 	$v0, 5 	 		#read integer into register $v0
 		syscall
 		
 		add 	$t0, $v0, $0 		#store $v0 into $t0, this is the array size of ItemArr
 		
 		bgt 	$t0, 20, Error1 	#checks if bigger than 20, if so then jump to error 1
 		
 		la 	$t3, ItemArr 	 	#$t3 points to first location of array(index zero) with address ItemArr
 		
 		add 	$a0, $t0, $0 	 	#pass item amount to function by $a0
 		add 	$a1, $t3, $0 	 	#pass array pointer to function by $a1
 	 	jal 	FillItem 	 	#go to FillItem subroutine
 	 	
 	 	add 	$t2, $v1, $0 	 	#return price sum
 	 	
Back2: 	 	li 	$v0, 4 	 	 	#prompt user for amount of coupons
		la 	$a0, prompt2
		syscall
		
		li 	$v0, 5 	 	 	#read integer into register $v0
		syscall
		
		add 	$t5, $v0, $0 	 	#store $v0 into $t5
		
		bne  	$t0, $t5, Error2 	#checks if coupon amount matches item amount, if not, jump to error2
		
		la 	$t6, CouponArr 	 	#$t6 points to first location of array(index zero) with address CouponArr
		
		add 	$a0, $t5, $0 	 	#pass coupon amount to function by $a0
		add 	$a1, $t3, $0 	 	#pass item array pointer to function by $a1
		add 	$a2, $t6, $0 	 	#pass coupon array pointer to function by $a2
 	 	jal 	FillCoupon 	 	#go to FillCoupon subroutine	
 	 	
 	 	add 	$t7, $v1, $0 	 	#return coupon sum
 	 	
 	 	sub 	$t2, $t2, $t7 	 	#subtract coupon amount from item sum
 	 	
 	 	li	$v0, 4 	 	 	#border
 		la 	$a0, border
 		syscall
 	 	
 	 	li	$v0, 4 	 		#display total	
 		la 	$a0, total 	 	
 		syscall
 		
 		li 	$v0, 1			#display total
		add 	$a0,$t2,$0
		syscall
		
		li	$v0, 4 	 		#closing statement
 		la 	$a0, thankyou 	 	
 		syscall
 	 	
 		#end of program
		li 	$v0, 10		
	 	syscall
 	 
 		
Error1: 	li 	$v0, 4 	 	 	#display error message that num is too big
 	 	la 	$a0, error1
 	 	syscall
 	 	j 	Back1 	 		#jump to Back1 so user can try again
 	 	
Error2: 	li 	$v0, 4 	 	 	#display error message that coupon amount doesn't match item amount
		la 	$a0, error2
		syscall
		j 	Back2 	 	 	#jump to Back2 so user can try again
 
#***********************************************start of FillItem*********************************************************************
FillItem: 	add 	$t0, $a0, $0 	 	#pass item amount to function by $a0
		li 	$t1, 0 	 		#initialize counter to zero
 	 	li 	$t2, 0 	 		#initialize sum to zero
 	 	add 	$t3, $a1, $0 	 	#pass array pointer to function by $a0
 	 	
FillArray: 	beq 	$t1, $t0, SumUp1 	#checks if counter is equal to array size. If so, end loop
 	 	addi 	$t1, $t1, 1 	 	#increment counter
		li	$v0, 4 	 	 	#ask user for element(s)
 		la 	$a0, enter1 	 	
 		syscall
 		li 	$v0, 1			#display counter
		add 	$a0,$t1,$0
		syscall
		li	$v0, 4 	 		#colon 	
 		la 	$a0, colon 	 	
 		syscall
 		li  	$v0, 5 			#Get input from user
		syscall
		sw  	$v0, 0($t3) 		#Store the number into the array
		addi 	$t3, $t3, 4 		#increment $t3 (the arraypointer) by 4 to point to the next position
		j  	FillArray 	 	#loop
SumUp1: 	blt 	$t1, $0, Done  		#checks if counter equal to zero, if so jump to done
 	 	lw 	$t4, 0($t3) 		##Take element out of array and load it to register $t4
 	 	add 	$t2, $t2, $t4	 	#Add element to sum register
 	 	addi 	$t3, $t3, -4 	 	#decrement $t1 (the arraypointer) by 4 to point to the next position
 	 	addi 	$t1, $t1, -1 	 	#decrement counter
 	 	j 	SumUp1
 	 	
Done: 	 	add 	$v1, $t2, $0 		#return item sum
		jr 	$ra 	 	 	#jump to main	 	
#***********************************************start of FillCoupon*********************************************************************
FillCoupon: 	add 	$t5, $a0, $0 	 	#pass coupon amount to function by $a0
		add 	$t3, $a1, $0 	 	#pass item array pointer to function by $a1
		add 	$t6, $a2, $0 	 	#pass coupon array pointer to function by $a2
		li 	$t1, 0 	 		#initialize counter to zero
		li 	$t7, 0 	 	 	#initialize sum to zero
CollectCoupon: 	beq 	$t5, $t1, SumUp2 	#checks if counter is equal to array size. If so, end loop
 	 	addi 	$t1, $t1, 1 	 	#increment counter
		li	$v0, 4 	 	 	#ask user for element(s)
 		la 	$a0, enter2 	 	
 		syscall
 		li 	$v0, 1			#display counter
		add 	$a0,$t1,$0
		syscall
		li	$v0, 4 	 		#colon 	
 		la 	$a0, colon 	 	
 		syscall
 		li  	$v0, 5 			#Get input from user
		syscall
		
		add 	$t8, $v0, $0 	 	#store $v0 into $t8
		addi 	$t3, $t3, 4 		#increment $t3 (the itemarraypointer) by 4 to point to the next position
		lw 	$t9, 0($t3) 		#Take element out of array and load it to register $t9
		
		
		
		bgt 	$t8, $t9, Error3
		bgt 	$t8, 10, Error3
	
		sw  	$t8, 0($t6) 		#Store the number into the array
		addi 	$t6, $t6, 4 		#increment $t6 (the couponarraypointer) by 4 to point to the next position
		#addi 	$t3, $t3, 4 		#increment $t3 (the itemarraypointer) by 4 to point to the next position
		j  	CollectCoupon 	 	#loop
		
Error3: 	li 	$v0, 4 	 	 	#display error message that coupon is invalid
 	 	la 	$a0, error3
 	 	syscall
 	 	sw  	$0, 0($t6) 		#Store the number into the array
 	 	addi 	$t6, $t6, 4 		#increment $t6 (the couponarraypointer) by 4 to point to the next position
 	 	#addi 	$t3, $t3, 4 		#increment $t3 (the itemarraypointer) by 4 to point to the next position		 	
 	 	j 	CollectCoupon 	 	#jump to CollectCoupon   
SumUp2: 	blt 	$t1, $0, Stop  		#checks if counter equal to zero, if so jump to stop
		lw 	$t9, 0($t6) 		##Take element out of array and load it to register $t9
 	 	add 	$t7, $t7, $t9	 	#Add element to sum register
 	 	addi 	$t6, $t6, -4 	 	#decrement $t1 (the arraypointer) by 4 to point to the next position
 	 	addi 	$t1, $t1, -1 	 	#decrement counter
 	 	j 	SumUp2

Stop: 	 	add 	$v1, $t7, $0 	 	#return coupon sum
		jr 	$ra 	 	 	#jump to main