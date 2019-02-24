package Task;

import java.util.Scanner;

public class Task1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Scanner sc = new Scanner(System.in);
		
		int n = sc.nextInt();
		if(n==0) {
			System.out.println("The number is zero");
		}
		else {
			n = n%2;
			switch(n) {
			
			case 1 :
				System.out.println("It is a odd number");
				break;
			case 0 :
				System.out.println("It is a even number");
			
			}
		}
		

	}

}
