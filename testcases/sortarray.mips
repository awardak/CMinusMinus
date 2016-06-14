# Prolog:
.text
main:
move $fp $sp
la $a0 ProgStart
li $v0 4
syscall
# End of Prolog

li $t0, 20
sw $t0, -96($sp)
lw $t1, -96($sp)
sw $t1, -80($sp)
li $t0, 9
sw $t0, -100($sp)
lw $t1, -100($sp)
sw $t1, -84($sp)
li $t0, 32
sw $t0, -104($sp)
lw $t1, -104($sp)
sw $t1, -88($sp)
li $t0, 0
sw $t0, -108($sp)
lw $t1, -108($sp)
sw $t1, -92($sp)
la $a0, str_0
li $v0, 4
syscall
li $a0, '\n'
li $v0, 11
syscall
label0:
lw $t1, -92($sp)
lw $t2, -80($sp)
slt $t0, $t1, $t2
sw $t0, -112($sp)
lw $t0, -112($sp)
beqz $t0, label1
lw $a0, -92($sp)
li $v0, 1
syscall
la $a0, str_2
li $v0, 4
syscall
lw $a0, -84($sp)
li $v0, 11
syscall
lw $t0, -92($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -116($sp)
move $t0, $sp
lw $t1, -116($sp)
add $t3, $t0, $t1
li $v0, 5
syscall
sw $v0, ($t3)
li $t0, 1
sw $t0, -120($sp)
lw $t1, -92($sp)
lw $t2, -120($sp)
add $t0, $t1, $t2
sw $t0, -124($sp)
lw $t1, -124($sp)
sw $t1, -92($sp)
b label0
label1:
li $t0, 0
sw $t0, -140($sp)
lw $t1, -140($sp)
sw $t1, -92($sp)
label2:
lw $t1, -92($sp)
lw $t2, -80($sp)
slt $t0, $t1, $t2
sw $t0, -144($sp)
lw $t0, -144($sp)
beqz $t0, label3
lw $t1, -92($sp)
sw $t1, -128($sp)
li $t0, 1
sw $t0, -148($sp)
lw $t1, -92($sp)
lw $t2, -148($sp)
add $t0, $t1, $t2
sw $t0, -152($sp)
lw $t1, -152($sp)
sw $t1, -136($sp)
label4:
lw $t1, -136($sp)
lw $t2, -80($sp)
slt $t0, $t1, $t2
sw $t0, -156($sp)
lw $t0, -156($sp)
beqz $t0, label5
lw $t0, -136($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -160($sp)
lw $t0, -128($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -164($sp)
move $t0, $sp
lw $t1, -160($sp)
add $t4, $t0, $t1
move $t0, $sp
lw $t1, -164($sp)
add $t5, $t0, $t1
lw $t1, ($t4)
lw $t2, ($t5)
slt $t0, $t1, $t2
sw $t0, -168($sp)
lw $t0, -168($sp)
beqz $t0, label6
lw $t1, -136($sp)
sw $t1, -128($sp)
b label7
label6:
label7:
li $t0, 1
sw $t0, -172($sp)
lw $t1, -136($sp)
lw $t2, -172($sp)
add $t0, $t1, $t2
sw $t0, -176($sp)
lw $t1, -176($sp)
sw $t1, -136($sp)
b label4
label5:
lw $t0, -92($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -180($sp)
move $t0, $sp
lw $t1, -180($sp)
add $t6, $t0, $t1
lw $t1, ($t6)
sw $t1, -132($sp)
lw $t0, -92($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -184($sp)
lw $t0, -128($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -188($sp)
move $t0, $sp
lw $t1, -184($sp)
add $t7, $t0, $t1
move $t0, $sp
lw $t1, -188($sp)
add $t8, $t0, $t1
lw $t1, ($t8)
sw $t1, ($t7)
lw $t0, -128($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -192($sp)
move $t0, $sp
lw $t1, -192($sp)
add $t9, $t0, $t1
lw $t1, -132($sp)
sw $t1, ($t9)
li $t0, 1
sw $t0, -196($sp)
lw $t1, -92($sp)
lw $t2, -196($sp)
add $t0, $t1, $t2
sw $t0, -200($sp)
lw $t1, -200($sp)
sw $t1, -92($sp)
b label2
label3:
la $a0, str_17
li $v0, 4
syscall
li $t0, 0
sw $t0, -204($sp)
lw $t1, -204($sp)
sw $t1, -92($sp)
label8:
lw $t1, -92($sp)
lw $t2, -80($sp)
slt $t0, $t1, $t2
sw $t0, -208($sp)
lw $t0, -208($sp)
beqz $t0, label9
lw $t0, -92($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -212($sp)
move $t0, $sp
lw $t1, -212($sp)
add $t3, $t0, $t1
lw $a0, ($t3)
li $v0, 1
syscall
lw $a0, -88($sp)
li $v0, 11
syscall
li $t0, 1
sw $t0, -216($sp)
lw $t1, -92($sp)
lw $t2, -216($sp)
add $t0, $t1, $t2
sw $t0, -220($sp)
lw $t1, -220($sp)
sw $t1, -92($sp)
b label8
label9:
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
str_0: 		 .asciiz "Enter 10 numbers to sort:"
str_2: 		 .asciiz ":"
str_17: 		 .asciiz "Sorted: "
