# This is an example of prompting the user for inputs
# and writing out the corresponding entries. The example
# also implements a very basic counter.
	
	.data

str1:	.asciiz "\nEnter an Integer:\t"
str2:	.asciiz "The integer you entered is:\t"
	
const:  .word 10

	.text
	.globl main

main:	addi $s1,$zero,0	# i = 0
	addi $s2,$zero,4	# end of count is 4

	la $t1,const
	lw $t0,0($t1)

Loop:	slt  $s0,$s2,$s1	# 4 < i?
	bne  $s0,$zero,Exit

	li $v0, 4		# system call code for print_str
	la $a0, str1
	syscall

	li $v0,5		# system call code for read_int
	syscall

	add $t0, $zero, $v0     # copy $v0 to $t0

	li $v0, 4		# system call code for print_str
	la $a0, str2
	syscall

	li $v0, 1		# system call code for print_int
	add $a0, $zero, $t0     # $a0 now contains the integer input
	syscall

	addi $s1,$s1,1		# increment counter
	j Loop

Exit:	li $v0,10		# end of program
	syscall
