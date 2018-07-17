package abstractclassexample;

public class Circle extends Shape {
	
	private double radius;
	
	public Circle(String color, double radius){
		
		super(color);
		this.radius = Math.abs(radius);
		
	}
	
	// set and get radius should be implemented here
	
	public double area(){
		
		return Math.PI * radius * radius;
	}
	
	public double perimeter(){
		
		return 2 * Math.PI * radius;
	}

}
