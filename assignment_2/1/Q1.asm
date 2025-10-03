.text
.globl main
# I should just check that a+b>c in all cases => a+b-c should be positive
main:
  li $v0, 5 	# system call for reading integer
  syscall
  move $t1, $v0  
  
  li $v0, 5 
  syscall
  move $t2, $v0  
  
  li $v0, 5 	
  syscall
  move $t3, $v0 
  
  # calculating a+b-c in three cases
  add $t5, $t1, $t2
  sub $t5, $t5, $t3
  
  add $t6, $t1, $t3
  sub $t6, $t6, $t2
  
  add $t7, $t2, $t3
  sub $t7, $t7, $t1
  
  # if all of them become positive the mul of them will be positive => sign bit is 0
  # else just one of them is negative => sign bit is 1
  
  mul $t5, $t6, $t5
  mul $t5, $t7, $t5
  
  srl $t5, $t5, 31
  subi $t5, $t5, 1   # the result is (x-1)^2 which x is sign bit
  mul $t4, $t5, $t5  # result is in t4
   
  li $v0, 1
  move $a0, $t4
  syscall
   
