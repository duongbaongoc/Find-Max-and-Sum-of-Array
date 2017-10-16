#Answer for question 4: What is the address that has been used by the
#simulator for this array?  268500992


.data
    array:  .word   11, 12, -10, 13, 9, 12, 14, 15, -20, 0
    max_msg:    .asciiz "The maximum is "
    sum_msg:    .asciiz "\nThe summation is "

.text
main:
    jal find_max

    #display the max
    li $v0, 4
    la $a0, max_msg
    syscall

    #display the max
    li $v0, 1
    move $a0, $s1       #max is stored in s1
    syscall     

    jal find_sum

    #display the sum
    li $v0, 4
    la $a0, sum_msg
    syscall

    #display the sum
    li $v0, 1
    move $a0, $s1       #sum is stored in s1
    syscall  

    #terminate main function, end the program
    li $v0, 10 
    syscall



find_max: #s1 is the final max
        li $s3, 36              #to control loop
        li $s0, -4              #init offset of an element
        la $a0, array
        lw $s1, ($a0)           #s1 = array[0]

  loop: addi $s0, $s0, 4        #get the correct offset of an element
        la $a0, array
        add $a0, $a0, $s0
        lw $s2, ($a0)           #s2 = an element in array

        slt $t1, $s2, $s1       #t1 = 0 if element >= current max
        beq $t1, $zero, update
        j no_update             #if element is not greater than current max
update: add $s1, $s2, $zero     #update max
no_update:bne $s0, $s3, loop    #if index is not 9 yet then loop
        
        jr $ra



find_sum: #s1 is the final sum
        li $s3, 36              #to control loop
        li $s0, -4              #init offset of an element
        li $s1, 0               #s1 = sum

  loop1: addi $s0, $s0, 4       #get the correct offset of an element
        la $a0, array
        add $a0, $a0, $s0
        lw $s2, ($a0)           #s2 = an element in array
        
        add $s1, $s1, $s2       #accumulate the sum
        
        bne $s0, $s3, loop1     #if index is not 9 yet then loop
        
        jr $ra

