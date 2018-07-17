package examples;



public class Main {

	public static void main(String[] args) {
		
		Cylinder cy = new Cylinder(3,5);
		
		System.out.println("Area = " + cy.area());
		
		Circle z = (Circle)cy;
		
		System.out.println("Area = " + z.area());
		
		
	/*	
		System.out.println("Volume of cylinder " + cy.volume());
		System.out.println("Base Area = " + cy.area());
		
		cy.setRadius(5);
		
		System.out.println("Volume of cylinder " + cy.volume());
		System.out.println("Base Area = " + cy.area());
		
		Circle x = (Circle)cy;
		System.out.println("Radius = " + x.getRadius());
		
		*/
		
	}

}
