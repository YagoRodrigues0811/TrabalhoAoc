.data

	msgInicial: .asciiz "Numeros Primos entre o intervalo de dois numeros"
	msgPrimo: .asciiz " eh primo.\n "
	msgEntrada: .asciiz "\nDigite um numero:  "
	msgEntrada2: .asciiz "\nDigite outro numero:  "
.text
main:

	#TODO: Concatenar numeros com virgula, depois colocar "eh primo". Fazer if pra ver se nao eh 2 tbm

	#t1 = comeco
	#t2 = fim
	#t3 = i	
	#t4 = resto
	#t5 = j
	#t6 = j*j
	la $t9, 2

	#exibindo mensagem inicial
	li $v0, 4
	la $a0, msgInicial
	syscall

	#exibindo a primeira mensagem de entrada
	li $v0, 4
	la $a0, msgEntrada
	syscall

	#lendo o primeiro numero
	li $v0, 5
	syscall
	
	#Armazenando numero digitado no $t1
	add $t1, $v0, $zero
	
	menorQueInicial:
	#exibindo a segunda mensagem de entrada
	li $v0, 4
	la $a0, msgEntrada2
	syscall

	#lendo o segundo numero
	li $v0, 5
	syscall
	
	#Armazenando o numero digitado no $t2
	add $t2, $v0, $zero
	
	#se o primeiro for maior que o segundo, voltará para menorQueInicial:
	bgt $t1, $t2, menorQueInicial

	add $t3, $t1, 1
	for:
	blt $t3, $t2, continua
	j fimfor
	continua:
		div $t3, $t9
		mfhi $t4
		bne $t4, $zero, continua2
		j naoprimo
		#CORRETO/\
		continua2:
		add $t5, $zero, 3
		for3:
		mul $t6, $t5, $t5
		ble $t6, $t3, continua3
		j fimfor2
		continua3:
		
		div $t3, $t5
		mfhi $t4
		bne $t4, $zero, continua5
		j naoprimo
		continua5:	

		add, $t6, $t6, 2
		ble $t6, $t3, for3
		fimfor2:

		#exibindo mensagem de que eh primo, e o primo
		li $v0, 4
		la $a0, msgPrimo
		syscall

		li $v0, 4
		la $a0, $t3
		syscall
		
	
	naoprimo:
	add $t3, 1, $t3
	blt $t3, $t2, for
	fimfor:
