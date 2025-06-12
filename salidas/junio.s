.data
_a:
	 .word 0
_b:
	 .word 0
_e56:
	 .word 0
_y:
	 .word 0
_c:
	 .word 0
_z:
	 .word 0
$str0:
	 .asciiz "Comienza \t  simulación \\ junio 2025\n"
$str1:
	 .asciiz "Esto no va bien con a*1000="
$str2:
	 .asciiz "\n"
$str3:
	 .asciiz "Esto no va bien con b-1=\n"
$str4:
	 .asciiz "Introduce valores de 'y' y 'z' 3 veces\n"
$str5:
	 .asciiz "e56="
$str6:
	 .asciiz ", y="
$str7:
	 .asciiz ", z="
$str8:
	 .asciiz "\n"
$str9:
	 .asciiz "Termina correctamente con e56="
$str10:
	 .asciiz "\n"
$str11:
	 .asciiz "-----------------------"
$str12:
	 .asciiz "\n"
$str13:
	 .asciiz "Expresion triple a 1: ------------"
$str14:
	 .asciiz "-----------\n"
.text
.globl main
main:
	li $t0,0
	sw $t0,_a
	li $t0,1
	sw $t0,_b
	li $t0,10
	sw $t0,_c
	lw $t0,_a
	lw $t1,_b
	add $t0,$t0,$t1
	li $t1,20
	mul $t0,$t0,$t1
	lw $t1,_b
	li $t2,19
	add $t1,$t1,$t2
	li $t2,2
	div $t1,$t1,$t2
	sub $t0,$t0,$t1
	li $t1,2
	div $t0,$t0,$t1
	sw $t0,_e56
	li $v0,4
	la $a0,$str0
	syscall
	lw $t0,_a
	li $t1,1000
	mul $t0,$t0,$t1
	beqz $t0,$l0
	li $v0,4
	la $a0,$str1
	syscall
	lw $t1,_a
	li $t2,1000
	mul $t1,$t1,$t2
	li $v0,1
	move $a0,$t1
	syscall
	li $v0,4
	la $a0,$str2
	syscall
$l0
	lw $t0,_b
	li $t1,1
	sub $t0,$t0,$t1
	bnez $t0,$l3
$l1
	lw $t1,_e56
	li $t2,2
	sub $t1,$t1,$t2
	beqz $t1,$l2
	lw $t2,_e56
	li $t3,1
	sub $t2,$t2,$t3
	sw $t2,_e56
	li $v0,4
	la $a0,$str4
	syscall
	li $v0,5
	syscall
	sw $v0,_y
	li $v0,5
	syscall
	sw $v0,_z
	li $v0,4
	la $a0,$str5
	syscall
	lw $t0,_e56
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,$str6
	syscall
	lw $t0,_y
	li $t1,0
	add $t0,$t0,$t1
	li $t1,1
	div $t0,$t0,$t1
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,$str7
	syscall
	lw $t0,_z
	li $t1,0
	sub $t0,$t0,$t1
	li $t1,1
	mul $t0,$t0,$t1
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,$str8
	syscall
	b $l1
$l2
	b $l4
$l3
	li $v0,4
	la $a0,$str3
	syscall
	lw $t1,_b
	li $t2,1
	sub $t1,$t1,$t2
	li $v0,1
	move $a0,$t1
	syscall
$l4
	li $v0,4
	la $a0,$str9
	syscall
	lw $t0,_e56
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,$str10
	syscall
	li $v0,4
	la $a0,$str11
	syscall
	li $v0,4
	la $a0,$str12
	syscall
	li $v0,4
	la $a0,$str13
	syscall
	lw $t0,_e56
	bnez $t0,$l5
	li $t2,0
	move $t3,$t2
	b $l6
$l5
	li $t1,1
	move $t3,$t1
$l6
	li $v0,1
	move $a0,$t3
	syscall
	li $v0,4
	la $a0,$str14
	syscall
#	Fin
	li $v0, 10
	syscall
