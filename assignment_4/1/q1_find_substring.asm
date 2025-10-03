.data
new_line: .asciiz "\n"


.text
.globl main

main:
     #get substring size
     li $v0, 5
     syscall 
     move $s0, $v0         # $s0 = m
     # allocate memmory for substring
     move $a0, $s0
     li $v0, 9
     syscall
     move $s1, $v0       # $s1 is first address of substring saved
     # get substring input
     move $a0, $s1
     li $v0, 8
     addi $a1, $s0, 2      # 2 = \n + null
     syscall
     # delete \n
     add $t0, $s1, $s0
     sb $zero, 0($t0)
     
     # get string size
     li $v0, 5
     syscall
     move $s2, $v0     # $s2 = n
     # allocate memory for string
     move $a0, $s2
     li $v0, 9
     syscall
     move $s3, $v0     # $s3 is first address of string saved
     # get string input
     move $a0, $s3
     li $v0, 8
     addi $a1, $s2, 2
     syscall
     # delete \n
     add $t0, $s3, $s2
     sb $zero, 0($t0)
     
     # print zero
     subi $t0, $s0, 1
print_zero:
     li $v0, 1
     move $a0, $zero
     syscall
     li $v0, 4
     la $a0, new_line
     syscall
     subi $t0, $t0, 1
     bnez $t0, print_zero
     
     # find number of substring in string
     sub $s4, $s2, $s0
     addi $s4, $s4, 1         #$s4 = n - m + 1
     move $t0, $zero           # $t0 is number of substring in string for each step
     move $t1, $zero           # $t1 is counter for string
     move $t5, $zero           # $t5 is loop counter
main_loop:
     move $t1, $zero           # $t2 is counter for substring
     move $t2, $t5
checking_loop:
     add $t3, $s1, $t1
     lb $t3, 0($t3)
     add $t4, $s3, $t2
     lb $t4, 0($t4)
     bne $t3, $t4, continue
     addi $t1, $t1, 1
     addi $t2, $t2, 1
     beq $t1, $s0, equal
     j checking_loop
     
continue:
     addi $t5, $t5, 1
     bne $t5, $s4, print_result 
     j exit      
     
equal:
     addi $t0, $t0, 1
     addi $t5, $t5, 1  
     bne $t5, $s4, print_result 
     j exit
     
print_result:
     li $v0, 1
     move $a0, $t0
     syscall
     li $v0, 4
     la $a0, new_line
     syscall
     j main_loop

exit:    
     li $v0, 1
     move $a0, $t0
     syscall
     
     li $v0, 10
     syscall
     
     
