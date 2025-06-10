.data
_a:
	 .word 0
_b:
	 .word 0
$str0:
	 .asciiz "b"
$str1:
	 .asciiz "\n"
$str2:
	 .asciiz "a\n"
$str3:
	 .asciiz "Final"
$str4:
	 .asciiz "\n"
.text
.globl main
main:
	li $t0,2
	sw $t0,_a
	li $t0,0
	sw $t0,_b
	lw $t0,_b
	bnez $t0,$l1
	lw $t1,_a
	beqz $t1,$l0
	li $v0,4
	la $a0,$str2
	syscall
$l0
	b $l2
$l1
	li $v0,4
	la $a0,$str0
	syscall
	li $v0,4
	la $a0,$str1
	syscall
$l2
	lw $t0,_a
	beqz $t0,$l3
	li $v0,4
	la $a0,$str3
	syscall
	li $v0,4
	la $a0,$str4
	syscall
$l3
##############
# Fin
	li $v0, 10
	syscall
