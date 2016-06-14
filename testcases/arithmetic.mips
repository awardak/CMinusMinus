# Prolog:
.text
main:
move $fp $sp
la $a0 ProgStart
li $v0 4
syscall
# End of Prolog

la $a0, str_0
li $v0, 4
syscall
li $a0, '\n'
li $v0, 11
syscall
li $v0, 5
syscall
sw $v0, 0($sp)
li $v0, 5
syscall
sw $v0, -4($sp)
li $v0, 5
syscall
sw $v0, -8($sp)
li $v0, 5
syscall
sw $v0, -12($sp)
lw $t1, 0($sp)
lw $t2, -4($sp)
add $t0, $t1, $t2
sw $t0, -20($sp)
lw $t1, -20($sp)
lw $t2, -8($sp)
add $t0, $t1, $t2
sw $t0, -24($sp)
lw $t1, -24($sp)
lw $t2, -12($sp)
add $t0, $t1, $t2
sw $t0, -28($sp)
lw $t1, -28($sp)
sw $t1, -16($sp)
la $a0, str_4
li $v0, 4
syscall
lw $a0, -16($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
lw $t1, 0($sp)
lw $t2, -4($sp)
sub $t0, $t1, $t2
sw $t0, -36($sp)
lw $t1, -36($sp)
sw $t1, -32($sp)
la $a0, str_6
li $v0, 4
syscall
lw $a0, -32($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
lw $t1, 0($sp)
lw $t2, -4($sp)
mult $t1, $t2
mflo $t0
sw $t0, -44($sp)
lw $t1, -44($sp)
lw $t2, -8($sp)
mult $t1, $t2
mflo $t0
sw $t0, -48($sp)
lw $t1, -48($sp)
lw $t2, -12($sp)
mult $t1, $t2
mflo $t0
sw $t0, -52($sp)
lw $t1, -52($sp)
sw $t1, -40($sp)
la $a0, str_10
li $v0, 4
syscall
lw $a0, -40($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
lw $t1, 0($sp)
lw $t2, -12($sp)
div $t1, $t2
mflo $t0
sw $t0, -60($sp)
lw $t1, -60($sp)
sw $t1, -56($sp)
la $a0, str_12
li $v0, 4
syscall
lw $a0, -56($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
li $t0, 121
sw $t0, -80($sp)
lw $t1, -80($sp)
sw $t1, -76($sp)
label0:
li $t0, 121
sw $t0, -84($sp)
lw $t1, -76($sp)
lw $t2, -84($sp)
seq $t0, $t1, $t2
sw $t0, -88($sp)
lw $t0, -88($sp)
beqz $t0, label1
li $a0, '\n'
li $v0, 11
syscall
la $a0, str_14
li $v0, 4
syscall
li $v0, 5
syscall
sw $v0, -64($sp)
li $v0, 12
syscall
sw $v0, -72($sp)
li $v0, 5
syscall
sw $v0, -68($sp)
li $t0, 43
sw $t0, -92($sp)
lw $t1, -72($sp)
lw $t2, -92($sp)
seq $t0, $t1, $t2
sw $t0, -96($sp)
lw $t0, -96($sp)
beqz $t0, label2
lw $t1, -64($sp)
lw $t2, -68($sp)
add $t0, $t1, $t2
sw $t0, -100($sp)
lw $t1, -100($sp)
sw $t1, -64($sp)
la $a0, str_17
li $v0, 4
syscall
lw $a0, -64($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
li $a0, '\n'
li $v0, 11
syscall
b label3
label2:
li $t0, 45
sw $t0, -104($sp)
lw $t1, -72($sp)
lw $t2, -104($sp)
seq $t0, $t1, $t2
sw $t0, -108($sp)
lw $t0, -108($sp)
beqz $t0, label4
lw $t1, -64($sp)
lw $t2, -68($sp)
sub $t0, $t1, $t2
sw $t0, -112($sp)
lw $t1, -112($sp)
sw $t1, -64($sp)
la $a0, str_20
li $v0, 4
syscall
lw $a0, -64($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
li $a0, '\n'
li $v0, 11
syscall
b label5
label4:
li $t0, 42
sw $t0, -116($sp)
lw $t1, -72($sp)
lw $t2, -116($sp)
seq $t0, $t1, $t2
sw $t0, -120($sp)
lw $t0, -120($sp)
beqz $t0, label6
lw $t1, -64($sp)
lw $t2, -68($sp)
mult $t1, $t2
mflo $t0
sw $t0, -124($sp)
lw $t1, -124($sp)
sw $t1, -64($sp)
la $a0, str_23
li $v0, 4
syscall
lw $a0, -64($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
li $a0, '\n'
li $v0, 11
syscall
b label7
label6:
li $t0, 47
sw $t0, -128($sp)
lw $t1, -72($sp)
lw $t2, -128($sp)
seq $t0, $t1, $t2
sw $t0, -132($sp)
lw $t0, -132($sp)
beqz $t0, label8
lw $t1, -64($sp)
lw $t2, -68($sp)
div $t1, $t2
mflo $t0
sw $t0, -136($sp)
lw $t1, -136($sp)
sw $t1, -64($sp)
la $a0, str_26
li $v0, 4
syscall
lw $a0, -64($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
li $a0, '\n'
li $v0, 11
syscall
b label9
label8:
la $a0, str_27
li $v0, 4
syscall
li $a0, '\n'
li $v0, 11
syscall
li $a0, '\n'
li $v0, 11
syscall
label9:
label7:
label5:
label3:
la $a0, str_28
li $v0, 4
syscall
li $v0, 12
syscall
sw $v0, -76($sp)
li $a0, '\n'
li $v0, 11
syscall
b label0
label1:

# Postlog:
la $a0 ProgEnd
li $v0 4
syscall
li $v0 10
syscall
.data
ProgStart: 	 .asciiz "Program Start\n"
ProgEnd:   	 .asciiz "Program End\n"
str_0: 		 .asciiz "Please enter 4 values: "
str_4: 		 .asciiz "Sum of all: "
str_6: 		 .asciiz "Diff of first - second: "
str_10: 		 .asciiz "Product of all: "
str_12: 		 .asciiz "quotient (first/last): "
str_14: 		 .asciiz "Enter a simple expression: "
str_17: 		 .asciiz "Result: "
str_20: 		 .asciiz "Result: "
str_23: 		 .asciiz "Result: "
str_26: 		 .asciiz "Result: "
str_27: 		 .asciiz "That operation is not recognized."
str_28: 		 .asciiz "continue (y/n) ? "
