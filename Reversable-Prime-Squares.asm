#========================================================================================
#_________________________________________________________________________________________
# CODE_AIM: The following code displays reversible prime squares
# NAMES: Morapeli Christopher khalala
# STUDENT NUMBER: 202002857
# EMAIL: christopherkhalala434@gmail.com
# CONTACTS: 59083148
#________________________________________________________________________________________
#=========================================================================================
 
#			referece
# We call a number a reversible prime square if:
# • It is not a palindrome, and
# • It is the square of a prime, and Its reverse is also the square of a prime.



# REGISTER - VARIABLE REFERENCE
# prime: $s0
# num1: $s1
# num2: $s7
# num3: $s3
# i: $s6
# j: $s5
# reverse_func_out: $s2
# palindrome_func_out: $t0
# primechecker_func_out: $t5
# square_checker_func_out: $t2
# squareroot_func_out: $a1
#=====================================================================================================================
#					M A I N   S E C T I O N
#=====================================================================================================================


.data
	space: .asciiz "\n"
.text
.globl main

main:
	li $s6, 0
	li $s5 , 1
	WHILE:
	add $s0, $s0, $s6 # pass the value of i into prime so that the reverse function can iterate with the i value
	jal reverse_function
	add $s7, $s7, $s2  #num2 = reverses(i)
	
	#if(is_square(i) == true && is_square(num2) == true)
	jal is_square
	add $t1, $t1, $t2
	add $s6, $0, $s7
	jal is_square
	add $t3, $t3, $t2
	beq $t1, $s5, next_level
	j endd
	next_level:
	beq $t3, $s5, level2
	j endd
	level2:
	
	add $t7, $t7, $s6
	jal Square_root
	add $s1, $s1, $t7
	
	add $t7, $t7, $s7
	jal Square_root
	add $s3, $s3, $t7
	
	
	
	add $t5, $t5, $s1
	jal prime_checker
	add $t3, $t3, $t5
	
	
	add $t5, $t5, $s3
	jal prime_checker
	add $t0, $t0, $t5
	
	beq $t3, $s5, last
	j endd
	last:
	beq $t0, $s5, finish
	j endd
	
	finish:
	add $a0, $a0, $s6
	jal palindrome_checker
	add $t7, $t7, $a0
	
	beq $t7, $s5, printf
	j endd
	
	printf:
	li $v0, 1
	move $a0, $s6
	syscall
	
	li $v1, 0
	li $s4, 0
	beq $s4, $v1, Terminate
	addi $s4, $s4, 1
	
	
	
	endd:
	addi $s6, $s6, 1
	bgez $s6, WHILE
#			RETURN TO OPERATING SYSTEM 
Terminate:
	li $v0, 10
	syscall


# *****************************************************************************************************************

#					 SEARCH FOR A REVERSE SQUARE PRIME

# ******************************************************************************************************************
reverse_function:

	# int reverse = 0, reverse: $s2
	addi $s2, $zero, 0
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s2, 4($sp)
	
	beqz $s0, end #prime: $s0
	
	loop:
	
	
	
	
	
	
	# rev = (prime % 10)
		addi $t2, $0, 10 #10: $t2
		div $s0, $t2
		mfhi $v1
		move $t0, $v1 #rev: $t0
		
	
	
	#prime = prime/ 10
		div $s0, $t2
		mflo $v1
		move $a1, $v1
		
	#reverse = (reverse * 10) + rev
		mult $s2, $t2
		mflo $v1
		add $s2, $v1, $t0
		
	#return reverse
	
		li $v0, 1
		move $a0, $s2
		syscall
		
	# while ( prime != 0)
	
		bnez $s0, loop
	#this line is going to signal end of the program
	end:
		li $v0, 10
		syscall

	lw $s0, 0($sp)
	lw $s2, 4($sp)
	addi $sp, $sp, 8

	jr $ra






# *****************************************************************************************************************

#						 CHECKS FOR PRIME NUMBERS

