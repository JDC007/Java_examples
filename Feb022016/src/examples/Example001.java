package examples;

import java.util.Scanner;

public class Example001 {

	public static void main(String[] args) {
		
		int[] a  = new int[5];
		
		//a[2] = 5;
		//a[4] = 1;
		
		Scanner input = new Scanner(System.in);
		
		for(int i = 0; i < a.length; i++){
			
			System.out.print("Enter the value for a[" + i + "]");
			a[i] = input.nextInt();
		}
		
		
		for(int i = 0; i < a.length; i++){
			
			System.out.println("a[" + i + "] = " + a[i]);
			
		}
		
		
		
		
	}

}
