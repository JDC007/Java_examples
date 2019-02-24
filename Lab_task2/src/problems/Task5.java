package problems;

import java.util.Scanner;

public class Task5 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Scanner sc = new Scanner(System.in);
		int input = sc.nextInt();
		
		for(int i = 1;i<=input;i++) {
			for(int j = 1;j<=(2*i)-1;j++) {
				if(i%2==1) {
					System.out.print("*");
				}
				else
					System.out.print("+");
			}
			System.out.println();
		}
	}

}
