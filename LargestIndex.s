.data

prompt: .asciiz "Index of the largest number: "
A: .word 89, 19, 91, 23, 31, 46, 3, 67, 17, 11, 43, 73
size: .word 12

.text

main:
la $t0 A #loads arr address
lw $t1 size #loads arr size
li $t2, 0 #counter
li $t3, 0 #max number
li $t5, 0 #max index counter

start:bge $t2,$t1,end #if counter>size
lw $t4, 0($t0) #loads hte value in the current array index
bgt $t4,$t3, max #goes to max method
continue:
addi $t2, $t2, 1 #increments counter
addi $t0, $t0, 4 #increments array
j start #loops back to start

max:
add $t3, $zero, $t4 #adds the max number to register $t3 for comparison in the loop
add $t5, $zero, $t2 #keeps track of where the max number is indexed
j start #loops back to start

end:
li $v0, 4 #initialize $v0 to print a string
la $a0, prompt #puts string into an array to be printed
syscall #prints
move $a0, $t5 #moves the max number index into the printing array
li $v0, 1 #initialize $v0 to print an integer
syscall #prints
j $ra #ends program
