# This is a version of the multiply example discussed in class
# and presented also in the textbook.
# The code starts with a data section in which a string is
# defined. This is followed by a text section which contains
# the definition of the subroutine Mul, followed by the main
# program. Note that there must exist a single program called
# main and we use the .globl directive to make its definition "global".
	
	.data
str:	.asciiz "Result is: "

	.text
	.globl main



main:	addi $s1,$zero,5	# j = 5
	addi $s2,$zero,4	# k = 4

	add $a0,$s1,$0		# arg0 = j
	add $a1,$s2,$0		# arg1 = k
	jal Mul			# call Mul to compute j*k

	add $s0,$zero,$v0	# i = j*k
	
	add $a0,$zero,$v0
	add $a1,$zero,$v0
	
	jal Mul			# call Mul again
	add $s3,$zero,$v0	# m = (j*k)*(j*k)

	li $v0, 4		# system call code for print_str
	la $a0, str
	syscall
	
	li $v0,1		# system call code for print_int
	add $a0, $zero, $s3
	syscall
	
	j Exit


Mul:	add  $t0,$zero,$zero	# prod=0

Loop:	slt  $t1,$zero,$a1	# mlr > 0?	
	beq  $t1,$zero,Fin	# no=>Fin	
	add  $t0,$t0,$a0	# prod+=mc	
	addi $a1,$a1,-1		# mlr-=1   
	j    Loop		# goto Loop
Fin:	add  $v0,$t0,$0		# $v0=prod		
	jr   $ra		# return

Exit:	li   $v0,10		# terminate mips program
	syscall
