#402106112 - 402106394
.data
yes: .asciiz "YES"
no:  .asciiz "NO"


.text
.globl main


main:
     # get input
     li $v0, 5
     syscall
     move $s0, $v0    # $s0 is 8-bit binary input
     li $s1, 0        # $s1 is decimal of $s0
     
     # make decimal number
     li $t0, 10
     li $t3, 1
     move $t1, $s0
Loop:
     div $t1, $t0
     mflo $t1    # $t1 = $t1 / 10
     mfhi $t2    # $t2 = $t1 % 10
     bne $t2, 1 , skip_add
     add $s1, $s1, $t3
skip_add:
     mul $t3, $t3 , 2
     bne $t3, 256, Loop
     
            
                
checking_digits:
     li $t0, 10
     slt $t1, $s1, $t0
     beq $t1, 1, single_digit
     li $t0, 100
     slt $t1, $s1, $t0
     beq $t1, 1 , double_digit
     
     li $s2 , 3
     j checking_armstrong3


single_digit:
     li $s2, 1    # $s2 is number of digits
     j print_yes
double_digit:
     li $s2, 2
     
checking_armstrong2:
     andi $t0, $s0, 1
     andi $t1, $s0, 2
     mul $t0, $t0, $t0
     mul $t1, $t1, $t1
     add $t0, $t0, $t1
     beq $t0, $s0, print_yes
     j print_no
     
     
checking_armstrong3:
     li $t3, 10
     div $s1, $t3
     mfhi $t0
     mflo $t1
     div $t1, $t3
     mfhi $t1
     mflo $t2
     mul $t3, $t0, $t0
     mul $t0, $t0, $t3
     mul $t3, $t1, $t1
     mul $t1, $t1, $t3
     mul $t3, $t2, $t2
     mul $t2, $t2, $t3
     add $t0, $t0, $t1
     add $t0, $t2, $t0
     beq $t0, $s1, print_yes
     j print_no



print_yes:
     la $a0, yes
     li $v0, 4
     syscall
     
     li $v0, 10
     syscall
     
print_no:
     la $a0, no
     li $v0, 4
     syscall
     
     li $v0, 10
     syscall
     
     
