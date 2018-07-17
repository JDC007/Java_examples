package examples;

import java.util.Scanner;

public class Example002 {

	public static void main(String[] args) {
		
		Scanner input = new Scanner(System.in);
		
		System.out.print("Enter the values of a and b  ::: ");
		int a = input.nextInt();
		int b = input.nextInt();
		
		int result = power(a,b);
		
		System.out.println(a + " ^ " + b + " = " + result );
		
	}

	public static int power(int a,int b){
		
		int pow = 1;
		
		for(int i = 1; i <= b; i++){
			
			pow = pow * a;
			
		}
		
		return pow;
		
		
		
	}
	
	
	
}
