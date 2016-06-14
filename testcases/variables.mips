# Prolog:
.text
main:
move $fp $sp
la $a0 ProgStart
li $v0 4
syscall
# End of Prolog

li $t0, 1
sw $t0, -8($sp)
lw $t1, -8($sp)
sw $t1, 0($sp)
li $t0, 2
sw $t0, -12($sp)
lw $t1, -12($sp)
sw $t1, -4($sp)
lw $a0, 0($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
lw $a0, -4($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
li $t0, 111
sw $t0, -24($sp)
lw $t1, -24($sp)
sw $t1, -20($sp)
lw $a0, -20($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
li $t0, 3
sw $t0, -32($sp)
lw $t1, -32($sp)
sw $t1, -28($sp)
li $t0, 5
sw $t0, -36($sp)
lw $t1, -36($sp)
sw $t1, -16($sp)
lw $a0, 0($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
lw $a0, -16($sp)
li $v0, 1
syscall
li $a0, '\n'
li $v0, 11
syscall
li $t0, 6
sw $t0, -44($sp)
lw $t1, -44($sp)
sw $t1, -40($sp)
lw $a0, -40($sp)
li $v0, 1
syscall
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
