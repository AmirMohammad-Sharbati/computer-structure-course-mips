.data
new_line:   .asciiz "\n"
positive:   .asciiz "+"
exponent:   .asciiz "^"
variable:   .asciiz "x"


.text
.globl main


main:
     li $v0, 5
     syscall 
     move $s0, $v0             # $s0 = n
     addi $t0, $s0, 1          # $t0 = n+1   
     mul $t0, $t0, 4      # $t0 is countrer for loop   $t0=(n+1)*4
     # allocate memory
     move $a0, $t0
     li $v0, 9
     syscall
     move $s1, $v0       # $s1 is first address of allocated memory for Coefficients of polynomial  
     
     subi $t0, $t0, 4
     add $t0, $t0, $s1
     subi $t1, $s1, 4
input_loop1:
     li $v0, 5
     syscall
     sw $v0, 0($t0)
     subi $t0, $t0, 4
     bne $t0, $t1, input_loop1
     j second_polynomial


     
second_polynomial:
     li $v0, 5
     syscall 
     move $s2, $v0             # $s2 = m
     addi $t0, $s2, 1          # $t0 = m+1   
     mul $t0, $t0, 4      # $t0 is countrer for loop   $t0=(m+1)*4
     # allocate memory
     move $a0, $t0
     li $v0, 9
     syscall
     move $s3, $v0       # $s3 is first address of allocated memory for Coefficients of polynomial  
     
     subi $t0, $t0, 4
     add $t0, $t0, $s3
     subi $t1, $s3, 4
input_loop2:
     li $v0, 5
     syscall
     sw $v0, 0($t0)
     subi $t0, $t0, 4
     bne $t0, $t1, input_loop2
     j make_result_polynomial
    
     
make_result_polynomial:
     mul $t0, $s0, 4
     add $t0, $t0, $s1
     move $t1, $s0
loop1:
     lw $t2, 0($t0)
     bnez $t2, max_exponent1
     subi $t0, $t0, 4
     subi $t1, $t1, 1
     bnez $t1, loop1
          
max_exponent1:   
     move $s4, $t1
     
     mul $t0, $s2, 4
     add $t0, $t0, $s3
     move $t1, $s2
loop2:
     lw $t2, 0($t0)
     bnez $t2, max_exponent2
     subi $t0, $t0, 4
     subi $t1, $t1, 1
     bnez $t1, loop2
          
max_exponent2:   
     move $s5, $t1
     
     add $s6, $s4, $s5       # $s6 is max exponent of result polynomial
     # allocate memory for result polynomial
     addi $a0, $s6, 1
     li $v0, 9
     syscall
     move $s7, $v0
     
     move $t0, $s0      # $t0 = n
     mul $t1, $s0, 4
     add $t1, $t1, $s1
first_loop:
     move $t2, $s2     # $t2 = m
     mul $t3, $s2, 4
     add $t3, $t3, $s3
second_loop:
     lw $t4, 0($t1)
     lw $t5, 0($t3)
     mul $t6, $t4, $t5        # mul of Coefficients
     
     add $t7, $t0, $t2
     mul $t7, $t7, 4
     add $t7, $t7, $s7
     
     lw $t8, 0($t7)
     add $t6, $t6, $t8
     
     sw $t6, 0($t7)
     
     subi $t3, $t3, 4
     subi $t2, $t2, 1
     bne $t2, -1, second_loop
      
     subi $t1, $t1, 4
     subi $t0, $t0, 1
     bne $t0, -1, first_loop
   
     
print_result:
     mul $t0, $s6, 4
     add $t0, $t0, $s7
     lw $t1, 0($t0)
     
     # print Coefficient of biggest polinomial
     move $a0, $t1
     beq $a0, 1, continue
     li $v0,1
     syscall
continue:
     # print x
     la $a0, variable
     li $v0, 4
     syscall
     # print ^
     la $a0, exponent
     li $v0, 4
     syscall
     # print biggest exponent
     move $a0, $s6
     li $v0, 1
     syscall
     
     
     subi $t0, $t0, 4
     subi $t1, $s6, 1
print_loop:
     lw $t2, 0($t0)
     beqz $t2, skip
     # positive or negative?
     slt $t3, $t2, $zero
     beq $t3, $zero, print_positive
continue_of_print:
     # print Coefficient
     lw $a0, 0($t0)
     beq $a0, 1, continuee
     li $v0, 1
     syscall
continuee:
     beqz $t1, exit
     
     # print x
     la $a0, variable
     li $v0, 4
     syscall
     # print ^
     la $a0, exponent
     li $v0, 4
     syscall
     # print exponent
     move $a0, $t1
     li $v0, 1
     syscall
     
     subi $t0, $t0, 4
     subi $t1, $t1, 1
     bne $t1, -1, print_loop
     j exit
             
skip:
     subi $t0, $t0, 4
     subi $t1, $t1, 1
     bne $t1, -1, print_loop
     j exit
     
print_positive:
     la $a0, positive
     li $v0, 4
     syscall
     j continue_of_print
     
exit:
     li $v0, 10
     syscall
     
     
