#402106112 - 402106394
.data
line: .asciiz "\n"
array: .word -20, 106, 91, -3, 91, 106, -20
length: .word 7
one: .word 1
.text
.globl main
main:
  la $t0, array
  lw $t1, 0($t0)
  lw $t2, 24($t0)
  lw $t3, 4($t0)
  lw $t4, 20($t0)
  lw $t5, 8($t0)
  lw $t6, 16($t0)
  xor $t7, $t1, $t2 
  xor $t8, $t3, $t4
  xor $t9, $t5, $t6
  or $s0, $t7, $t8
  or $s0, $s0, $t9
  not $s0, $s0

  move $t0, $s0
  srl $t1, $s0, 1
  srl $t2, $s0, 2
  srl $t3, $s0, 3
  srl $t4, $s0, 4
  srl $t5, $s0, 5
  srl $t6, $s0, 6
  srl $t7, $s0, 7
  and $t0, $t1, $t0
  and $t2, $t3, $t2
  and $t4, $t5, $t4
  and $t6, $t7, $t6
  and $t0, $t2, $t0
  and $t4, $t6, $t4
  and $t0, $t4, $t0

  move $s1, $t0

  srl $t0, $s0, 8
  srl $t1, $s0, 9
  srl $t2, $s0, 10
  srl $t3, $s0, 11
  srl $t4, $s0, 12
  srl $t5, $s0, 13
  srl $t6, $s0, 14
  srl $t7, $s0, 15
  and $t0, $t1, $t0
  and $t2, $t3, $t2
  and $t4, $t5, $t4
  and $t6, $t7, $t6
  and $t0, $t2, $t0
  and $t4, $t6, $t4
  and $t0, $t4, $t0

  move $s2, $t0

  srl $t0, $s0, 16
  srl $t1, $s0, 17
  srl $t2, $s0, 18
  srl $t3, $s0, 19
  srl $t4, $s0, 20
  srl $t5, $s0, 21
  srl $t6, $s0, 22
  srl $t7, $s0, 23
  and $t0, $t1, $t0
  and $t2, $t3, $t2
  and $t4, $t5, $t4
  and $t6, $t7, $t6
  and $t0, $t2, $t0
  and $t4, $t6, $t4
  and $t0, $t4, $t0

  move $s3, $t0

  srl $t0, $s0, 24
  srl $t1, $s0, 25
  srl $t2, $s0, 26
  srl $t3, $s0, 27
  srl $t4, $s0, 28
  srl $t5, $s0, 29
  srl $t6, $s0, 30
  srl $t7, $s0, 31
  and $t0, $t1, $t0
  and $t2, $t3, $t2
  and $t4, $t5, $t4
  and $t6, $t7, $t6
  and $t0, $t2, $t0
  and $t4, $t6, $t4
  and $t0, $t4, $t0

  move $s4, $t0

  and $t0, $s1, $s2
  and $t1, $s3, $s4
  and $t0, $t0, $t1

  li $v0, 1
  move $a0, $t0
  syscall
