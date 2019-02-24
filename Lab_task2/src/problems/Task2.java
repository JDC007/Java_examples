package problems;

import java.util.Scanner;

public class Task2 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Scanner sc = new Scanner(System.in);
		int input = sc.nextInt();
		for(int i = input; i > 0; i--) {
			for(int j = 1 ; j<=i;j++) {
				System.out.print(j+" ");
			}
			System.out.println();
		}
	}

}
