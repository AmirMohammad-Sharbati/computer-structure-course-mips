#402106112 - 402106394

.macro READ_INT(%reg)
  li $v0, 5
  syscall
  move %reg, $v0 
.end_macro


.macro PRINT_INT(%reg)
  li $v0, 1
  move $a0, %reg
  syscall
.end_macro


.macro PRINT_WHITESPACE(%syscall_num)
  li $v0, 11  # 11 for printing character
  li $a0, %syscall_num  
  syscall
.end_macro


.macro SORT_TWO_NUMBERS (%num1, %num2, %bigger, %smaller)
  add $t5, %num1, %num2  # This is for calculating smaller based on bigger
  sub $t7, %num1, %num2
  srl $t6, $t7, 31   # This is sign bit (I call it x)
  
  sub $t7, %num2, %num1
  mul $t7, $t7, $t6
  add %bigger, $t7, %num1  # bigger one is: x*(num2-num1) + num1
  
  sub %smaller, $t5, %bigger  # another one is (num1+num2)-bigger.
.end_macro


.macro REVERSED_BINARY(%number)
  andi $t3, %number, 1
  PRINT_INT($t3)
  
  andi $t3, %number, 2
  srl $t3, $t3, 1
  PRINT_INT($t3)
  
  andi $t3, %number, 4
  srl $t3, $t3, 2
  PRINT_INT($t3)
  
  andi $t3, %number, 8
  srl $t3, $t3, 3
  PRINT_INT($t3)
  
  andi $t3, %number, 16
  srl $t3, $t3, 4
  PRINT_INT($t3)
.end_macro


.text
.globl main

main:
  # get inputs (inputs are in three lines)=> s0,s1 and s2 are inputs
  READ_INT($s0)
  READ_INT($s1)
  READ_INT($s2) 
  
  # for sorting, I sub them from each other and check sign bit.
  SORT_TWO_NUMBERS ($s0, $s1, $t0, $t1)
  SORT_TWO_NUMBERS ($t1, $s2, $t1, $t2)
  SORT_TWO_NUMBERS ($t0, $t1, $t0, $t1)
  # now sorted values are t0, t1, t2
  
  PRINT_INT($t0)
  PRINT_WHITESPACE(32) # The ASCII code for a space is 32
  
  PRINT_INT($t1)
  PRINT_WHITESPACE(32)
  
  PRINT_INT($t2)
  PRINT_WHITESPACE(10) # The ASCII code for a newline is 10
  
  # now I should implement second functionality
  REVERSED_BINARY($t0)
  PRINT_WHITESPACE(32)
  
  REVERSED_BINARY($t1)
  PRINT_WHITESPACE(32)
  
  REVERSED_BINARY($t2)
    
