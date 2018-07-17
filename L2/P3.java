package L2;

import java.util.Scanner;

public class P3 {

	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		int x = s.nextInt();
		boolean isPrime = true;
		
		for(int i = 2; i <= Math.sqrt(x); i++){ // you can also run it up to x/2
			if(x % i == 0){
				isPrime = false;
				break;
			}
		}
		
		if(isPrime){
			System.out.println(x + " is prime");
		}
		
		else{
			System.out.println(x + " is not prime");
		}
	}
}