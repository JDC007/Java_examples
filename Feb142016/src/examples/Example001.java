package examples;

public class Example001 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		area(3,4);
		area(4.8);
	}
	
	public static double area(double radius){
		
		return Math.PI * radius * radius;
	}
	
	public static double area(double length,double width){
		
		return length * width;
	}

}
