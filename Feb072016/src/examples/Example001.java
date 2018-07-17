package examples;

import java.util.Scanner;

public class Example001 {

	public static void main(String[] args) {
	
		Scanner input = new Scanner(System.in);
		System.out.print("Enter the value of x ::: ");
		int x = input.nextInt();
		
		int f = factorial(x);
		
		System.out.println(x + " ! =  " + f);
		

	}
	
	public static int factorial(int n){
		
		int fact = 1;
		
		for(int i = 1; i <= n; i++){
			
			fact = fact * i;
		}
		
		return fact;
	}
	

}
