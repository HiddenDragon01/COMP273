# This MIPS program contains a main function which will call the subroutine
# 'palind' to determine whether an input string is a palindrome (or not).
# It will then present the result of the palindrome test.


	.data
string: .asciiz "swabce1111111111ecbaws"
yes: 	.asciiz "The string is a palindrome.\n"
no: 	.asciiz "The string is not a palindrome.\n"
	
	.text
	.globl main

# main routine begins here
main:  la  $a0,string
       jal length
             
       add $a1,$v0,$zero	# call palind subroutine
       la $a0,string		# with length of string as
       jal palind		# its second argument, and pointer
				# to first element as first argument
       beq $zero,$v0,L1
	
       li $v0,4			# based on the result in $v0
       la $a0,yes		# printing yes or no
       syscall

       j Exit

L1:    li $v0,4
       la $a0,no
       syscall
	
Exit:  li $v0,10
       syscall

# length subroutine begins here	

length: add $t0,$zero,$zero	#initialize length counter $t0

loop:	lb $t1,0($a0)		#examine byte to see if 
	beq $t1,$zero,end       #it is the NULL character
	addi $t0,$t0,1
	addi $a0,$a0,1
	j loop

end:	add $v0,$t0,$zero	#return length in $v0
	jr $ra

# palind routine begins here
# $a1 has current length of string and $a0 is
# a pointer to the first element

palind: addi $sp,$sp,-4		# create 4 bytes on the stack to save $ra
	sw $ra,0($sp)           # to save $ra

	slti $t1,$a1,2		# if string has length < 2 return 1
	beq $t1,$zero,check	# otherwise continue checking
	addi $v0,$zero,1	
	j return
		
check:	lb $t1,0($a0)		# get first byte of string
	add $t2,$a1,$zero	# get length of string in $t2
	add $t2,$t2,$a0		# arithmetic on $t2 to get address
	addi $t2,$t2,-1		# of last element.
	lb $t3,0($t2)		# get last byte of string
	beq $t1,$t3,cont	# last byte is equal to first so continue
	add $v0,$zero,$zero	# last byte not equal to first so return 0
	j return
	
cont:	addi $a0,$a0,1		# call palind again but incrementing $a0
	addi $a1,$a1,-2		# and decreasing length by 2 
	jal palind

return:	lw $ra,0($sp)		# restore $ra and 
	addi $sp,$sp,4		# restore the stack
	jr $ra
	

