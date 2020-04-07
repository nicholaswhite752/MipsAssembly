.data

firstprompt: .asciiz "Enter first integer n1: \n"
secondprompt: .asciiz "Enter first integer n2: \n"
GCDAnswer: .asciiz "The greatest common divisor of n1 and n2 is: "
LCMAnswer: .asciiz "The least common multiple of n1 and n2 is: "
space: .asciiz "\n"

.text

main:

li $v0, 4 #syscall for string printing
la $a0, firstprompt #load printing address
syscall #prints

li $v0, 5 #reading an integer
syscall #reads n1 input
move $s0, $v0 #moves integer into t0

li $v0, 4 #syscall for string printing
la $a0, secondprompt #load printing address
syscall #prints

li $v0, 5 #reading an integer
syscall #reads n2 input
move $s1, $v0 #moves integer into t0

add $t0,$zero,$s0 #creates temporary registers for input values to be modified in recursive step
add $t1,$zero,$s1

GCDBase:
beq $t1,$zero,setgcd #checks to see if n2 is zero before and after recursive step
div $t0,$t1 #if n2 is not zero, then it divides the two inputs so a modulus can occur
mfhi $t2 #mod operation
move $t0, $t1 #moves original n2 into n1 for recursive step
move $t1, $t2 #moves modulus value into n2 slot for recursive step
j GCDBase #recursion

setgcd:
add $s2,$zero,$t0 #saves the GCD to s2

lcm:
mult $s0,$s1 #multiplies the two inputs
mflo $t1 #stores value of multiplication
div $t1,$s2 #divides multiplication of inputs by GCD
mflo $s3 #stores answer for LCM
j end #jumps to end and print statements

end:
li $v0, 4 #syscall for string printing
la $a0, GCDAnswer #load printing address
syscall #prints

move $a0, $s2 #sets up print of GCD
li $v0, 1 #initialize $v0 to print an integer
syscall #prints

li $v0, 4 #syscall for string printing
la $a0, space #load printing address for newline
syscall #prints

li $v0, 4 #syscall for string printing
la $a0,LCMAnswer #load printing address
syscall #prints

move $a0, $s3 #sets up print of GCD
li $v0, 1 #initialize $v0 to print an integer
syscall #prints

li $v0, 4 #syscall for string printing
la $a0, space #load printing address for newline
syscall #prints

li $v0, 10 #loads the syscall for system exit
syscall #exits
