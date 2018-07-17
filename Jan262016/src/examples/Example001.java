package examples;

import java.util.Scanner;

public class Example001 {

	public static void main(String[] args) {
		
		Scanner input = new Scanner(System.in);
		
		System.out.println("Enter a value n ::: ");
		int n = input.nextInt();
		
		int i = 1, sum = 0;
		
		while(i <= 2*n){
			
			
			if(i % 2 != 0)
				sum = sum + i;
			
			i = i + 1;
		}
	
		System.out.println("sum = " + sum);
		

	}

}
