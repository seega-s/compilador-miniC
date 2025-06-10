.data
_a:
	 .word 0
_b:
	 .word 0
.text
.globl main
main:
	li $t0,5
	sw $t0,_a
	li $t0,7
	sw $t0,_b
	lw $t0,_a
	li $v0,1
	move $a0,$t0
	syscall
	lw $t0,_b
	li $v0,1
	move $a0,$t0
	syscall
##############
# Fin
	li $v0, 10
	syscall
