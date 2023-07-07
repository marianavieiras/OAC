.data 
	#area de dados da memoria principal
	
	entrada: .asciiz "Entre com um valor para a multiplica��o:"
	entrada2: .asciiz "Entre com outro valor para a multiplica��o:"
	result: .asciiz "Resultado final: "
.text
	#area para instru��es do programa
	
	#leitura do primeiro numero
	li $v0, 4 #imprimir uma string
	la $a0, entrada #chamada da mensagem
	syscall #executar os comandos

	li $v0 5 #leitura do inteiro inserido 
	syscall #executar os comandos

	move $t0, $v0 #valor agora esta em t0

	#leitura do segundo numero
	li $v0, 4 #imprimir uma string
	la $a0, entrada2 #chamada da mensagem
	syscall #executar os comandos

	li $v0 5 #leitura do inteiro inserido
	syscall #executar os comandos

	move $t1, $v0 #valor agora esta em t1

	#loop para realizar as opera��es, no qual pode ser inserido qualquer nome
 loop:
 	beq $zero, $t0, saida #condi��o de saida
	srl $t0, $t0, 1 #divis�o por 2 pelo deslocamento de BITS pelo comando srl
	sll $t1, $t1, 1 #multiplica��o por 2 pelo deslocamento de BITS pelo comando sll
	
 	andi $t2, $t0, 1 #confere se o numero � par ou n�o pelo comando ANDI
	bne $t2, $zero, soma #pr�xima instru��o a ser executada se estiver armazenada no endere�o
	j loop #chamada do loop ocorre novamente pelo comando j
	
	#realiza a soma quando impar na coluna a esquerda
 soma:
 	add $s0,$s0,$t1 #reali��o da soma pelo comando add
 	j loop #chamada do loop ocorre novamente pelo comando j
 	
 saida:
	li $v0, 4 #imprimir uma string
	la $a0, result #chamada da mensagem
	syscall #executar os comandos

	li $v0, 1 #intru��o para impress�o do inteiro
	move $a0, $s0 #valor a ser inserido na rersposta
	syscall #executar os comandos