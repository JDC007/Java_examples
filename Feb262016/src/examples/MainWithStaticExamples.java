package examples;

public class MainWithStaticExamples {

	public static void main(String[] args) {
		
		System.out.println("count = " + Circle.count);
		
		Circle x = new Circle(5);
		
		System.out.println("count = " + x.count);
		x.count = 5;
		System.out.println("count = " + Circle.count);
		System.out.println("count = " + x.count);
		
		Circle y = new Circle(7);
		
		System.out.println("count = " + y.count);
		
		
		
	}

}
