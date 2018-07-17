package L3;

public class P6 {

	public static void main(String[] args) {
		int a = 16, b = 120;
		System.out.println(gcd(a, b));
	}
	
	public static int gcd(int a, int b){
		int g = 1;
		
		for(int i = 2; i <= a; i++){ // assuming a is lower number
			if(a % i == 0 && b % i == 0){
				g = i;
			}
		}
		
		return g;
	}
}