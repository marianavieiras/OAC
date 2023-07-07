.data
	expressao: .asciiz "Resultado: "
	equacao: .asciiz "5 6 2 + 4 * + 3 - = "
.text

	li $t1, 6
	li $t2, 2
	jal soma

	lw $t1, 0($sp)
	li $t2, 4
	jal multiplicacao

	li $t1, 5
	lw $t2, 0($sp)
	jal soma

	lw $t1, 0($sp)
	lw $t2, 8($sp)
	jal subtracao

	j fim
soma: 
	add $t0, $t1, $t2
	subi $sp, $sp, 4
	sw $t0, 0($sp)
	jr $ra
subtracao: 
	sub $t0, $t1, $t2
	subi $sp, $sp, 4
	sw $t0, 0($sp)
	jr $ra
multiplicacao: 
	add $t3, $t3, $t2
	subi $t1, $t1, 1
	beqz $t1, armazena_multiplicacao

	j multiplicacao

armazena_multiplicacao: 
	move $t0, $t3
	subi $sp, $sp, 4
	sw $t0, 0($sp)
	jr $ra
fim: 
	la $a0, expressao
	li $v0, 4
	syscall
	la $a0, equacao
	li $v0, 4
	syscall
	lw $a0, 0($sp)
	li $v0, 1
	syscall
