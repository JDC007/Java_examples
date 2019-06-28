package problems;

public class Test {

	public static void main(String[] args) {
		
		Point p1 = new Point(2,4);
		Point p2 = new Point(1,1);
		Line l1 = new Line(p1,p2);
		double x = l1.length();
		System.out.println(x);

	}

}
