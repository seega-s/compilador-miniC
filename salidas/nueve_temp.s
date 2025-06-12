.data
_a:
	 .word 0
_b:
	 .word 0
_c:
	 .word 0
_d:
	 .word 0
_e:
	 .word 0
_f:
	 .word 0
_g:
	 .word 0
_h:
	 .word 0
_i:
	 .word 0
_j:
	 .word 0
_k:
	 .word 0
_uno:
	 .word 0
_dos:
	 .word 0
_tres:
	 .word 0
_cuatro:
	 .word 0
_cinco:
	 .word 0
_seis:
	 .word 0
_siete:
	 .word 0
_ocho:
	 .word 0
_nueve:
	 .word 0
_resultado:
	 .word 0
$str0:
	 .asciiz "Resultado = "
$str1:
	 .asciiz "k = "
$str2:
	 .asciiz "a = "
$str3:
	 .asciiz "Resultado final = "
.text
.globl main
main:
	li $t0,1
	sw $t0,_uno
	li $t0,2
	sw $t0,_dos
	li $t0,3
	sw $t0,_tres
	li $t0,4
	sw $t0,_cuatro
	li $t0,5
	sw $t0,_cinco
	li $t0,6
	sw $t0,_seis
	li $t0,7
	sw $t0,_siete
	li $t0,8
	sw $t0,_ocho
	li $t0,9
	sw $t0,_nueve
	lw $t0,_uno
	lw $t1,_dos
	add $t0,$t0,$t1
	lw $t1,_tres
	mul $t0,$t0,$t1
	lw $t1,_cuatro
	sub $t0,$t0,$t1
	lw $t1,_cinco
	div $t0,$t0,$t1
	lw $t1,_seis
	lw $t2,_siete
	mul $t1,$t1,$t2
	lw $t2,_ocho
	add $t1,$t1,$t2
	lw $t2,_nueve
	sub $t1,$t1,$t2
	lw $t2,_uno
	div $t1,$t1,$t2
	add $t0,$t0,$t1
	sw $t0,_resultado
	li $v0,4
	la $a0,$str0
	syscall
	lw $t0,_resultado
	li $v0,1
	move $a0,$t0
	syscall
	lw $t0,_resultado
	bnez $t0,$l0
	lw $t2,_c
	lw $t3,_d
	sub $t2,$t2,$t3
	move $t3,$t2
	b $l1
$l0
	lw $t1,_a
	lw $t2,_b
	add $t1,$t1,$t2
	move $t3,$t1
$l1
	sw $t3,_k
	li $v0,4
	la $a0,$str1
	syscall
	lw $t0,_k
	li $v0,1
	move $a0,$t0
	syscall
	li $t0,0
	sw $t0,_a
$l2
	lw $t0,_a
	beqz $t0,$l3
	lw $t1,_a
	li $t2,1
	add $t1,$t1,$t2
	sw $t1,_a
	b $l2
$l3
	li $v0,4
	la $a0,$str2
	syscall
	lw $t0,_a
	li $v0,1
	move $a0,$t0
	syscall
	lw $t0,_k
	lw $t1,_a
	mul $t0,$t0,$t1
	lw $t1,_b
	lw $t2,_c
	sub $t1,$t1,$t2
	add $t0,$t0,$t1
	sw $t0,_resultado
	li $v0,4
	la $a0,$str3
	syscall
	lw $t0,_resultado
	li $v0,1
	move $a0,$t0
	syscall
#	Fin
	li $v0, 10
	syscall
