.data
_a:
	 .word 0
_b:
	 .word 0
$str0:
	 .asciiz "El valor de a es: "
$str1:
	 .asciiz "\n"
$str2:
	 .asciiz "El valor de b es: "
$str3:
	 .asciiz "\n"
.text
.globl main
main:
	li $t0,1
	sw $t0,_a
	li $t0,2
	sw $t0,_b
	lw $t0,_a
	lw $t1,_b
	add $t0,$t0,$t1
	sw $t0,_a
	li $v0,4
	la $a0,$str0
	syscall
	lw $t0,_a
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,$str1
	syscall
	lw $t0,_b
	li $t1,2
	mul $t0,$t0,$t1
	sw $t0,_b
	li $v0,4
	la $a0,$str2
	syscall
	lw $t0,_b
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,$str3
	syscall
#	Fin
	li $v0, 10
	syscall
