package L1;

import java.util.Scanner;

public class P2 {

	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		System.out.println("Input:");
		int a = s.nextInt();
		
		if(a % 2 == 0){ // even
			System.out.println("Even");
		}
		
		else{
			System.out.println("Odd");
		}
	}
}