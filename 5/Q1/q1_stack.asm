#402106112 - 402106394
.data
input:      .space 5       # 3 word + \n + null pointer
psh_cmd:    .asciiz "psh"        
pop_cmd:    .asciiz "pop"        
add_cmd:    .asciiz "add"        
sub_cmd:    .asciiz "sub"        
mul_cmd:    .asciiz "mul"        
ext_cmd:    .asciiz "ext"

errMsg: .asciiz "Error: Stack is empty!\n"
errMsg2: .asciiz "Error: Stack has one element!\n"
newline: .asciiz "\n"

.text
.globl main

main:
     li $a0, 40
     li $v0, 9
     syscall 
     move $s0, $v0    # $s0 is top of stack
     li $s1, 0        # $s1 is number of stack pointer
     sw $zero , 0($s0)    # first word of each dynamic memory is address of previous first word of dynamic memory but in the beginig first word is zero
     addi $s1, $s1, 1
     
Loop:
     # get input
     li $v0, 8
     la $a0, input
     li $a1, 5
     syscall
     
     # delete \n
     la $t0, input
     sb $zero, 3($t0)
     
     # check push command
     la $a0, input                
     la $a1, psh_cmd              
     jal check_command            
     beq $v0, 1, Push
     
     #check pop command
     la $a0, input                
     la $a1, pop_cmd              
     jal check_command            
     beq $v0, 1, Pop
     
     #check add command
     la $a0, input                
     la $a1, add_cmd              
     jal check_command            
     beq $v0, 1, Add
     
     #check sub command
     la $a0, input                
     la $a1, sub_cmd              
     jal check_command            
     beq $v0, 1, Sub
     
     #check mul command
     la $a0, input                
     la $a1, mul_cmd              
     jal check_command            
     beq $v0, 1, Mul
     
     #check exit command
     la $a0, input                
     la $a1, ext_cmd              
     jal check_command            
     beq $v0, 1, Exit
     
     # if command is wrong jump to loop
     j Loop
     

Push:
     # get input of push
     li $v0, 5
     syscall
     move $t0, $v0
     
     beq $s1, 10, extend_stack  # if we dont have memory , we should extend stack whith allocate new dynamic memory
Pushing:     
     # pushing 
     sw $t0, 4($s0)
     addi $s0, $s0, 4
     addi $s1, $s1, 1
     
     j Loop



extend_stack:
     #allocate new momory for stack
     li $a0, 40
     li $v0, 9
     syscall
      
     # store address of first word of previous dynamic memory in firs word of new dynamic memory
     subi $t1, $s0, 36    #$t1 = address of first word of previous dynamic memory
     sw $t1, 0($v0)
     
     move $s0, $v0
     li $s1, 1
     #000000000000000000
     move $a0, $v0
     li $v0, 1
     syscall
     #000000000000000000
     
     j Pushing
   
     
       
           

Pop:
     beq $s1, 1, check_stack_situation
     lw $a0, 0($s0)

Popping:
     subi $s0, $s0, 4
     subi $s1, $s1, 1
     # print popped element -> print $a0
     li $v0, 1
     syscall

     la $a0, newline
     li $v0, 4
     syscall
     
     j Loop


check_stack_situation:
     lw $t0, 0($s0)
     beqz $t0, empty_stack
     j pop_from_previous_memory


empty_stack:
     la $a0, errMsg
     li $v0, 4
     syscall
     j Loop
     
error_of_one_element:
     la $a0, errMsg2
     li $v0, 4
     syscall
     j Loop

pop_from_previous_memory:
     lw $s0, 0($s0)
     addi $s0, $s0, 36
     li $s1, 10
     lw $a0, 0($s0)
     j Popping
 
 
 
 
 
Add :
     beq $s1, 1, check_stack_situation_for_add1
     beq $s1, 2, check_stack_situation_for_add2
     lw $a0, -4($s0)
     lw $a1, 0($s0)
 

Adding:
     add $t0, $a0, $a1
     sw $t0, -4($s0)
     subi $s0, $s0, 4
     subi $s1, $s1, 1
     
     j Loop
    
