# procura numeros primos entre o de inicio e o final
.data

pedido1: .asciiz "Digite o valor inicial da procura de primos: "
pedido2: .asciiz "Digite o valor final da procura de primos: "

texto0: .asciiz "\nIniciando em "
texto1: .asciiz " e terminando em "
texto2: .asciiz ".\nOs seguintes valores são primos!"

espaco: .asciiz "\n"

.text
.globl main

main: # centro do Programa --------------------------------------------

jal ler

li $t0, 2 #dividir por 2 ate n
li $t7, 0 #comparar com 0

jal verifica

j fim # finaliza o programa -------------------------------------------

voltar: # volta para o endereço passado por ra ------------------------

jr $ra # pula para ra -------------------------------------------------

ler: # le o numero a ser decomposto -----------------------------------

la $a0, pedido1
li $v0,4 #pede valor
syscall

li $v0, 5
syscall

move $s0, $v0

la $a0, pedido2
li $v0,4 #pede valor
syscall

li $v0, 5
syscall

move $s1, $v0

la $a0, texto0
li $v0,4 #imprime texto
syscall

move $a0, $s0
li $v0,1 #imprime valor
syscall

la $a0, texto1
li $v0,4 #imprime texto
syscall

move $a0, $s1
li $v0,1 #imprime valor
syscall

la $a0, texto2
li $v0,4 #imprime texto
syscall

j voltar # pula para o voltar -----------------------------------------

percorre: # anda desde o primeiro até o último número -----------------

bge $s0, $s1, voltar

addi $s0, $s0, 1

li $t0, 2

j verifica # entra em loop --------------------------------------------

verifica: # verifica se o número é primo ------------------------------

div $s0, $t0

mfhi $t2

beq $t2, $t7, percorre

addi $t0, $t0, 1

bge $t0, $s0, primo

j verifica # pula para o voltar ---------------------------------------

primo: # imprime o número t1 apos verificação -------------------------

la $a0, espaco
li $v0,4 #imprime texto
syscall

move $a0, $s0
li $v0,1 #imprime valor
syscall

j percorre # pula para o voltar -----------------------------------------

fim: # finaliza o programa --------------------------------------------

li $v0, 10 #finaliza o programa
syscall