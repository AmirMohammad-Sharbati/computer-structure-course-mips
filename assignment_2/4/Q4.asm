#402106394 - 402106112

.data
input_number: .word -250
shamt :      .word 4

.text
main:
     # $t0 = input
     lw $t0, input_number
     # find MSB bit of input
     srl $t2, $t0, 31          
     # if input is positive we just do shift right logical
     # $t1 is result
     lw $t3, shamt
     srlv $t1, $t0, $t3
     # if input is negative go to NEGATIVE else contiue
     li $t3, 1
     beq $t2, $t3, NEGATIVE
     # print result
     move $a0, $t1
     li $v0, 1
     syscall
     
     #finish the program
     li $v0, 10
     syscall

NEGATIVE:
     li $t3, 0xFFFFFFFF
     lw $t2, shamt    
     srlv $t4, $t3, $t2
     xor $t3, $t3, $t4
     
     or $t1 , $t1, $t3
     
     # print result
     move $a0, $t1
     li $v0, 1
     syscall
     
     #finish the program
     li $v0, 10
     syscall
     
     

