#402106112  -  402106394

.data
no:  .asciiz "NO, it is'nt palindrome"
yes: .asciiz "YES, it is palindrome"
input: .space 100

.text
.globl main

main:

    li $v0, 8
    la $a0, input
    li $a1, 50
    syscall

    li $t3, 0        
    move $t4, $a0    
loop:
    lb $t5, 0($t4)   
    beq $t5, $zero, End_loop
    addi $t3, $t3, 1
    addi $t4, $t4, 1
    j loop

End_loop:

    subi $t3, $t3, 1
    move $a0, $t3    
    li $a1, 0        
    subi $a2, $a0, 1 
    la $s1, input    
    jal Palindrom

    beq $v0, $zero, print_No

    li $v0, 4
    la $a0, yes
    syscall
    j Exit

print_No:
    li $v0, 4
    la $a0, no 
    syscall

Exit:
    li $v0, 10
    syscall

Palindrom:

    subi $sp, $sp, 16
    sw $a0, 12($sp)  
    sw $a1, 8($sp)  
    sw $a2, 4($sp)   
    sw $ra, 0($sp)  

    slti $t5, $a0, 2 
    beq $t5, $zero, continue
    addi $v0, $zero, 1
    addi $sp, $sp, 16
    jr $ra

continue:
    add $t4, $s1, $a1
    add $t5, $s1, $a2
    lb $t4, 0($t4)
    lb $t5, 0($t5)
    bne $t4, $t5, notEqual
    subi $a0, $a0, 2
    addi $a1, $a1, 1 
    subi $a2, $a2, 1
    jal Palindrom
    j end_function

notEqual:
    li $v0, 0
end_function:
    lw $ra, 0($sp)
    addi $sp, $sp, 16
    jr $ra
