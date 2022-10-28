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
# $v0 : prime
# $s1 : num1
# $s2 : num3
# $s3 : num2
# $a1 : i
#=====================================================================================================================
#					M A I N   S E C T I O N
#=====================================================================================================================


.data
	space: .asciiz "\n"
.text
.globl main

main:

jal callingFunc


#*********************************************************
#			RETURN TO OPERATING SYSTEM 
#*********************************************************

TERMINATE:
li	$v0, 10
syscall






# *****************************************************************************************************************

#					 SEARCH FOR A REVERSE SQUARE PRIME

# ******************************************************************************************************************


reverse:

addi $a1, $0, 12
beqz $a1, end #prime: $a1
	
loop:
	
	# int reverse = 0, reverse: $t1
addi $t1, $zero, 0
	
	
	
	
	# rev = (prime % 10)
addi $t2, $0, 10 #10: $t2
div $a1, $t2
mfhi $v1
move $t0, $v1 #rev: $t0
		
	
	
	#prime = prime/ 10
div $a1, $t2
mflo $v1
move $a1, $v1
		
	#reverse = (reverse * 10) + rev
mult $t1, $t2
mflo $v1
add $t1, $v1, $t0
		
#return reverse
	
li $v0, 1
move $a0, $t1
syscall
		
	# while ( prime != 0)
	
bnez $a1, loop
	#this line is going to signal end of the program
end:
li $v0, 10
syscall
jr $ra


# *****************************************************************************************************************

#						 CHECKS FOR PRIME NUMBERS

# ******************************************************************************************************************

prime_generator:

addi $t2, $0, 2 #int i= 0
addi $s0, $zero, 2 #prime
addi $t0, $0,1 # is prime = true
addi $t1, $0, 1 # control
addi $t3, $0, 2 #for loop conditions

beqz $s0, set
beq $s0, $t1, set

div $s0, $t3
mflo $t5 
L1:
ble $t2, $t5, Loop
j return

Loop:
div $s0, $t2
mfhi $t6
beqz $t6,set
j L2

L2:
addi $t2, $t2, 1
j L1






set:
li $t0, 0
j return

return:
#li $v0, 1
#move $a0, $t0
#syscall


jr $ra




# *****************************************************************************************************************

# 					FUNCTION TO CHECK FOR PALINDROMES

# ******************************************************************************************************************

palindrome_checker:

li $t0, 0  # set register $t0 to false
	#li $a0, 961
	#li $a1, 961
	
bne $a0, $a1, else
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
		
	
jr $ra



# *****************************************************************************************************************

# CHECKS WHETHER THE PRIME NUMBER IS A SQUARE

#******************************************************************************************************************	
is_square:
addi $sp, $sp, -30
li $s0, 1#prime
li $t0, 1 #int i = 1
li $t2, 1 # square checker = true

mul $t1, $t0, $t0 # prime = prime * prime

level1:
ble $t1, $s0, loop
j return
Loop1:
div $s0, $t0
mfhi $t3
div $s0, $t0
mflo $t4

beqz $t3,L2
j return
Level2:
beq $t4, $t0, true
j return

true:
addi $t2, $0, 1
li $v0, 1
move $a0, $t2
syscall

li $v0, 10
syscall    # end to avoid looping
syscall
addi $t0, $t0, 1
j L1

return0:
addi $t2, $0, 0

sw $s0, 1
sw $t0, 1 
sw $t2, 1 

jr $ra
#li $v0, 1
#move $a0, $t2
#syscall

#*********************************************************************************************
#			function to generate the suare root
#*********************************************************************************************
S_Rootgenerator:
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

# CALLING FUNCTION

callingFunc:
li $s1, 0	
li $s2, 0
li $s3, 0	
li $s4, 0	
li $s5, 0		
li $t1, 10
li $t3, 1

WHILE_LOOP:
move	$a1,$s1
bgez	$a1,L1_IF_STATEMENT
j	TERMINATE
#*********************************************************
#			LEVEL 1
#*********************************************************
L1_IF_STATEMENT:
jal	reverse
move	$s3,$v1
move	$v1,$zero
move	$a1,$s1
jal	is_square
move	$t2,$v0
move	$v0,$zero
beq	$t2,$t3,L2_IF_STATEMENT
j	ELSE_STATEMENT
#*********************************************************
#			LEVEL 2
#*********************************************************
L2_IF_STATEMENT:
move	$a1,$s3
jal	is_square
move	$t2,$v0
move	$v0,$zero
beq	$t2,$t3,L3_IF_STATEMENT
j	ELSE_STATEMENT
#*********************************************************
#			LEVEL 3
#*********************************************************
L3_IF_STATEMENT:
move	$a1,$s1
jal	S_Rootgenerator
move	$s4,$v1
move	$v1,$zero
move	$a1,$s3
jal	S_Rootgenerator
move	$s5,$v1
move	$v1,$zero
move	$a1,$s4
jal	prime_generator
move	$t2,$v0
move	$v0,$zero
beq	$t2,$t3,L4_IF_STATEMENT
j	ELSE_STATEMENT
#*********************************************************
#			LEVEL 4
#*********************************************************
L4_IF_STATEMENT:
move	$a1,$s5
jal	prime_generator
move	$t2,$v0
move	$v0,$zero
beq	$t2,$t3,L5_IF_STATEMENT		
j	ELSE_STATEMENT
#*********************************************************
#			LEVEL 5
#*********************************************************
L5_IF_STATEMENT:
bne	$s1,$s3,ELSE_STATEMENT1
j	ELSE_STATEMENT
#*********************************************************
#			ELSE 1
#*********************************************************
ELSE_STATEMENT1:
li	$v0,1
add	$a0,$zero,$s1
syscall
addi	$s2,$s2,1
li	$v0,4
la	$a0,space
syscall
beq	$s2,$t1,TERMINATE
j	ELSE_STATEMENT	
#*********************************************************
#			LEVEL 2
#*********************************************************
ELSE_STATEMENT:
addi	$s1,$s1,1
move	$v1,$zero
move	$v0,$zero
move	$a1,$zero
move	$t2,$zero
move	$s3,$zero
move	$v0,$zero
j	WHILE_LOOP

jr $ra