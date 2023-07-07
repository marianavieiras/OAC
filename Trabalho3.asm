.data
#area de dados da memoria principal
	entrada: .asciiz "Entre com um valor para realizar a opera��o:"
	result: .word 0
	string:  .space 100
	valor:     .word 0
.text
    
 #imprime a mensagem para o usu�rio inserir a express�o
    li $v0, 4
    la $a0, entrada
    syscall
    
 #express�o do usu�rio
 	li $v0, 8       
        la $a0, string   #endere�o da string  para $a0
        li $a1, 100     # carrega o tamanho m�ximo da string para $a1
        syscall        
  
        la $t0, string   # carrega o endere�o da string para $t0
        la $t1, valor      # carrega o endere�o de valor para $t1
        addi $valor, $valor, -4  # salva o valor no topo da pilha
        addi $t1, $t1, 4 # incrementa o endere�o em 4
    
    #Loop para processar a opera��o
   loop:
        lbu $t2, 0($t0) # carrega o pr�ximo caractere da string para $t2
        addi $t0, $t0, 1 # incrementa o endere�o da string em 1

        beqz $t2, end    # se o caractere � zero, salta para end
        blt $t2, '0', end # se o caractere � menor que '0', salta para end
        bgt $t2, '9', op # se o caractere � maior que '9', salta para op

        # caractere � um d�gito
        sub $t2, $t2, '0' # subtrai o caractere '0' do d�gito
        sw $t2, 0($t1)   # salva o d�gito na pilha
        addi $t1, $t1, 4 # incrementa o endere�o de sp em 4
        j loop           # volta para o in�cio do loop

        # caractere � uma opera��o
        op:
        lw $t2, 4($sp)   # carrega o segundo operando da pilha para $t2
        lw $t3, 8($sp)   # carrega o primeiro operando da pilha para $t3
        addi $sp, $sp, 8 # remove os operandos da pilha

        beq $t2, '+', add # se o operador � '+', salta para add
        beq $t2, '*'



