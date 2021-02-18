# This program illustrates the exercise of finding the maximum and minimum values in an array.
# The array in this example has hardcoded initial values.
# The subroutine 'minmax' should return the minimum and maximum values
# in the array, using appropriate registers.
# The 'main' program should test the subroutine and should print the results using syscalls for printing.
# Feel free to add additional entries as you need them in the .text or .data segments.
# Make sure that your 'main' program terminates gracefully.
# Be sure to comment your code. Use proper register conventions!

	.data

# An array, with hard-coded values, to use for testing
array1:	.word 23, 45, -2, 4, 6, 42, 7, 35, 10, 2, -332, 101, 2, 3, 110, -1
size: .word 16

	.text
	.globl main


main:

	jal minmax

minmax:
