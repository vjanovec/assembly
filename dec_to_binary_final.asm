.data
binary: .space 32  # 32 bytes to store binary values

.text
main:
    li $s0, 167      # Load immediate value 12 into $s0 (numerator)
    li $s2, 2       # Load immediate value 2 into $s2 (divisor)
    li $t0, -1      # Initialize $t0 as the array index

while:

    beq $s0, $zero, print   # Exit loop if $s0 (dividend) becomes zero
	

    # Divide $s0 by $s2 and store the remainder in $s3
    div $s0, $s2
    mfhi $s3               # Remainder is stored in $s3

    addi $t0, $t0, 1       # Increment the array index	
    # Store the remainder in the binary array
    sb $s3, binary($t0)    # Store in the array at the current index

    # Print the remainder (optional)
    #li $v0, 1
    #move $a0, $s3
    #syscall


    # Update $s0 with the quotient for the next iteration
    mflo $s0

    j while

print:
    blt $t0, 0, end
    lb $s3, binary($t0)
    subi $t0, $t0, 1
    li $v0, 1
    move $a0, $s3
    syscall
    j print
    
end:    
    # Exit the program
    li $v0, 10
    syscall
