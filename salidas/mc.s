.data
_a:
	 .word 0
_b:
	 .word 0
_c:
	 .word 0
$str0:
	 .asciiz "Inicio del programa\n"
$str1:
	 .asciiz "a"
$str2:
	 .asciiz "\n"
$str3:
	 .asciiz "No a y b\n"
$str4:
	 .asciiz "c = "
$str5:
	 .asciiz "\n"
$str6:
	 .asciiz "Final"
$str7:
	 .asciiz "\n"
.text
.globl main
main:
	li $t0,0
	sw $t0,_a
	li $t0,0
	sw $t0,_b
	li $v0,4
	la $a0,$str0
	syscall
	li $t0,5
	li $t1,2
	add $t0,$t0,$t1
	li $t1,2
	sub $t0,$t0,$t1
	sw $t0,_c
	lw $t0,_a
	bnez $t0,$l4
	lw $t1,_b
	bnez $t1,$l2
$l0
	lw $t2,_c
	beqz $t2,$l1
	li $v0,4
	la $a0,$str4
	syscall
	lw $t3,_c
	li $v0,1
	move $a0,$t3
	syscall
	li $v0,4
	la $a0,$str5
	syscall
	lw $t3,_c
	li $t4,2
	sub $t3,$t3,$t4
	li $t4,1
	add $t3,$t3,$t4
	sw $t3,_c
	b $l0
$l1
	b $l3
$l2
	li $v0,4
	la $a0,$str3
	syscall
$l3
	b $l5
$l4
	li $v0,4
	la $a0,$str1
	syscall
	li $v0,4
	la $a0,$str2
	syscall
$l5
	li $v0,4
	la $a0,$str6
	syscall
	li $v0,4
	la $a0,$str7
	syscall
#	Fin
	li $v0, 10
	syscall
