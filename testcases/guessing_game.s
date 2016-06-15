# Prolog:
.text
main:
move $fp $sp
la $a0 ProgStart
li $v0 4
syscall
# End of Prolog

li $t0, 23
sw $t0, -80($sp)
lw $t1, -80($sp)
sw $t1, 0($sp)
li $t0, 35
sw $t0, -84($sp)
lw $t1, -84($sp)
sw $t1, -4($sp)
li $t0, 12
sw $t0, -88($sp)
lw $t1, -88($sp)
sw $t1, -8($sp)
li $t0, 15
sw $t0, -92($sp)
lw $t1, -92($sp)
sw $t1, -12($sp)
li $t0, 19
sw $t0, -96($sp)
lw $t1, -96($sp)
sw $t1, -16($sp)
li $t0, 11
sw $t0, -100($sp)
lw $t1, -100($sp)
sw $t1, -20($sp)
li $t0, 5
sw $t0, -104($sp)
lw $t1, -104($sp)
sw $t1, -24($sp)
li $t0, 9
sw $t0, -108($sp)
lw $t1, -108($sp)
sw $t1, -28($sp)
li $t0, 22
sw $t0, -112($sp)
lw $t1, -112($sp)
sw $t1, -32($sp)
li $t0, 4
sw $t0, -116($sp)
lw $t1, -116($sp)
sw $t1, -36($sp)
li $t0, 14
sw $t0, -120($sp)
lw $t1, -120($sp)
sw $t1, -40($sp)
li $t0, 16
sw $t0, -124($sp)
lw $t1, -124($sp)
sw $t1, -44($sp)
li $t0, 21
sw $t0, -128($sp)
lw $t1, -128($sp)
sw $t1, -48($sp)
li $t0, 13
sw $t0, -132($sp)
lw $t1, -132($sp)
sw $t1, -52($sp)
li $t0, 10
sw $t0, -136($sp)
lw $t1, -136($sp)
sw $t1, -56($sp)
li $t0, 8
sw $t0, -140($sp)
lw $t1, -140($sp)
sw $t1, -60($sp)
li $t0, 19
sw $t0, -144($sp)
lw $t1, -144($sp)
sw $t1, -64($sp)
li $t0, 20
sw $t0, -148($sp)
lw $t1, -148($sp)
sw $t1, -68($sp)
li $t0, 3
sw $t0, -152($sp)
lw $t1, -152($sp)
sw $t1, -72($sp)
li $t0, 28
sw $t0, -156($sp)
lw $t1, -156($sp)
sw $t1, -76($sp)
li $t0, 0
sw $t0, -184($sp)
lw $t1, -184($sp)
sw $t1, -180($sp)
li $t0, 20
sw $t0, -188($sp)
lw $t1, -188($sp)
sw $t1, -160($sp)
li $t0, 121
sw $t0, -192($sp)
lw $t1, -192($sp)
sw $t1, -176($sp)
label0:
li $t0, 121
sw $t0, -196($sp)
lw $t1, -176($sp)
lw $t2, -196($sp)
seq $t0, $t1, $t2
sw $t0, -200($sp)
lw $t0, -200($sp)
beqz $t0, label1
li $t0, 1
sw $t0, -204($sp)
lw $t1, -204($sp)
sw $t1, -164($sp)
li $t0, 0
sw $t0, -208($sp)
lw $t1, -208($sp)
sw $t1, -168($sp)
li $t0, 0
sw $t0, -212($sp)
lw $t1, -212($sp)
sw $t1, -172($sp)
label2:
li $t0, 4
sw $t0, -216($sp)
lw $t1, -164($sp)
lw $t2, -216($sp)
slt $t0, $t1, $t2
sw $t0, -220($sp)
lw $t0, -180($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -224($sp)
move $t0, $sp
lw $t1, -224($sp)
add $t3, $t0, $t1
lw $t1, -168($sp)
lw $t2, ($t3)
slt $t0, $t1, $t2
sw $t0, -228($sp)
lw $t0, -180($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -232($sp)
move $t0, $sp
lw $t1, -232($sp)
add $t4, $t0, $t1
lw $t1, -168($sp)
lw $t2, ($t4)
sgt $t0, $t1, $t2
sw $t0, -236($sp)
lw $t1, -228($sp)
lw $t2, -236($sp)
or $t0, $t1, $t2
sw $t0, -240($sp)
lw $t1, -220($sp)
lw $t2, -240($sp)
sne $t3, $t1, $zero
sne $t4, $t2, $zero
and $t0, $t3, $t4
sw $t0, -244($sp)
lw $t0, -244($sp)
beqz $t0, label3
la $a0, str_8
li $v0, 4
syscall
lw $a0, -164($sp)
li $v0, 1
syscall
la $a0, str_9
li $v0, 4
syscall
li $v0, 5
syscall
sw $v0, -168($sp)
lw $t0, -180($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -248($sp)
move $t0, $sp
lw $t1, -248($sp)
add $t5, $t0, $t1
lw $t1, -168($sp)
lw $t2, ($t5)
seq $t0, $t1, $t2
sw $t0, -252($sp)
lw $t0, -252($sp)
beqz $t0, label4
la $a0, str_12
li $v0, 4
syscall
li $a0, '\n'
li $v0, 11
syscall
li $t0, 1
sw $t0, -256($sp)
lw $t1, -256($sp)
sw $t1, -172($sp)
b label5
label4:
lw $t0, -180($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -260($sp)
move $t0, $sp
lw $t1, -260($sp)
add $t6, $t0, $t1
lw $t1, -168($sp)
lw $t2, ($t6)
slt $t0, $t1, $t2
sw $t0, -264($sp)
lw $t0, -264($sp)
beqz $t0, label6
la $a0, str_15
li $v0, 4
syscall
li $a0, '\n'
li $v0, 11
syscall
b label7
label6:
lw $t0, -180($sp)
add $t0, $t0, $t0
add $t0, $t0, $t0
li $t1, 0
sub $t0, $t1, $t0
sw $t0, -268($sp)
move $t0, $sp
lw $t1, -268($sp)
add $t7, $t0, $t1
lw $t1, -168($sp)
lw $t2, ($t7)
sgt $t0, $t1, $t2
sw $t0, -272($sp)
lw $t0, -272($sp)
beqz $t0, label8
la $a0, str_18
li $v0, 4
syscall
li $a0, '\n'
li $v0, 11
syscall
b label9
label8:
label9:
label7:
label5:
li $t0, 1
sw $t0, -276($sp)
lw $t1, -164($sp)
lw $t2, -276($sp)
add $t0, $t1, $t2
sw $t0, -280($sp)
lw $t1, -280($sp)
sw $t1, -164($sp)
b label2
label3:
li $t0, 0
sw $t0, -284($sp)
lw $t1, -172($sp)
lw $t2, -284($sp)
seq $t0, $t1, $t2
sw $t0, -288($sp)
lw $t0, -288($sp)
beqz $t0, label10
la $a0, str_21
li $v0, 4
syscall
li $a0, '\n'
li $v0, 11
syscall
li $a0, '\n'
li $v0, 11
syscall
b label11
label10:
label11:
la $a0, str_22
li $v0, 4
syscall
li $v0, 12
syscall
sw $v0, -176($sp)
li $a0, '\n'
li $v0, 11
syscall
li $a0, '\n'
li $v0, 11
syscall
li $t0, 1
sw $t0, -292($sp)
lw $t1, -180($sp)
lw $t2, -292($sp)
add $t0, $t1, $t2
sw $t0, -296($sp)
lw $t1, -296($sp)
sw $t1, -180($sp)
lw $t1, -180($sp)
lw $t2, -160($sp)
sgt $t0, $t1, $t2
sw $t0, -300($sp)
lw $t0, -300($sp)
beqz $t0, label12
li $t0, 0
sw $t0, -304($sp)
lw $t1, -304($sp)
sw $t1, -180($sp)
b label13
label12:
label13:
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
str_8: 		 .asciiz "Chance #"
str_9: 		 .asciiz " - guess a number (1-35): "
str_12: 		 .asciiz "  YOU WIN!!!"
str_15: 		 .asciiz "  guess higher"
str_18: 		 .asciiz "  guess lower"
str_21: 		 .asciiz "Sorry, you lost."
str_22: 		 .asciiz "continue (y/n) ? "
