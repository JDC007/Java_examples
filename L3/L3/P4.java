package L3;

import java.util.Scanner;

public class P4 {

	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		int x = s.nextInt();
		int y = s.nextInt();
		generatePrime(x, y);
	}
	
	public static void generatePrime(int a, int b){
		for(int i = a; i <= b; i++){
			if(isPrime(i)){
				System.out.println(i);
			}
		}
	}
	
	public static boolean isPrime(int a){
		boolean prime = true;
		
		/*
		 * When asked why i doesn't start from 1, most of the students
		 * replied because 1 is not prime number. Actually i doesn't start
		 * from 1 because every number is divisible by 1, so there's no point
		 * of checking the divisibility by 1
		 * */
		for(int i = 2; i <= Math.sqrt(a); i++){
			if(a % i == 0){
				prime = false;
			}
		}
		
		return prime;
	}
}