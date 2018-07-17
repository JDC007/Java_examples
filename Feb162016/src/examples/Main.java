package examples;

import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		
		//Scanner input = new Scanner(System.in);
		
	//	double r = input.nextDouble();
		
		Circle x = new Circle(5);
		Circle y = new Circle(7);
		
		System.out.println("Area of circle x :: " + x.area());
		System.out.println("Area of circle y :: " + y.area());
		
		System.out.println("Radius of circle x :: " + x.getRadius());
		System.out.println("Radius of circle y :: " + y.getRadius());
		
		x.setRadius(-3);
		
		System.out.println("Area of circle x :: " + x.area());
		System.out.println("Radius of circle x :: " + x.getRadius());
		
		
	}

}
