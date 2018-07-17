package L6;

public class Cylinder extends Circle{

	private double height;

	public Cylinder(){
		height = 1;
	}
	
	public Cylinder(double height) {
		this.height = height;
	}
	
	public Cylinder(double radius, double height){
		super(radius);
		this.height = height;
	}

	public double getHeight() {
		return height;
	}

	public void setHeight(double height) {
		this.height = height;
	}
	
	public double volume(){
		return area() * height;
	}
}