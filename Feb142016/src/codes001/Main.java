package codes001;

import java.util.Scanner;
import codes002.ExampleMethods001;

public class Main {

	public static int x = 2;
	public static final double G  = 9.8;
	
	public static void main(String[] args) {
		
		Scanner input = new Scanner(System.in);
		System.out.print("Enter the value of n ::: ");
		int n = input.nextInt();
		
		int result = ExampleMethods.factorial(n);
		
		System.out.println(n + " ! =  " + result);
		
		ExampleMethods001.printN(n);
		
		printString("Hello");
	}
	
	private static void printString(String s){
		
		System.out.println(s);
	}

}
