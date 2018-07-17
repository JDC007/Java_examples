package examples;

public class MainObjectPassingReturning {

	public static void main(String[] args) {
		
		Circle c = new Circle(3);
		
		System.out.println("Radius of c = " + c.getRadius());
		
		objectPass(c);
		
		System.out.println("Radius of c = " + c.getRadius());
	
		Circle k = objectReturn();
		
		System.out.println("Radius of k = " + k.getRadius());
		
	
	}
	
	public static void objectPass(Circle x){
		
		x.setRadius(x.getRadius() + 4);
		
	}
	
	public static Circle objectReturn(){
		
		Circle y = new Circle(10);
		
		return y;
	}
	
	
	

}
