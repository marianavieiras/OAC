.data
#area de dados da memoria principal
	entrada: .asciiz "Entre com um valor para realizar a operação:"
	result: .word 0
	string:  .space 100
	valor:     .word 0
.text
    
 #imprime a mensagem para o usuário inserir a expressão
    li $v0, 4
    la $a0, entrada
    syscall
    
 #expressão do usuário
 	li $v0, 8       
        la $a0, string   #endereço da string  para $a0
        li $a1, 100     # carrega o tamanho máximo da string para $a1
        syscall        
  
        la $t0, string   # carrega o endereço da string para $t0
        la $t1, valor      # carrega o endereço de valor para $t1
        addi $valor, $valor, -4  # salva o valor no topo da pilha
        addi $t1, $t1, 4 # incrementa o endereço em 4
    
    #Loop para processar a operação
   loop:
        lbu $t2, 0($t0) # carrega o próximo caractere da string para $t2
        addi $t0, $t0, 1 # incrementa o endereço da string em 1

        beqz $t2, end    # se o caractere é zero, salta para end
        blt $t2, '0', end # se o caractere é menor que '0', salta para end
        bgt $t2, '9', op # se o caractere é maior que '9', salta para op

        # caractere é um dígito
        sub $t2, $t2, '0' # subtrai o caractere '0' do dígito
        sw $t2, 0($t1)   # salva o dígito na pilha
        addi $t1, $t1, 4 # incrementa o endereço de sp em 4
        j loop           # volta para o início do loop

        # caractere é uma operação
        op:
        lw $t2, 4($sp)   # carrega o segundo operando da pilha para $t2
        lw $t3, 8($sp)   # carrega o primeiro operando da pilha para $t3
        addi $sp, $sp, 8 # remove os operandos da pilha

        beq $t2, '+', add # se o operador é '+', salta para add
        beq $t2, '*'



