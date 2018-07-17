package L1;

import java.util.Scanner;

public class P1 {

	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		System.out.println("Input 1:");
		int a  = s.nextInt();
		System.out.println("Input 2:");
		int b  = s.nextInt();
		System.out.println("Input 3:");
		int c  = s.nextInt();
		int sum = a + b + c;
		double average = sum / 3.0;
		System.out.println("Sum: " + sum + "\nAverage: " + average);
	}
}