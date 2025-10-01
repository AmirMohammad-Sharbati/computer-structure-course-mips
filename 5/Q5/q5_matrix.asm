#402106112 - 402106394
.data
N: .word 3
M: .word 2
P: .word 4
A: .word 1, 2, 3, 4, 5, 6                  # { {1, 2}, {3, 4}, {5, 6} }
B: .word 8, 7, 6, 5, 4, 3, 2, 1            # { {8, 7, 6, 5}, {4, 3, 2, 1} }
result:     .space 48        # result is matris of A*B


.text
.globl main

main:
     lw $s0, N($zero)
     lw $s1, M($zero)
     lw $s2, P($zero)
     li $s3, 4   # $s3 = immediate of 4
     
     li $t0, 0    # $t0 = counter    0 <= counter < N*P      $t0 is counter for result matrix
     li $t1, 0    # $t1 = i          0 <= i < N
first_loop:     
     li $t2, 0    # $t2 = j          0 <= j < P
second_loop:
     li $t3, 0    # $t3 = k          0 <= k < M
third_loop:
     mul $t4, $s1, $t1
     add $t4, $t4, $t3    # $t4 = (M*i)+k
     mul $t4, $t4, $s3    # $t4 * 4
     mul $t5, $s2, $t3
     add $t5, $t5, $t2    # $t5 = (P*k)+j
     mul $t5, $t5, $s3    # $t5 * 4
     
     lw $t4, A($t4)       # $t4 = A[(M*i)+k]
     lw $t5, B($t5)       # $t5 = B[(P*k)+j]
     mul $t4, $t4, $t5
     add $t6, $t6, $t4
     
     addi $t3, $t3, 1    # k++
     bne $t3, $s1, third_loop
# finish third loop
     sw $t6, result($t0)
     addi $t0, $t0, 4
     li $t6, 0
     
     addi $t2, $t2, 1
     bne $t2, $s2, second_loop
# finish second loop
     addi $t1, $t1, 1
     bne $t1, $s0, first_loop
# finish first loop


     
exit:
     li $v0, 10
     syscall
     

     
     
