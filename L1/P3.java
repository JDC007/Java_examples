package L1;

import java.util.Scanner;

public class P3 {

	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		System.out.println("Input 1:");
		int a  = s.nextInt();
		System.out.println("Input 2:");
		int b  = s.nextInt();
		
		while(a <= b){
			if(a % 2 == 0 || a % 3 == 0 || a % 5 == 0){
				System.out.print(a + " ");
			}
			
			a++;
		}
	}
}