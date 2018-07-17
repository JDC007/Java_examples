package examples;

import java.util.Scanner;

public class Example003 {

	public static void main(String[] args) {
		
		int[] a = new int[10];
		int[] b = new int[10];
		
		Scanner input = new Scanner(System.in);
		
		for(int i = 0; i < a.length; i++){
			
			System.out.print("Enter the value for a[" + i + "]");
			a[i] = input.nextInt();
			
		}
		
		int index = a.length - 1;
		
		for(int i = 0; i < a.length; i++){
			
			
			b[i] = a[index];
			index--;
			System.out.print("b[" + i + "]" + b[i]);
		}
		
		
		
		
		
	}

}
