.data
_x:
	 .word 0
_y:
	 .word 0
_z:
	 .word 0
.text
.globl main
main:
	li $t0,2
	sw $t0,_x
	li $t0,3
	sw $t0,_y
	lw $t0,_x
	lw $t1,_y
	add $t2,$t0,$t1
	li $t1,4
	mul $t3,$t2,$t1
	sw $t3,_z
	lw $t0,_z
	li $v0,1
	move $a0,$t0
	syscall
##############
# Fin
	li $v0, 10
	syscall
