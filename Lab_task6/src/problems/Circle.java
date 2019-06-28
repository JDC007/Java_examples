package problems;

public class Circle {

	private Point center = new Point(0,0);
	private double radius = 0;
	
	Circle(int xCenter, int yCenter, double radius){
		center.setX(xCenter);
		center.setY(yCenter);
		this.radius = radius;
	}
	
	Circle(Point center, double radius){
		this.center = center;
		this.radius = radius;
	}

	public Point getCenter() {
		return center;
	}

	public void setCenter(Point center) {
		this.center = center;
	}

	public double getRadius() {
		return radius;
	}

	public void setRadius(double radius) {
		this.radius = radius;
	}
	
	public int getCenterX() {
		return center.getX();
	}
	
	public int getCenterY() {
		return center.getY();
	}
	
	public void setCenterX(int x) {
		center.setX(x);;
	}
	
	public void setCenterY(int y) {
		center.setY(y);;
	}
	
	public int[] getCenterXY() {
		int[] x = new int[2];
		x[0] = this.getCenterX();
		x[1] = this.getCenterY();
		return x;
	}
	
	public void setCenterXY(int x, int y) {
		
		center.setX(x);
		center.setY(y);
	}
	
	public String toString() {
		String center_rad = "Circle[center=("+this.getCenterX()+","+this.getCenterY()+"),radius="+this.radius+"]"; 
		return center_rad;
		
	}
	
	public double getArea() {
		double area = 3.14*this.radius*this.radius;
		return area;
	}
	
	public double getCircumference() {
		double area = 2*3.14*this.radius;
		return area;
	}
	
	public double distance(Circle c) {
		double dist = 0;
		return dist;
	}
}
