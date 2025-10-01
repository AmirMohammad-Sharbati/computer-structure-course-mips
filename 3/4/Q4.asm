#402106112 - 402106394
.data
num1: .word 51
num2: .word 32
max_value: .word 0 

.text
.globl main
main:
  lw $t0, num1
  lw $t1, num2
	
  sub $t2, $t0, $t1 # t2 = num1 - num2
  srl $t2, $t2, 31  # t2 = X if X == 0 num1 >= num2 else(X is 1) num1 < num2
  
  sub $t3, $t1, $t0 # num2-num1
  mul $t3, $t2, $t3 # t3 = X * (numb2-num1)
  add $t3, $t0, $t3 # t3 = num1 + X * (num2-num1) 
  # so if X == 0 max_value = num1 and X == 1 max_value = num2
  
  sw $t3, max_value

  # This is for testing	
  # move $a0, $t3
  # li $v0, 1
  # syscall
