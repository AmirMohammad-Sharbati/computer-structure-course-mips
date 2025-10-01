#402106112 - 402106394

.data
array: .word 3, -2 , 12, 20

.text
.globl main

main:
  la $t0, array
  lw $t1, 0($t0)
  lw $t2, 4($t0)
  lw $t3, 8($t0)
  lw $t4, 12($t0)
  
  li $v0, 5
  syscall
  move $t0, $v0
  
  mul $t5, $t0, $t0  # t5 is x^2
  mul $t6, $t0, $t5  # t6 is x^3
  
  mul $t6, $t1, $t6  # t6 is a*x^3
  mul $t5, $t2, $t5  # t5 is b*x^2
  mul $t0, $t3, $t0  # t0 is c*x
  
  add $t5, $t5, $t6  # a*x^3 + b*x^2
  add $t0, $t0, $t4  # c*x + d
  add $t0, $t0, $t5
  
  li $v0, 1
  move $a0, $t0
  syscall
