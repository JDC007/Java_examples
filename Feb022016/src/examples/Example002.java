package examples;

import java.util.Scanner;

public class Example002 {

	public static void main(String[] args) {
		
		double[] nums = new double[10];
		Scanner input = new Scanner(System.in);
		
		double sum = 0;
		
		for(int i = 0; i < nums.length; i++){
			
			nums[i] = input.nextDouble();
			sum = sum + nums[i];
			
		}
		
		System.out.println("sum = " + sum);
		
	}

}
