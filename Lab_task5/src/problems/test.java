package problems;

public class test {

	public static void main(String[] args) {
		Fraction f1 = new Fraction(3,2);
		Fraction f2 = new Fraction(5,7);
		//Fraction f3 = f1.divide(f2);
		Fraction f3 = f1.reciprocal();
		//f1.reduce();
		System.out.println(f1.toString());

	}

}
