package examples;

import java.util.Scanner;

public class Example002 {

	public static void main(String[] args) {
		
		Scanner input = new Scanner(System.in);
		
		System.out.println("Enter a value in miles ::: ");
		double miles = input.nextDouble();
		
		double kms = miles * 1.6;
		
		System.out.println("The value in kms is " + kms);
		
		
	}

}