Adding_from_two_memory:
     lw $t1, 0($s0)  # $t1 = second element of adding
     # find second element from previous memory
     lw $t2, -4($s0)  # $t2 = first word of previous memory
     lw $t0, 36($t2) # $t0 = first element of adding
     add $t3, $t0, $t1
     sw $t3, 36($t2)
     
     addi $s0, $t2 , 36
     li $s1, 10
     
     j Loop
  
check_stack_situation_for_add1:
     lw $t0, 0($s0)
     beqz $t0, empty_stack
     # go to previous memory
     lw $s0, 0($s0)
     addi $s0, $s0, 36
     li $s1, 10
     # define input of Adding function
     lw $a0, -4($s0)
     lw $a1, 0($s0)
     
     j Adding


check_stack_situation_for_add2:
     lw $t0, -4($s0)
     beqz $t0, error_of_one_element
     
     j Adding_from_two_memory




   
Sub:
     beq $s1, 1, check_stack_situation_for_sub1
     beq $s1, 2, check_stack_situation_for_sub2
     lw $a0, -4($s0)
     lw $a1, 0($s0)
 

subing:
     sub $t0, $a0, $a1
     sw $t0, -4($s0)
     subi $s0, $s0, 4
     subi $s1, $s1, 1
     
     j Loop
    
subing_from_two_memory:
     lw $t1, 0($s0)  # $t1 = second element of subing
     # find second element from previous memory
     lw $t2, -4($s0)  # $t2 = first word of previous memory
     lw $t0, 36($t2) # $t0 = first element of subing
     sub $t3, $t0, $t1
     sw $t3, 36($t2)
     
     addi $s0, $t2 , 36
     li $s1, 10
     
     j Loop
  
check_stack_situation_for_sub1:
     lw $t0, 0($s0)
     beqz $t0, empty_stack
     # go to previous memory
     lw $s0, 0($s0)
     addi $s0, $s0, 36
     li $s1, 10
     # define input of subing function
     lw $a0, -4($s0)
     lw $a1, 0($s0)
     
     j subing


check_stack_situation_for_sub2:
     lw $t0, -4($s0)
     beqz $t0, error_of_one_element
     
     j subing_from_two_memory

 
  
   
    
Mul: 
     beq $s1, 1, check_stack_situation_for_mul1
     beq $s1, 2, check_stack_situation_for_mul2
     lw $a0, -4($s0)
     lw $a1, 0($s0)
 

Muling:
     mul $t0, $a0, $a1
     sw $t0, -4($s0)
     subi $s0, $s0, 4
     subi $s1, $s1, 1
     
     j Loop
    
Muling_from_two_memory:
     lw $t1, 0($s0)  # $t1 = second element of muling
     # find second element from previous memory
     lw $t2, -4($s0)  # $t2 = first word of previous memory
     lw $t0, 36($t2) # $t0 = first element of muling
     mul $t3, $t0, $t1
     sw $t3, 36($t2)
     
     addi $s0, $t2 , 36
     li $s1, 10
     
     j Loop
  
check_stack_situation_for_mul1:
     lw $t0, 0($s0)
     beqz $t0, empty_stack
     # go to previous memory
     lw $s0, 0($s0)
     addi $s0, $s0, 36
     li $s1, 10
     # define input of Muling function
     lw $a0, -4($s0)
     lw $a1, 0($s0)
     
     j Muling


check_stack_situation_for_mul2:
     lw $t0, -4($s0)
     beqz $t0, error_of_one_element
     
     j Muling_from_two_memory 
 
 
 
Exit:
      li $v0, 10
      syscall
 
 
 
check_command:
    li $t2, 3
compare_loop:
    lb $t3, 0($a0)
    lb $t4, 0($a1)
    bne $t3, $t4, not_equal
    addi $a0, $a0, 1
    addi $a1, $a1, 1
    subi $t2, $t2, 1
    bnez $t2, compare_loop
    li $v0, 1                    
    jr $ra
not_equal:
    li $v0, 0                    
    jr $ra
    
    
    
