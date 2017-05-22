import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Main classe = new Main();
         Scanner sc = new Scanner(System.in);
         System.out.println("Digite um número maior que 1 e menor ou igual a 50000");
         int num = sc.nextInt(), maior = 0, menor = 0;
         int cont = num;
         boolean primo = false;
         while (primo == false) {
		       cont--;
		       System.out.println(cont);
			   if (classe.isPrimo(cont)) {
				primo = true;
				menor = cont;
			}
		}
         System.out.println("Menor "+menor);
         primo = false;
         cont = num;
         while (primo == false) {
		       cont++;
		       System.out.println(cont);
			   if (classe.isPrimo(cont)) {
				primo = true;
				maior = cont;
			}
		}
         System.out.println("Maior "+maior);
	}
	
	public boolean isPrimo(int num) {
		int cont = 0;
		for (int i = 1; i <= num ; i++) {
			if(num%i == 0){
				cont++;
			}
		}
		if (cont <= 2) {
			return true;
		}
		return false;
	}
}
