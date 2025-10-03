.macro READ_CHAR(%reg)
  li $v0, 12  # 8 for reading character
  syscall
  move %reg, $v0  
.end_macro

.macro BINARY_TO_DECIMAL_ONE_BIT(%des, %reg, %val) # des is destination register
  subi %reg, %reg, 48  # 48 is ascii code of 0.
  mul %des, %reg, %val
.end_macro

.macro BINARY_TO_DECIMAL(%des, %reg, %val) # This gets char and convert to decimal
  READ_CHAR(%reg)
  BINARY_TO_DECIMAL_ONE_BIT(%des, %reg, %val)
  add $t7, $t7, %des
.end_macro

.macro CONVERT_TO_HEX (%reg)
  or $t6, $s3, $s4
  and $t6, $t6, $s2
  li $t2, 39
  mul $t6, $t6, $t2 # if number > 9 it goes to a to f
  add $t5, %reg, $t6  # this is the ascii code of right digit in hexadecimal 
  addi $t5, $t5, 48 
.end_macro

.macro DECIMAL_TO_BINARY (%a, %b, %reg)
  and $t0, $s1, %a
  srl $t0, $t0, %b
  move %reg, $t0
  li $v0, 1  # 11 for printing character
  move $a0, $t0  # print newline
  syscall
.end_macro

.text
.globl main

main:
  # I get seven characters. first six of them is bits :)
  li $t7, 0 # This is the result of conveting binay to decimal
  BINARY_TO_DECIMAL($t0, $s0, 32)
  BINARY_TO_DECIMAL($t1, $s1, 16)
  move $t6, $t7
  
  BINARY_TO_DECIMAL($t2, $s2, 8)
  BINARY_TO_DECIMAL($t3, $s3, 4)
  BINARY_TO_DECIMAL($t4, $s4, 2)
  BINARY_TO_DECIMAL($t5, $s5, 1)
  
  sub $t5, $t7, $t6  # t5 now is sum decimal of right four bits
  CONVERT_TO_HEX ($t5) # after this t5 is right digit of hex
  READ_CHAR($t6) # this is enter which isn't important

  li $v0, 1
  move $a0, $t7
  syscall
  li $v0, 11  # 11 for printing character
  li $a0, 10  # print newline
  syscall
  
  li $v0, 1
  add $t6, $s0, $s0
  add $t6, $t6, $s1 # t6 is left digit of hexadecimal
  move $a0, $t6
  syscall
  
  li $v0, 11  # 11 for printing character
  move $a0, $t5  # print newline
  syscall
  
  li $v0, 11  # 11 for printing character
  li $a0, 10  # print newline
  syscall
  
  
  #######################   second part  ##################
  li $v0, 5
  syscall
  move $s1, $v0 # get decimal number in integer
  
  DECIMAL_TO_BINARY(32,5, $t7)
  DECIMAL_TO_BINARY(16,4, $t4)
  DECIMAL_TO_BINARY(8,3, $s2)
  DECIMAL_TO_BINARY(4,2, $s3)
  DECIMAL_TO_BINARY(2,1, $s4)
  DECIMAL_TO_BINARY(1,0, $t0)
  
  li $v0, 11 
  li $a0, 10
  syscall
  
  andi $s1, $s1, 15
  CONVERT_TO_HEX($s1) # t5 becomes right digit of hex
  
  li $v0, 1
  add $t6, $t7, $t7
  add $t6, $t6, $t4 # t6 is left digit of hexadecimal
  move $a0, $t6
  syscall
  
  li $v0, 11 
  move $a0, $t5  # print right digit 
  syscall
  
  
  