.data
str1: 	.asciiz 	"Program Description:\t\t\t"
str2: 	.asciiz 	"A simple program to output string and integer"
str3: 	.asciiz 	"\nAuthor:\t\t\t\t\t"
str4: 	.asciiz 	"Carter Rath"
str5: 	.asciiz 	"\nCreation Date:\t\t\t\t"
str6: 	.asciiz 	"09/08/2021"
str7: 	.asciiz 	"\n The Course number\t\t\t"
str8: 	.asciiz 	"\nThe year in program\t\t\t"
.text
main:
#printing program description
 	li 	 	$v0, 4
 	la 	 	$a0, str1
 	syscall
  	li 	 	$v0, 4
 	la 	 	$a0, str2
 	syscall
#printing author
 	li 	 	$v0, 4
 	la 	 	$a0, str3
 	syscall
  	li 	 	$v0, 4
 	la 	 	$a0, str4
 	syscall
#printing creation date
 	li 	 	$v0, 4
 	la 	 	$a0, str5
 	syscall
  	li 	 	$v0, 4
 	la 	 	$a0, str6
 	syscall
#printing course number
 	li 	 	$v0, 4
 	la 	 	$a0, str7
 	syscall
  	li 	 	$v0, 1
 	li 	 	$a0, 231
 	syscall
#printing year in program
 	li 	 	$v0, 4
 	la 	 	$a0, str8
 	syscall
  	li 	 	$v0, 1
 	li	 	$a0, 3
 	syscall
#end of program
	 li 	 	$v0, 10
	 syscall
