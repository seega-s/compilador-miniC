.data
_a:
	 .word 0
_b:
	 .word 0
_c:
	 .word 0
$str0:
	 .asciiz "Valores: "
$str1:
	 .asciiz " , "
$str2:
	 .asciiz " , "
$str3:
	 .asciiz " Suma: "
$str4:
	 .asciiz " Multiplicacion: "
.text
.globl main
main:
	li $t0,7
	sw $t0,_c
	li $t0,10
	sw $t0,_a
	li $t0,20
	sw $t0,_b
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
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,$str2
	syscall
	lw $t0,_c
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,$str3
	syscall
	lw $t0,_a
	lw $t1,_b
	add $t2,$t0,$t1
	li $v0,1
	move $a0,$t2
	syscall
	li $v0,4
	la $a0,$str4
	syscall
	lw $t1,_a
	lw $t2,_c
	mul $t3,$t1,$t2
	li $v0,1
	move $a0,$t3
	syscall
##############
# Fin
	li $v0, 10
	syscall
