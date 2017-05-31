.data
cad: .asciiz "\nIntroduzca un número positivo: "
cad2: .asciiz "\nEl número ha de ser positivo!"
cad3: .asciiz "\nEl número es primo "
cad4:  .asciiz "\nEl númer ono es primo"
 .globl main
 .text
main: 

 li $v0, 4
 la $a0, cad
 syscall  #Llamada al sistema para imprimir cadena

 li $v0, 5 
 syscall  #Llamada al sistema para leer un númeo

 move $a3, $v0 #Guardamos el número leído en a3
 #la $a1, cad2 #Segundo argumento: cadena de error
 
 li $a2, 1 #contador
 jal calcular
 li $v0,10 #fin
 syscall
calcular:
 bgt $a3, $zero, seguimos #Comprobamos que sea positivo
 li $v0, 4 #Si no lo es, imprimimos la cadena de error de $a1
 move $a0, $a1
 syscall  #El númer no es positivo!!
 li $v0, -1 #Devolvemos -1 que es el código de error
 jr $ra

seguimos:
 beq $a3, $a2, final
 addi $sp,$sp, -4 #Como vamos a llamar a otra función, almacenamos
 sw $ra, ($sp) # el registro $ra en la pila
 jal primo #Llamada a la función para ver si es primo

 beq $v0, $zero, noprimo #Si el resultado es 0, no es primo
 li $v0,1 #imprime  el numero
 la $a0, ($a2)
 syscall  
noprimo:
 addi $a2, $a2, 1
 j seguimos
final:
 lw $ra, ($sp) #Desapilamos $ra
 addi $sp, $sp, 4
 jr $ra




 #Función primo
primo:
 bgt $a0, $zero, positivo #Comprobamos que sea positivo
positivo: #Si el número es positivo...

 addi $sp,$sp, -4 #Como vamos a llamar a otra función, almacenamos
 sw $ra, ($sp) # el registro $ra en la pila

 jal calcula_divisores #Esta función devuelv een $v0 el nº e divisores del número almcenado en $a0 (argumento de la función)

 lw $ra, ($sp) #Desapilamos $ra
 addi $sp, $sp, 4

 li $t0, 2
 beq $v0, $t0, es_primo #Si el númer otiene 2 divisores (1 y él) es primo
 
 li $t0, 1
 beq $v0, $t0, es_primo #Si el númer otiene 1 divisores (1) es primo (es el 1)
 li $v0, 0 #Devolvemos cero porque no es primo (no tiene 2 divisores)
 jr $ra
 
es_primo:
 li $v0, 1 #Devolvemos uno porque es primo
 jr $ra 

calcula_divisores:
 li $t1, 0 #inicializamos el contador de divisores
 li $t2, 1 #El primer número que vamos a analizar si es divisor es el 1

bucle:
 bgt $t2, $a0, fin #Si el número a analizar es mayor, hemos acabado 
 div $a0, $t2 #Dividimos el número entre el posible divisor
 mfhi $t3 #Nos quedamos con el resto
 addi $t2, $t2, 1 #Pasamos al siguiente número
 bne $t3, $zero, bucle #Si el resto no es 0, no es divisor. Seguimos mirando...
 addi $t1, $t1, 1 #Si el resto es 0, es divisor. Sumamos uno al contador de divisores
 j bucle  #Seguimos mirando

fin: 
 move $v0, $t1 #Pasamos el número de divisres a $v0
 jr $ra


