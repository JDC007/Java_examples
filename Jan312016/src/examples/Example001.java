package examples;

import java.util.Scanner;

public class Example001 {

	public static void main(String[] args) {
		
		Scanner input = new Scanner(System.in);
		
		boolean isPrime = true;
		
		System.out.print("Enter a number ---> ");
		int x = input.nextInt();
		
		for(int i = 2; i < x; i++){
			
			if(x % i == 0){
				isPrime = false;
				break;
			}
			
			
		}
		
		if(isPrime == true)
			System.out.println(x + " is a prime number");
		else
			System.out.println(x + " is not a prime number");
		
		
	}

}
