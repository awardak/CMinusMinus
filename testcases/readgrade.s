# Prolog:
.text
main:
move $fp $sp
la $a0 ProgStart
li $v0 4
syscall
# End of Prolog

li $t0, 999
sw $t0, -4($sp)
lw $t1, -4($sp)
sw $t1, 0($sp)
label0:
li $t0, 0
sw $t0, -8($sp)
lw $t1, 0($sp)
lw $t2, -8($sp)
slt $t0, $t1, $t2
sw $t0, -12($sp)
li $t0, 100
sw $t0, -16($sp)
lw $t1, 0($sp)
lw $t2, -16($sp)
sgt $t0, $t1, $t2
sw $t0, -20($sp)
lw $t1, -12($sp)
lw $t2, -20($sp)
or $t0, $t1, $t2
sw $t0, -24($sp)
lw $t0, -24($sp)
beqz $t0, label1
la $a0, str_3
li $v0, 4
syscall
li $v0, 5
syscall
sw $v0, 0($sp)
b label0
label1:
la $a0, str_4
li $v0, 4
syscall
li $t0, 89
sw $t0, -28($sp)
lw $t1, 0($sp)
lw $t2, -28($sp)
sgt $t0, $t1, $t2
sw $t0, -32($sp)
lw $t0, -32($sp)
beqz $t0, label2
la $a0, str_6
li $v0, 4
syscall
b label3
label2:
li $t0, 79
sw $t0, -36($sp)
lw $t1, 0($sp)
lw $t2, -36($sp)
sgt $t0, $t1, $t2
sw $t0, -40($sp)
lw $t0, -40($sp)
beqz $t0, label4
la $a0, str_8
li $v0, 4
syscall
b label5
label4:
li $t0, 69
sw $t0, -44($sp)
lw $t1, 0($sp)
lw $t2, -44($sp)
sgt $t0, $t1, $t2
sw $t0, -48($sp)
lw $t0, -48($sp)
beqz $t0, label6
la $a0, str_10
li $v0, 4
syscall
b label7
label6:
li $t0, 59
sw $t0, -52($sp)
lw $t1, 0($sp)
lw $t2, -52($sp)
sgt $t0, $t1, $t2
sw $t0, -56($sp)
lw $t0, -56($sp)
beqz $t0, label8
la $a0, str_12
li $v0, 4
syscall
b label9
label8:
la $a0, str_13
li $v0, 4
syscall
label9:
label7:
label5:
label3:
li $a0, '\n'
li $v0, 11
syscall

# Postlog:
la $a0 ProgEnd
li $v0 4
syscall
li $v0 10
syscall
.data
ProgStart: 	 .asciiz "Program Start\n"
ProgEnd:   	 .asciiz "Program End\n"
str_3: 		 .asciiz "Please enter a number 0-100: "
str_4: 		 .asciiz "If this was a grade, you would receive: "
str_6: 		 .asciiz "A"
str_8: 		 .asciiz "B"
str_10: 		 .asciiz "C"
str_12: 		 .asciiz "D"
str_13: 		 .asciiz "F"