# ******************************************************************************************************************
prime_checker:
addi $t2, $0, 2 #int i= 0	
addi $t5, $0,1 # is prime = true
addi $t1, $0, 1 # control
addi $t3, $0, 2 #for loop conditions

addi $sp, $sp, -16
sw $s0, 0($sp)
sw $t5, 4($sp)
sw $t1, 8($sp)
sw $t3, 12($sp)
sw $t2, 16($sp)


beqz $s0, set
beq $s0, $t1, set

div $s0, $t3
mflo $t0 
L1:
ble $t2, $t0, loop
j return

loop_under:
div $s0, $t2
mfhi $t6
beqz $t6,set
j L2

L2:
addi $t2, $t2, 1
j L1

set:
li $t5, 0
j return

return:
li $v0, 1
move $a0, $t5
syscall


lw $s0, 0($sp)
lw $t5, 4($sp)
lw $t1, 8($sp)
lw $t3, 12($sp)
lw $t2, 16($sp)

addi $sp, $sp, 16

jr $ra

# *****************************************************************************************************************

# 					FUNCTION TO CHECK FOR PALINDROMES

# ******************************************************************************************************************
palindrome_checker:
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $t0, 4($sp)
	li $t0, 0  # set register $t0 to false
	#li $a0, 961
	#li $a1, 961
	
	bne $s2, $s0, else
		li $t0, 1 # set register $t0 to 1 for true if $a0 and $a1 are equal
		
		li $v0, 1
		move $a0, $t0
		syscall
		b next
	else:
		
		li $v0, 1 
		move $a0, $t0
		syscall
		b next
		
	next:
		li $v0, 10
		syscalL
		
	
	lw $s0, 0($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 8

	jr $ra
	
# *****************************************************************************************************************

# CHECKS WHETHER THE PRIME NUMBER IS A SQUARE

#******************************************************************************************************************	

is_square:
li $t0, 1 #int i = 1
li $t2, 1 # square checker = true
addi $sp, $sp, -12
sw $s0, 0($sp)
sw $t2, 4($sp)
sw $t2, 8($sp)
li $s0, 1#prime


mul $t1, $t0, $t0 # prime = prime * prime

L14:
ble $t1, $s0, loop_return
j return
loop_return:
div $s0, $t0
mfhi $t3
div $s0, $t0
mflo $t4

beqz $t3,L22
j return
L22:
beq $t4, $t0, true
j return

true:
addi $t2, $0, 1
li $v0, 1
move $a0, $t2
syscall

li $v0, 10
syscall    # end to avoid looping
addi $t0, $t0, 1
j L1

returnto:
addi $t2, $0, 0

li $v0, 1
move $a0, $t2
syscall

lw $s0, 0($sp)
lw $t2, 4($sp)
lw $t2, 8($sp)

addi $sp, $sp, 12

jr $ra

#*********************************************************************************************
#			function to generate the suare root
#*********************************************************************************************
Square_root:
addi	$sp,$sp,-24
sw	$a1,12($sp)	
sw	$t1,0($sp)	
sw	$t2,4($sp)		
sw	$t3,8($sp)	
sw	$t4,16($sp)
sw	$t5,20($sp)
#REINITIALIZE TO ZERO
move	$t1,$0
move	$t2,$0
move	$t3,$0
move	$t4,$0
move	$t5,$0
#_____________________________________
move	$v0,$zero
addi	$t1,$0,1
addi	$t2,$0,1
beqz	$a1,return_value
beq	$a1,$t1,return_value
while2:
ble	$t1,$a1,L4
j	output
L4:
addi	$t2,$t2,1
mult	$t2,$t2
mflo	$t1
j	while2
output:
subi	$t7,$t2,1
add	$v1,$0,$t7
j	end5
return_value:
move	$t7,$a1
j	end5
end5:
add	$v1,$0,$t7
lw	$t1,0($sp)
lw	$t2,4($sp)	
lw	$t3,8($sp)
lw	$t4,16($sp)
lw	$t5,20($sp)
addi	$sp,$sp,24
jr	$ra		



