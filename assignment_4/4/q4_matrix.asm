#402106112 - 402106394

.data
array:  .byte 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
result_array:  .space  16

.text
.globl main

main:
     li $t0, 4
     move $t1, $zero        # loop counter      0 <= $t1 <= 3
     li $t2, 3        # $t2 for first row is 3 for second row is 2 for third row is 1 and for forth row is 0
     la $t4, array      # array+0 <= $t4 =< array+15
     la $t5, result_array
loop:
     mul $t6, $t1, $t0
     add $t6, $t6, $t2        # $t6 = 4*$t1 + $t2
     add $t6, $t6, $t5
     lb $t7, 0($t4)
     sb $t7, 0($t6)
     addi $t4, $t4, 1
     addi $t1, $t1, 1
     bne $t1 , 4, loop
     move $t1, $zero
     subi $t2, $t2, 1
     beq $t2, -1, print_result
     j loop
     
     
print_result:
     la $t0, result_array
     addi $t2, $t0, 16
     move $t1, $zero
print_loop:
     lb $a0, 0($t0)
     li $v0, 1
     syscall
     li $a0, 32
     li $v0, 11
     syscall
     addi $t0, $t0, 1
     beq $t0, $t2, exit
     addi $t1, $t1, 1
     beq $t1, 4, print_new_line 
     j print_loop
     
print_new_line:
     li $a0, 10
     li $v0, 11
     syscall
     move $t1, $zero
     j print_loop          
      
exit:              
     li $v0, 10
     syscall
     
     
