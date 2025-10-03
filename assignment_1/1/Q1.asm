.text
.globl main

main:
  li $v0, 5
  syscall
  move $t0, $v0   # t0 = number1
  
  li $v0, 12
  syscall
  move $t2, $v0   # t2 = + or - (+ is 43 and - is 45)
  
  li $v0, 5
  syscall
  move $t1, $v0   #t1 = number2
  
  # !!For TA!! : Thank you so much, Please note that input is a little different from question
  # The + or - comes with number 2, like examples I provided for you.
  
  li $t3, 3
  and $s0, $t2, $t3   # s0 = 3 (11 in binary) for + and 1 for - => this is important number (I call it x)
  li $t3, 2
  sub $t3, $s0, $t3   # t3 is 1 for + and -1 for -
  
  xor $t3, $t1, $t3
  li $t4, 1
  add $t3, $t3, $t4   # This is important too. I calulate - with two's complement.
  	    # for + : if LSB is 0, xor with 1 becomes it 1 and I add another 1, 
  	    # so in this case I should sub it with 2, but for 1 in LSB, every thing is correct.
  and $t5, $t1, $t4   # t5 = LSB of number2 (and with 1 makes it)
  add $t5, $t5, $t5 
 
  and $t5, $t5, $s0   # y = (2*lsb) and x =>  0 for -, for + if lsb is 0, result is 0 and if is 1 result is 2
  
  sub $s0, $s0, $t4   # x -= 1
  sub $t5, $t5, $s0   # y - x
  
  add $t3, $t3, $t5   # t5 is -2 for + when lsb is 0. else t5 is 0
  add $t3, $t3, $t0
  
  move $a0, $t3
  li $v0, 1
  syscall
  
