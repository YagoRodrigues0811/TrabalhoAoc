.data
enter: .asciiz "\n"
message1 : .asciiz "Digite um número maior que 1 e menor ou igual a 50000\n"
.text
main:
    addi $sp, $sp, -4 # Reserva 1 posição na stack
    sw $ra, 0($sp) # Guarda $ra na stack.
    addi $t0, $zero, 0 # $t0 contador de números primos
    addi $t1, $zero, 1 # Total de números primos a mostrar
    addi $s6, $zero, 1

    li $v0, 4
    la $a0, message1
    syscall

    li $v0, 5
    syscall

    add $t7, $v0, $zero  #$t2 Número de Início
    add $t2, $t7, $zero  #$t2 Número de Início

    
ciclo1:
    addi $t2, $t2, 1 # Número a verificar, começando em 1
    add $a0, $zero, $t2 # Copia $t2 para argumento $a0
    jal primo
    beq $v0,$zero, salto1 # Se não é primo vai para salto1
    addi $t0, $t0, 1 # Contador de números primos
    addi $v0, $zero, 4 # System call $a0=4 (imprime string enter)
    la $a0, enter
    syscall
    addi $v0, $zero, 1 # Syscall $a0=1, imprime inteiro(nº primo)
    addi $a0, $t2, 0 # $t2 é o nº primo a imprimir
    syscall
salto1:
    bne $t0, $t1, ciclo1 # Se o total de números primos < 100 vai p/ ciclo
    
    addi $t0, $zero, 0 # $t0 contador de números primos
    addi $t1, $zero, 1 # Total de números primos a mostrar

ciclo2:

    li $v0, 4           #Remover
    la $a0, message1
    syscall

    sub $t7, $t7, $s6 # Número a verificar, começando em 1
    add $a0, $zero, $t7 # Copia $t2 para argumento $a0
    jal primo
    beq $v0,$zero, salto2 # Se não é primo vai para salto2
    addi $t0, $t0, 1 # Contador de números primos
    addi $v0, $zero, 4 # System call $a0=4 (imprime string enter)
    la $a0, enter
    syscall
    addi $v0, $zero, 1 # Syscall $a0=1, imprime inteiro(nº primo)
    addi $a0, $t7, 0 # $t2 é o nº primo a imprimir
    syscall
salto2:
    bne $t0, $t1, ciclo1 # Se o total de números primos < 100 vai p/ ciclo
    lw $ra, 0($sp) # Re põe valor do $ra
    addi $sp, $sp, 4
    jr $ra
#Procedimento primo faz divião por 2, 3, ... n-1
primo:
    addi $v0, $zero, 1 # Começo por considerar-se o nº primo
    addi $t3, $a0, 0 # $t3 vai tomar todos os valores < ao nº a verificar
    addi $t5, $zero, 2 # Valor abaixo do qual já não se verifica
    px: addi $t3, $t3, -1 # Subtrai 1 a $t3
    slt $t6, $t3, $t5 # $t6=1 se $t3<$t5
    bne $t6, $zero, sai # $t6=1 não analisa
    remu $t4, $a0, $t3 # O resto da divisão do $a0=nº por $t3=valores < $a0
    bne $t4,$zero, px # SEnão divisível analisa px número
    addi $v0, $zero, 0 # Faz $v0=0 se o nº não primo
sai: jr $ra
