#PURPOSE: 	This program finds the maximum number of a
# 		set of data items.
#
#VARIABLES: 	The registers have the following uses:
#
# 		%edi - Holds the index of the data item being examined
# 		%ebx - Largest data item found
# 		%eax - Current data item
#
# 		The following memory locations are used:
#
# 		data_items - contains the item data. A 0 is used
# 			     to terminate the data
#
.section .data

data_items: 	# Numbers from which the maximum will be returned
	.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0

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
	# initialize the data pointer
	movl $0, %edi
	
	# move the first data item into %eax
	movl data_items(,%edi,4), %eax
	
	# since it must be the largest, move it into %ebx
	movl %eax, %ebx

_find_max:
	# zero marks end of list, check for end
	cmpl $0, %eax
	
	# if end of list, jump to end of program
	je _end_program

	# otherwise, increment the data pointer
	incl %edi

	# move the next data item into %eax
	movl data_items(,%edi,4), %eax

	# compare the new data item against the existing largest
	cmpl %ebx, %eax

	# if the new item is smaller, move to next item
	jle _find_max

	# otherwise, save this item
	movl %eax, %ebx

	# then move to next item
	jmp _find_max

_end_program:
	# return the largest
	RETURN %ebx
	
