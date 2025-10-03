.text
.globl main

main:
     # get input
     li $v0, 5
     syscall
     move $s0, $v0    # $s0 = n
     subi $s4, $s0, 1    # $s3 = n-1
     
     # allocate memory
     move $a0, $s0
     li $v0, 9
     syscall 
     move $s1, $v0    # $s1 is address of first byte of allocated address
     
     li $t0, 0   # $t0 is counter for loop
     move $t1, $s1
Loop_get_numbers:
     li $v0, 5
     syscall
     sw $v0, 0($t1)
     addi $t1, $t1, 4
     addi $t0, $t0, 1
     bne $t0, $s0, Loop_get_numbers
     
     li $s3, 0    # $s3 = result
find_pairs_of_prime:
     move $t5, $s1
     li $t0, 0    # $t0 is counter for first loop    $t0=i
first_loop:
     move $t1, $t0   # $t1 is counter of second loop   $t1=j
     addi $t1,$t1, 1
     move $t6, $t5
     addi $t6, $t6, 4
second_loop:
     lw $t2, 0($t5)
     lw $t3, 0($t6)
     # call function
     move $a0, $t2
     move $a1, $t3
     subi $sp, $sp, 12
     sw $t0, 8($sp)
     sw $t1, 4($sp)
     sw $t2, 0($sp)
     jal coprime
     lw $t0, 8($sp)
     lw $t1, 4($sp)
     lw $t2, 0($sp)
     addi $sp, $sp, 12
     beq $v0, 1, find_pairs
increase_counter:
     addi $t6, $t6, 4
     addi $t1, $t1, 1
     bne $t1, $s0, second_loop   # j != n
     addi $t5, $t5, 4
     addi $t0, $t0, 1
     bne $t0, $s4, first_loop     # i != n-1
     j print_result    
     
find_pairs:
     addi $s3, $s3, 1
     j increase_counter
     
print_result:
     move $a0, $s3
     li $v0, 1
     syscall     
     
     li $v0, 10
     syscall



coprime:
    move $t0, $a0                 
    move $t1, $a1                 

calc_gcd:
    beqz $t1, end_gcd        
    rem $t2, $t0, $t1             
    move $t0, $t1                 
    move $t1, $t2              
    j calc_gcd                    

end_gcd:
    li $v0, 1
    bne $t0, $v0, not_coprime     
    jr $ra

not_coprime:
    li $v0, 0
    jr $ra
