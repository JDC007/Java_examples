package examples;

import java.util.Scanner;

public class Example006 {

	public static void main(String[] args) {
		
		Scanner input = new Scanner(System.in);
		
		System.out.println("Enter a value n ::: ");
		int n = input.nextInt();
		
		int i = 1;
		
		while(i <= 2*n){
			
			
			if(i % 2 != 0)
				System.out.println("i = " + i);
			
			i = i + 1;
		}
		
		
		
		

	}

}
