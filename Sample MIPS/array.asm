# This is an example of allocating space for an array and
# then initializing its contents. After the contents are
# initialized they are printed out in reverse order.
	
	.data

array:	.space 20		# allocate 20 bytes for 5 words

str1:	.asciiz "\nEnter an Integer:	"
str2:	.asciiz "\nArray element is:	"
	
	.text
	.globl main

main:	la $s3,array		# $s3 contains the address of the first array element

	addi $s1,$zero,0	# i = 0
	addi $s2,$zero,4	# end of count is 4

# Read in 5 integers and store them as successive array elements.

Loop:	slt  $s0,$s2,$s1	# 4 < i?
	bne  $s0,$zero,L1

	li $v0, 4		# system call code for print_str
	la $a0, str1
	syscall

	li $v0,5		# system call code for read_int
	syscall

	sw $v0,0($s3)		# the integer entered is written into an array location
	addi $s3,$s3,4		# $s3 now contains the address of the next array element

	addi $s1,$s1,1		# increment counter
	j Loop

# Now write out the 5 array elements.
	
L1:	addi $s1,$zero,0	# i = 0 again

Loop1:	addi $s3,$s3,-4		# $s3 contains address of element to be printed
	slt  $s0,$s2,$s1	# 4 < i?
	bne  $s0,$zero,Exit

	li $v0, 4		# system call code for print_str
	la $a0, str2
	syscall

	li $v0,1		# system call code for print_int
	lw $a0,0($s3)
	syscall

	addi $s1,$s1,1		# increment counterb
	j Loop1

Exit:	li $v0,10		# End of program
	syscall
