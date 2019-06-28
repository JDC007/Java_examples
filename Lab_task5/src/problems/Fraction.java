package problems;

public class Fraction{
	
	private int denominator;
	private int numerator;
	
	public Fraction(){
		
		
	}
	public Fraction(int x){
		this.numerator = x;
		this.denominator = 1;
	}
	public Fraction(int x, int y){
		this.numerator = x;
		this.denominator = y;
	}
	
	public String toString() {
		
		return this.numerator+"/"+this.denominator;
		
	}
	public int getNumerator() {
		return this.numerator;
	}
	public int getDenominator() {
		return this.denominator;
	}
	public boolean equals(Fraction f) {
		if(this.numerator == f.numerator && this.denominator == f.denominator)
			return true;
		else
			return false;
		
	}
	public Fraction add(Fraction f) {
		Fraction f2 = new Fraction();
		f2.denominator = this.denominator*f.denominator;
		f2.numerator = (this.numerator*f.denominator) + (this.denominator*f.numerator);
		return f2;
		
	}
	public Fraction difference(Fraction f) {
		Fraction f2 = new Fraction();
		f2.denominator = this.denominator*f.denominator;
		f2.numerator = (this.numerator*f.denominator) - (this.denominator*f.numerator);
		return f2;
	}
	public Fraction product(Fraction f) {
		Fraction f2 = new Fraction();
		f2.denominator = this.denominator*f.denominator;
		f2.numerator = this.numerator*f.numerator;
		return f2;
	}
	public Fraction divide(Fraction f) {
		Fraction f2 = new Fraction();
		f2.denominator = this.denominator*f.numerator;
		f2.numerator = this.numerator*f.denominator;
		return f2;
	}
	public Fraction reciprocal() {
		Fraction f2 = new Fraction();
		f2.denominator = this.numerator;
		f2.numerator = this.denominator;
		return f2;
	}
	public void increment() {
		Fraction f2 = new Fraction();
		f2.denominator = this.denominator;
		f2.numerator = this.numerator + this.denominator;
		this.numerator = f2.numerator;
	}
	private void reduce() {
		Fraction f2 = new Fraction();
		f2.denominator = this.denominator;
		f2.numerator = this.numerator - this.denominator;
		this.numerator = f2.numerator;
	}
	private int gcd(int x,int y) {
		int gcd = 0;
		for(int i = 1; i<=x && i<=y;i++) {
			if(x%i == 0 && y%i == 0) {
				gcd = i;
			}
		}
		return gcd;
	}
	public int compareTo(Fraction f) {
		if(this.denominator == f.denominator && this.numerator == f.numerator)
			return 1;
		else
			return 0;
	}
	
	
}
