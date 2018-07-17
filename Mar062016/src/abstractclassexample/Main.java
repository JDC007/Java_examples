package abstractclassexample;

public class Main {

	public static void main(String[] args) {
		
		//Shape sh = new Shape("red");
		
		Circle c = new Circle("blue",3);
		
		System.out.println(c.area());
		
		Shape sh = c;
		
		System.out.println(sh.area());
		
	}

}
