# PURPOSE: 	Simple program that exits and returns a
# 		status code back to the Linux kernel
#
# INPUT: 	none
#
# OUTPUT: 	returns a status code. This can be viewed
# 	  	by typing
#
#  			echo $?
#
# 	  	after running the program
#
# VARIABLES:
#  		%eax holds the system call number
#  		%ebx holds the return status
#

.section .data

# this section stores code
.section .text

	# create a macro called RETURN
	# with a single parameter toRet
	.macro RETURN toRet
	
	# 1 is the linux system call for exiting a program
	movl $1, %eax
	
	# ebx is where we store the return code
	movl \toRet, %ebx
	
	# this wakes up the kernel to run the exit command
	int $0x80
	
	# end the macro
	.endm

# don't discard this symbol after assembly
.globl _start

# _start is the beginning of the program
_start:
	# use the macro to end the program
	RETURN $0
