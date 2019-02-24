package Task;

import java.util.Scanner;

public class Task2 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Scanner sc = new Scanner(System.in);
		
		int n = sc.nextInt();
		int c = 0;
		for(int i = 2;i<n;i++) {
			if(n%i==0) {
				c++;
			}	
		}
		if(c==0) {
			System.out.println("It is a prime number");
			
		}
		else
			System.out.println("It is not a prime number");
	}

}
