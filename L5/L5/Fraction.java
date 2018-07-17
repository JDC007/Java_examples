package L5;

public class Fraction {

	private int numerator;
	private int denominator;
	
	public Fraction(int numerator, int denominator) {
		this.numerator = numerator;
		this.denominator = denominator;
	}

	public int getNumerator() {
		return numerator;
	}

	public void setNumerator(int numerator) {
		this.numerator = numerator;
	}

	public int getDenominator() {
		return denominator;
	}

	public void setDenominator(int denominator) {
		this.denominator = denominator;
	}

	public String toString(){
		return numerator + "/" + denominator;
	}
	
	public void add(Fraction f){
		numerator = f.getDenominator() * numerator + f.getNumerator() *  denominator;
		denominator = denominator * f.getDenominator();
	}
	
	public void sub(Fraction f){
		numerator = f.getDenominator() * numerator - f.getNumerator() *  denominator;
		denominator = denominator * f.getDenominator();
	}
	
	public void multiplication(Fraction f){
		numerator *= f.getNumerator();
		denominator *= f.getDenominator();
	}
	
	public void division(Fraction f){
		numerator *= f.getDenominator();
		denominator *= f.getNumerator();
	}
	
	public static void main(String[] args) {
		Fraction f1 = new Fraction(1, 2);
		Fraction f2 = new Fraction(1, 2);
		System.out.println(f1.toString());
		f1.add(f2);
		System.out.println(f1.toString());
		f1.sub(f2);
		System.out.println(f1.toString());
		f1.multiplication(f2);
		System.out.println(f1.toString());
		f1.division(f2);
		System.out.println(f1.toString());
	}
}