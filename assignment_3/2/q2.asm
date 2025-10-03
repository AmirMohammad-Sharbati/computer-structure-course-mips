.text
.globl main

main:
     li $v0, 5
     syscall
     move $a0, $v0   # $a0 = a
     
     li $v0, 5
     syscall
     move $a1, $v0   # $a1 = b
     
     jal exponent
     
     move $a0, $v0
     li $v0, 1
     syscall
     
     
     li $v0, 10
     syscall
     
     
     
exponent:
     subi $sp, $sp, 8
     sw $ra, 4($sp)
          
     # base state in recursive function
     beqz $a1 , b_is_zero
     beq $a1 , 1 , b_is_one
     
     move $t0, $a0
     li $t1 , 2   # $t1 is counter
Loop:
     mul $t0, $t0, $t0
     move $t3, $t1
     mul $t1, $t1, $t1
     slt $t4, $a1, $t1
     beqz $t4 , Loop
     
call_exponent:
     sw $t0, 0($sp)
     sub $a1, $a1, $t3   # new_b = b - counter
     jal exponent    # exponent(a, b - counter)
     
return_result:
     lw $ra, 4($sp)
     lw $t0, 0($sp)
     addi $sp, $sp, 8
     mul $v0, $t0, $v0   # new_result = result * exponent(a , b - counter)
     jr $ra
     
     
          
b_is_zero:
     addi $sp, $sp, 8
     li $v0, 1
     jr $ra
b_is_one:
     addi $sp, $sp, 8
     move $v0, $a0
     jr $ra
          
          
          
          
          
