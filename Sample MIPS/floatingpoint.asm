# This example illustrates some floating point calculations.
# After each calculation the results are printed to the standard output.
	
	.data

val:	.float	3.0
str:	.asciiz "\n\n"

	.text
	.globl main

main:	la $t0,val		#$t0 holds address of val.

	li $v0,2		# system call code for print_float
	lwc1 $f12,0($t0)	# load the word at the address in $t0
	syscall			# into register $f12 and print it.

	li $v0,4		# print a new line.
	la $a0,str
	syscall

	mov.s $f0,$f12		# copy $f12 to $f0.
	add.s $f1,$f12,$f0	# add $f12 and $f0 and store in $f1.

	li $v0,2		# system call code for print_float
	mov.s $f12,$f1		# copy $f1 to $f12 and print the result.
	syscall

	li $v0,4		# print a new line.
	la $a0,str
	syscall

	li $v0,2		# multiply $f1 by $f1 and print
	mul.s $f12,$f1,$f1	# the result
	syscall

Exit:	nop			# end of program
