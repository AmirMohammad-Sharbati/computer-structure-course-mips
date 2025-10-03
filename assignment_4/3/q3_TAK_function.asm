.text
.globl main

main:
     li $v0, 5
     syscall
     move $a0, $v0
     
     li $v0, 5
     syscall
     move $a1, $v0
     
     li $v0, 5
     syscall
     move $a2, $v0
     
     jal TAK

     move $a0, $v0
     li $v0, 1
     syscall
     
     li $v0, 10
     syscall


TAK:
     subi $sp, $sp, 20
     sw $ra, 16($sp)
     sw $s0, 12($sp)
     move $s0, $a0
     sw $s1, 8($sp)
     move $s1, $a1
     sw $s2, 4($sp)
     sw $s3, 0($sp)
     move $s2, $a2
     
     ble $s0, $zero, base_case1    # x <= 0
     ble $s1, $zero, base_case2    # y <= 0
     ble $s2, $zero, first_recursive   # z <= 0
     j second_recursive   # else               
     
base_case1:
     move $v0, $s1      # return y
     j finish_function     
     
base_case2:
     move $v0, $s2     # return z
     j finish_function
     
first_recursive:
     subi $a0, $s0, 1
     subi $a1, $s1, 1
     move $a2, $s2
     jal TAK          # return TAK(x-1, y-1, z)
     j finish_function
     
second_recursive:
     subi $a0, $s1, 1
     move $a1, $s2
     move $a2, $s0
     jal TAK         # Tak(y-1, z, x)
     move $s3, $v0
     move $a0, $s1
     subi $a1, $s2, 1
     move $a2, $s0
     jal TAK         # TAK(y, z-1, x)
     subi $a0, $s0, 1
     move $a1, $s3
     move $a2, $v0
     
     jal TAK        # return TAK(x-1, Tak(y-1, z, x), TAK(y, z-1, x))

finish_function:
     lw $ra, 16($sp)
     lw $s0, 12($sp)
     lw $s1, 8($sp)
     lw $s2, 4($sp)
     lw $s3, 0($sp)
     addi $sp, $sp, 20
     jr $ra
