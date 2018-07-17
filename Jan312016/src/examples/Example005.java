package examples;

import java.util.Scanner;

public class Example005 {

	public static void main(String[] args) {
		
		int[] a = new int[5];
		
		//a[0] = 4;
		//a[3] = 7;
		//a[5] = 9; // wrong statement
		
		Scanner input = new Scanner(System.in);
		
		for(int i = 0; i < 5; i++){
			
			System.out.print("Enter the value for a[" + i + "]");
			a[i] = input.nextInt();
			
		}
		
		
		for(int i = 0; i < 5; i++){
			
			
			System.out.println("a[" + i + "] = " + a[i]);
			
		}
		
		
		
	}

}
