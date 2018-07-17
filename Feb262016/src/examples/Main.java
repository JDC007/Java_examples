package examples;

import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		
		Circle[] circles = new Circle[3];
		
		circles[0] = new Circle(3);
		circles[1] = new Circle(5);
		circles[2] = new Circle(7);
		
		for(int i = 0; i < circles.length; i++)
			System.out.println("Area of circle " + i + " = " + circles[i].area());
		
		
	}

}
