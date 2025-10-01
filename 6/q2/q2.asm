#402106112  -  402106394

.data
array: .space 100
newLine: .asciiz "\n"
.text 
.globl main
main:

    li $v0, 5
    syscall
    move $s0, $v0  

    move $t7, $s0    # t7 ???? ??????? ??????? ??? ???
    li $t8, 1        # t8 ???? ????? ????
    li $t9, 2        # t9 ???? ????
compute_power_loop:
    beq $t7, $zero, End_Power_Compute
    mul $t8, $t8, $t9
    subi $t7, $t7, 1
    j compute_power_loop
End_Power_Compute:

    move $s1, $t8  
    la $s2, array

main_processing:
    move $a0, $s1
    subi $a0, $a0, 1
    move $t3, $s0     
    subi $t3, $t3, 1  
    jal binary_converter

    subi $s1, $s1, 1
    slti $t4, $s1, 0
    bne $t4, $zero, Exit

    move $a0, $s0
    li $a1, 0
    subi $a2, $s0, 1
    jal check_two_one    

    subi $v0, $v0, 1
    bne $v0, $zero, display_output

    j main_processing

display_output:
    la $a0, array 
    li $v0, 4
    syscall

    la $a0, newLine
    li $v0, 4
    syscall
    j main_processing

Exit:
    li $v0 , 10
    syscall

check_two_one:

    subi $sp, $sp, 20
    sw $ra, 0($sp)
    sw $s3, 4($sp)
    sw $s4, 8($sp) 
    sw $s5, 12($sp)
    sw $s6, 16($sp)

    move $s3, $a0
    move $s4, $a1
    move $s5, $a2

    slti $t5, $s3, 3   
    bne $t5, $zero, base_case
    j recursive_call

base_case:
    add $t0, $s2, $s4
    lb $t1, 0($t0)  
    lb $t2, 1($t0)  
    subi $t1, $t1, '0'
    subi $t2, $t2, '0'
    mul $t3, $t1, $t2
    bne $t3, $zero, result_one 

    j result_zero

recursive_call:
    srl $a0, $s3, 1  
    addi $a0, $a0, 1
    move $a1, $s4
    addi $a1, $a1, 1
    addi $a2, $a1, 1

    jal check_two_one  
    move $s6, $v0 

    srl $t5, $s3, 1 
    sub $a0, $s3, $t5 
    move $a1, $a0
    srl $a1, $s3, 1
    subi $a2, $s3, 1  
    jal check_two_one

    srl $t5, $s3, 1
    subi $t6, $t5, 1  
    add $t6, $s2, $t6 
    addi $t7, $t6, 1  
    lb $t6, 0($t6)
    subi $t6, $t6, '0'
    lb $t7, 0($t7)
    subi $t7, $t7, '0'
    mul $t6, $t6, $t7

    or $t5, $s6, $v0
    or $t5, $t5, $t6
    j final_result

result_one:
    li $v0, 1
    j return_label

result_zero:
    li $v0, 0
    j return_label

final_result:
    move $v0, $t5
    j return_label

return_label:
    lw $ra, 0($sp)
    lw $s3, 4($sp)
    lw $s4, 8($sp)
    lw $s5, 12($sp)
    lw $s6, 16($sp)
    addi $sp, $sp, 20
    jr $ra   

binary_converter:

    li $t8, 2 
    move $t9, $a0 
    div $t9, $t8  
    mflo $t5  
    mfhi $t6  
    addi $t5, $t5, '0'       
    addi $t6, $t6, '0'       
    add $t7, $t3, $s2        
    sb $t6, 0($t7)           

    subi $t3, $t3, 1         
    div $a0, $a0, $t8  

    slti $t4, $t5, 50
    bne $t4, $zero, binary_output
    slti $t4, $t3, 0
    bne $t4, $zero, end_binary_conversion

    j binary_converter

binary_output:
    subi $t7, $t7, 1
    sb $t5, 0($t7)
    slti $t4, $t3, 0
    bne $t4, $zero, end_binary_conversion
    j binary_converter

end_binary_conversion:
    add $t4, $s2, $s0 
    sb $zero, 0($t4) 
    jr $ra
