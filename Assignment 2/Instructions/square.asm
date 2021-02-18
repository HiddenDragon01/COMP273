# This program illustrates an exercise of determining whether an integer is a perfect square.
# The subroutine 'square' return 1 if the input is a perfect square or 0 otherwise, using an appropriate return register.
# The 'main' program should test the subroutine by first prompting the user for an integer to test, and then
# calling the subroutine with that integer as an argument. Determining on the outcome of the test, the
# 'main' program should generate an appropriate print statement.
# Feel free to add additional entries as you need them in the .text or .data segments.
# Make sure that your 'main' program terminates gracefully.
# Be sure to comment your code. Use proper register conventions!

	.data

prompt:	.asciiz "Enter a positive integer: \n"


	.text
	.globl main

main:

	jal square

square: