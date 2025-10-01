#402106112 - 402106394
.data
newline: .asciiz "\n"
prompt:  .asciiz "****sorted numbers****\n"

.text
.globl main


main:
     # get input
     li $v0, 5
     syscall
     move $s0, $v0    # $s0 = n
     
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
     
     move $t0, $s1
     move $t1, $s0
sort_numbers:
     li $t2, 0
outer_loop:
     bge $t2, $t1, end_outer_loop
     li $t3, 0

inner_loop:
     sub $t4, $t1, 1
     bge $t3, $t4, end_inner_loop

     sll $t5, $t3, 2
     add $t5, $t5, $t0
     lw $t6, 0($t5)
     lw $t7, 4($t5)

     ble $t7, $t6, no_swap
     sw $t7, 0($t5)
     sw $t6, 4($t5)

no_swap:
     addi $t3, $t3, 1
     j inner_loop

end_inner_loop:
     addi $t2, $t2, 1
     j outer_loop

end_outer_loop:
     
print_result:
     la $a0, prompt
     li $v0, 4
     syscall 
     
     li $t0, 0
     move $t1, $s1
print_loop:
     lw $a0, 0($t1)
     li $v0, 1
     syscall
     
     la $a0, newline
     li $v0, 4
     syscall
     
     addi $t1, $t1, 4
     addi $t0, $t0, 1
     bne $t0, $s0, print_loop
   
exit:
     li $v0, 10
     syscall  
     
     
     
     
     
