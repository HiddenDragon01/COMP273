# This is an example of a call to a subroutine that
# is recursive. It implements the factorial via the
# strategy n! = n * (n-1)!
# The result is printed to the console.
	
	.data
str:	.asciiz "\n\t Result is "

	.text
	.globl main

main:	
	
	addi  $s0,$zero,10	# n = 6

	add $a0,$s0,$zero	# pass the argument "n" in $a0
	jal  fact		# call the factorial subroutine
	add $s1,$v0,$zero	# save the result stored in $v0 in $s1		
	
	li $v0, 4		# system call code for print_str
	la $a0, str
	syscall

	li $v0,1		# system call code for print_int
	add $a0, $zero, $s1     # pass the result to be printed in $a0
	syscall

	j Exit			# could be li $vo,10 ...syscall

	
fact: 	addi $sp,$sp,-8		# create space for two words on the stack
	sw $ra,4($sp)		# save $ra on the stack			
	sw $a0,0($sp)		# save the argument "n" passed to fact on the stack

	slti $t0,$a0,1		# test for n < 1
	beq $t0,$zero,L1	# if n>=1, go to L1
	addi $v0,$zero,1	# 0! = 1

	addi $sp,$sp,8		# pop two items off the stack
	jr $ra

L1:	addi $a0,$a0,-1		# n = n-1
	jal fact		# (n-1)! will be in $v0

	lw $ra,4($sp)
	lw $a0,0($sp)
	mul $v0,$v0,$a0		# n! = n x (n-1)!

	addi $sp,$sp,8		# pop two items off the stack
	jr $ra
	

Exit:	nop			# end of program
