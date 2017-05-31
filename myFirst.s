.data
 
     message1: .asciiz "\nDigite um Valor maior que 1 e menor ou igual a 50000:"
     
.text
main:
 
      #$s0 = valor
      #$s1 = maior
      #$s2 = menor
      #$s3 = cont

      li $v0, 4
      la $a0, message1
      syscall

      li $v0, 5
      syscall

      add $s0, $v0, $zero

      li $v0, 1
      add $a0, $zero, $s0
      syscall 
