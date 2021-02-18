
# This is an example of a counter that counts from
# 0 to 10 printing the current count to the console.
	
		.data
str:		.asciiz "\nCounter is i = "
		
		.text
		.globl main

main:		addi $s1,$zero,0	# i = 0
		addi $s2,$zero,10	# end of count is 10


Loop:		slt  $s0,$s2,$s1	# 10 < i?
		bne  $s0,$zero,Exit
	
		li $v0, 4		# system call code for print_str
		la $a0, str
		syscall
	
		li $v0,1		# system call code for print_int
		add $a0, $zero, $s1
		syscall

		addi $s1,$s1,1		# increment counter
		j Loop

Exit:		li $v0,10		# end of program
		syscall