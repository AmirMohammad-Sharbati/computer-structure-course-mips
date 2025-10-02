#402106112 - 402106394
.data
result:    .asciiz "Roots are: \n"
newline:   .asciiz "\n"
.text
.globl main

main:   
  li $v0, 5 	# system call for reading integer
  syscall
  move $t0, $v0  # t0 = a
  
  li $v0, 5
  syscall
  move $t1, $v0  # t1 = b
  
  li $v0, 5
  syscall
  move $t2, $v0  # t2 = c
  
  mul $t3, $t1, $t1   # b^2 stored in $t3
  
  # Compute 4 * a * c -> t4
  li $t4, 4
  mul $t4, $t4, $t0     
  mul $t4, $t4, $t2
  
  sub $t5, $t3, $t4  # Compute t5 = b^2 - 4ac
  
  # compute sqrt(b^2 - 4ac) 
  mtc1 $t5, $f0     # Move into floating-point register $f0
  cvt.s.w $f0,$f0   # Convert integer to single-precision floating-point
  sqrt.s $f0, $f0   # Compute the square root of the value in $f0
  
  neg $t1, $t1      # t1 = -b
  
  sll $t0, $t0, 1   # t0 = 2a
  
  mtc1 $t1, $f4     
  cvt.s.w $f4,$f4   
  mtc1 $t0, $f5     
  cvt.s.w $f5,$f5 
  
  # compute root1
  add.s $f1, $f0, $f4
  div.s $f2, $f1, $f5   #f2 = root1
  
  #root 2
  sub.s $f1, $f4, $f0
  div.s $f3, $f1, $f5   #f3 = root3
  
  # print results
  li $v0, 4	# system call for print string
  la $a0, result    # load address of meassage
  syscall
  
  li $v0, 2             # Print floating-point number
  mov.s $f12, $f2 
  # Without moving the value to $f12, the syscall wouldn't know which value to print
  syscall
  
  li $v0, 4  # print new line
  la $a0, newline  # or we can use this: li $a0, 10 =>Load the ASCII code for newline into $a0
  syscall
  
  li $v0, 2
  mov.s $f12, $f3
  syscall
  
  li $v0, 10      # system call to exit
  syscall 
