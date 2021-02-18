# This MIPS program prompts the user to enter the dimensions of an array.
# It then allocates memory for this array dynamically.
# It then initializes the array with integer entries.
# As the array is built its contents are printed to the terminal, with
# each row separated by a new line.


	.data
	
enterw:	.asciiz "Enter the width of the array: "
enterh:	.asciiz "Enter the height of the array: "
blank:	.asciiz " "
newline: .asciiz "\n"
done:	.asciiz "Done with main."

	.globl main
	
	.text 
	

main:	la $a0,enterw
	jal printstr
	jal readint
	move $t0,$v0		# $t0 holds the width

	la $a0, enterh
	jal printstr
	jal readint		
	move $t1,$v0		# $t1 holds the height

	mul $t2,$t0,$t1		# $t2 = width * height * 4
	sll $t2,$t2,2		

	move $a0,$t2		# allocate width * height * 4 bytes
	jal malloc
	
	add $t3,$v0,$zero	# $t3 now contains the address of the array
	
	move $a0,$t3		# copy array address, width and height to
	move $a1,$t0		# argument registers and then call initialize
	move $a2,$t1		# to initialize the array
	
	jal init
	
	la $a0,done		# print done
	jal printstr
	
	li $v0, 10		# terminate main program gracefully
	syscall



# The readint subroutine
readint: li $v0, 5
	syscall
	jr $ra
	
# The printint subroutine
printint: li $v0, 1
	syscall
	jr $ra

# The malloc subroutine
malloc: li $v0, 9
	syscall
	jr $ra
	
# Print string
printstr: li $v0, 4
	syscall
	jr $ra
	
		
# The initialize subroutine
init: 	addi $sp,$sp,-4		# need to save $ra
	sw $ra,0($sp)		# because of nested subroutine calls here

	move $t7,$a0		# pointer to the array, since $a0 will be used later
	move $s1,$zero		# initialize outer loop index "j"
	
outer:	move $s0,$zero		# initialize  inner loop index "i"
	
inner:	mul $t5,$s1,$a1		# j * width
	add $t5,$t5,$s0		# j * width + i
	sll $t5,$t5,2		# (j*width + i) x 4
	
	add $t6,$t7,$t5		# adding base address in $t7 to $t5
	sw $s0,0($t6)		# array[i][j] = i
	
	lw $a0,0($t6)		# print what you just stored
	jal printint
	
	la $a0,blank		# print a blank space
	jal printstr
	
	addi $s0,$s0,1		# i++
	slt $t4,$s0,$a1		# if i < width continue inner loop
	beq $t4,$zero,doneinner	
	
	j inner			
	
doneinner: 
	la $a0,newline		# print a new line
	jal printstr

	
	addi $s1,$s1,1		# j++
	slt $t4,$s1,$a2		# if j < height, set i to 0 and continue
	beq $t4,$zero,doneouter	# continue outer loop
	
	j outer
	
doneouter: 
	
	lw $ra,0($sp)		# restore $ra
	addi $sp,$sp,4		# and release stack
	
	jr $ra
