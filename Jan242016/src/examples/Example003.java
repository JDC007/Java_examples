package examples;

import java.util.Scanner;

public class Example003 {

	public static void main(String[] args) {
		
		Scanner input = new Scanner(System.in);
		
		System.out.println("Enter the values of base and height ::");
		double base = input.nextDouble();
		double height = input.nextDouble();
		
		double area = 0.5 * base * height;
		
		System.out.println("The area is " + area);

	}

}
