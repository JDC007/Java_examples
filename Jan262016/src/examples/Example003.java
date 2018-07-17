package examples;

import java.util.Scanner;

public class Example003 {

	public static void main(String[] args) {
		
		Scanner input = new Scanner(System.in);
		System.out.println("Enter the values of a and b ;; ");
		int a = input.nextInt();
		int b = input.nextInt();
		
		int i = 1, result = 1;
		
		while(i <= b){
			
			result = result * a;
			
			i = i + 1;
		}
		
		
		System.out.println(a + " ^ " + b + " = " + result);
		
	}

}
