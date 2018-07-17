package examples;

import java.util.Scanner;

public class Example004 {

	public static void main(String[] args) {
		
		Scanner input = new Scanner(System.in);
		System.out.print("Enter the size ::: ");
		int n = input.nextInt();
		
		
		int[] nums = new int[n];
		
		
		for(int i = 0; i < nums.length; i++){
			
			System.out.print("nums[" + i + "]" + nums[i]);
		}
		
		
		
		
		
	}

}
