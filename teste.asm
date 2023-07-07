               .data
str:    .asciiz "Digite a express�o na nota��o polonesa invertida: "
result: .word 0
stack:  .space 100
sp:     .word 0

        .text
        .globl main
main:
        li $v0, 4      # carrega o c�digo 4 na $v0 (syscall print_string)
        la $a0, str     # carrega o endere�o da string str para $a0
        syscall         # chama a syscall para exibir a string

        li $v0, 8       # carrega o c�digo 8 na $v0 (syscall read_string)
        la $a0, stack   # carrega o endere�o da string stack para $a0
        li $a1, 100     # carrega o tamanho m�ximo da string para $a1
        syscall         # chama a syscall para ler a string

        la $t0, stack   # carrega o endere�o da string stack para $t0
        la $t1, sp      # carrega o endere�o de sp para $t1
        addi $sp, $sp, -4 # incrementa o endere�o de sp em -4
        sw $t1, 0($sp)  # salva o valor de sp no topo da pilha

        loop:
        lbu $t2, 0($t0) # carrega o pr�ximo caractere da string para $t2
        addi $t0, $t0, 1 # incrementa o endere�o da string em 1

        beqz $t2, end    # se o caractere � zero, salta para end
        blt $t2, '0', end # se o caractere � menor que '0', salta para end
        bgt $t2, '9', op # se o caractere � maior que '9', salta para op

        # caractere � um d�gito
        sub $t2, $t2, '0' # subtrai o caractere '0' do d�gito
        addi $sp, $sp, -4 # incrementa o endere�o de sp em -4
        sw $t2, 0($sp)   # salva o d�gito na pilha
        j loop           # volta para o in�cio do loop

        # caractere � uma opera��o
        op:
        lw $t2, 4($sp)   # carrega o segundo operando da pilha para $t2
        lw $t3, 8($sp)   # carrega o primeiro operando da pilha para $t3
        
     
        end: 
        lw $t0, result
	addi $t0, $t0, 1
	sw $t0, result

