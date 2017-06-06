.data

message1 : .asciiz "Digite um número maior que 1 e menor ou igual a 50000\n"
messageMaior : .asciiz "Primeiro primo maior: "
messageMenor : .asciiz "\nPrimeiro primo menor: "  
.text
main:
    addi $sp, $sp, -4 # Reserva 1 posição na stack
    sw $ra, 0($sp) # Guarda $ra na stack.
    addi $t0, $zero, 0 
    addi $t1, $zero, 1 
    addi $s6, $zero, 1

    li $v0, 4
    la $a0, message1
    syscall

    li $v0, 5
    syscall
    
    ble $v0, 1, main
    bgt $v0, 50000, main    

    add $t7, $v0, $zero  #$t2 Número de Início maior
    add $t2, $t7, $zero  #$t7 Número de Início menor

    
maior:
    addi $t2, $t2, 1 
    add $a0, $zero, $t2 
    jal primo
    beq $v0,$zero, maiorC 
    addi $t0, $t0, 1 
    addi $v0, $zero, 4 
    la $a0, messageMaior
    syscall
    addi $v0, $zero, 1 
    addi $a0, $t2, 0 
    syscall
maiorC:
    bne $t0, $t1, maior 
    
    addi $t0, $zero, 0 
    addi $t1, $zero, 1 

menor:
    sub $t7, $t7, $s6 
    add $a0, $zero, $t7 
    jal primo
    beq $v0,$zero, menorC 
    addi $t0, $t0, 1 
    addi $v0, $zero, 4 
    la $a0, messageMenor
    syscall
    addi $v0, $zero, 1 
    addi $a0, $t7, 0 
    syscall
menorC:
    bne $t0, $t1, menor 
    lw $ra, 0($sp) 
    addi $sp, $sp, 4
    jr $ra
#Procedimento primo faz divião por 2, 3, ... n-1
primo:
    addi $v0, $zero, 1 
    addi $t3, $a0, 0 
    addi $t5, $zero, 2 
    px: addi $t3, $t3, -1 
    slt $t6, $t3, $t5 
    bne $t6, $zero, sai 
    remu $t4, $a0, $t3 
    bne $t4,$zero, px 
    addi $v0, $zero, 0 
sai: jr $ra
