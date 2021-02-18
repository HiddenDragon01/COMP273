# This program illustrates an example of working with a string.
# The test string is hardcoded. The routine uses pointers to
# first find the end of the string and then reverse the contents
# of the original string, element by element.

	.data

string: .asciiz "tah eht ni tac ehT"
blank:	.asciiz "\n"


	.text
	.globl main

main:  la  $t0, string		# $t0 and $t1 are pointers to 
       la  $t1, string		# to the first element of the string
       
       li  $v0, 4		# print the original string
       la  $a0, string
       syscall
       
       li  $v0, 4		# print a blank line
       la  $a0, blank
       syscall
        
loop1: lb $t3, 0($t1)		# advancing $t1 till it points to the end 
       addi $t1, $t1, 1		# of the string, signalled by a NULL character
       bne $t3, $0, loop1	# with the value 0.
        
       addi $t1, $t1, -1	# decrement $t1 to point to the NULL character.
        
loop2: ble $t1, $t0, exit	# string reversal, byte by byte
       addi $t1, $t1, -1
       lb $t3, 0($t1)
       lb $t4, 0($t0)
       sb $t4, 0($t1)
       sb $t3, 0($t0)
       addi $t0, $t0, 1
       j  loop2

exit:  li  $v0, 4		# print the reversed string
       la  $a0, string
       syscall

       li $v0, 10		# terminate program
       syscall