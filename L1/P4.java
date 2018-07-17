package L1;

import java.util.Scanner;

public class P4 {

	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		System.out.println("Input:");
		int a  = s.nextInt();
		
		while(a != 0){
			int remainder = a % 10;
			System.out.print(remainder);
			a /= 10;
		}
	}
}