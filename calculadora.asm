.data
	result: .asciiz  "Resultado: "
	menu: .asciiz "\nDeseja Continuar:\n1-Sim 0-Não\n"
	valor: .asciiz "\nValor até o momento: "
	n1: .asciiz "\nAdicione o primeiro numero: "
	n2: .asciiz "\nAdicione o segundo numero: "
	simbolo: .asciiz "\nDigite o simbolo da operação que deseja executar:\n+ para soma\n- para subtracao\n* para multiplicacao\n/ para divisao\n"
	n3: .asciiz "\nAdicione o proximo numero: "
.text

loop:
    #comandos abaixo para leitura do primeiro numero
    li $v0, 4 
    la $a0, n1
    syscall
    
    li $v0, 5
    syscall
    
    move $s0,$v0
    
    #comandos abaixo para leitura do segundo numero
    li $v0, 4 
    la $a0, n2
    syscall
    
    li $v0, 5
    syscall
    
    move $s1,$v0
    
    j sinal #chamada do comando
    j encerra #chamada do comando

sinal:
    # comando para leitura do sinal
    li $v0, 4 
    la $a0, simbolo
    syscall
    
    li $v0, 12
    syscall
    
    move $t1, $v0
                                                              
    li $t2,'+'
    li $t3,'-'
    li $t4,'*'
    li $t5,'/'
    
    #comando para leitura caso seja igual
    beq $t1, $t2, soma
    beq $t1, $t3, subtracao
    beq $t1, $t4, multiplicacao
    beq $t1, $t5, divisao
    
soma:
    add $s0, $s0, $s1
    
    #imprimindo o valor:
    li $v0, 4 
    la $a0, valor
    syscall
    
    li $v0, 1
    la $a0, ($s0)
    syscall
    
    #imprimindo a mensagem do menu
    li $v0, 4 
    la $a0, menu
    syscall
    
    #leitura do menu
    li $v0, 5
    syscall
    
    move $t0, $v0
    beq $t0,1,continua
    beq $t0,0,encerra
    
subtracao:
    sub $s0, $s0, $s1   
    
    #imprimindo o valor:
    li $v0, 4 
    la $a0, valor
    syscall
    
   
    li $v0, 1
    la $a0, ($s0)
    syscall
    
    #imprime o menu
    li $v0, 4 
    la $a0, menu
    syscall
    
    #leitura do menu
    li $v0, 5
    syscall
    move $t0, $v0
    beq $t0,1,continua
    beq $t0,0,encerra
    
divisao:
    div $s0, $s1         
    mflo $s0
    
    #imprimindo o valor:
    li $v0, 4 
    la $a0, valor
    syscall
    li $v0, 1
    la $a0, ($s0)
    syscall
              
    #imprime o menu
    li $v0, 4 
    la $a0, menu
    syscall
    
    #leitura do menu
    li $v0, 5
    syscall
    
    move $t0, $v0
    beq $t0,1,continua
    beq $t0,0,encerra
 
multiplicacao:
    mult $s0, $s1       
    mflo $s0   
    
    #imprimindo o valor:
    li $v0, 4 
    la $a0, valor
    syscall
    
    li $v0, 1
    la $a0, ($s0)
    syscall
    
    
    #imprime o menu
    li $v0, 4 
    la $a0, menu
    syscall
    
    #leitura do menu
    li $v0, 5
    syscall
    
    move $t0, $v0
    beq $t0,1,continua
    beq $t0,0,encerra

continua:
    #comando para continuar a operação com o novo valor
    li $v0, 4 
    la $a0, n3
    syscall
    
    li $v0, 5
    syscall
    
    move $s1,$v0
    
    #comando do sinal da operação
    j sinal
    
encerra:
   #resultado final para o usuario
    li $v0, 4 
    la $a0, result
    syscall
    
    li $v0, 1
    la $a0, ($s0)
    syscall
    
    li $v0, 10
    syscall