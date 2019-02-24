package problems;

import java.util.Scanner;

public class Task2 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner input = new Scanner(System.in);
		int n = input.nextInt();
		int n1=0,n2=1,n3,i;
		int[] arr = new int[n];
		
		arr[0] = n1;
		arr[1] = n2;
		
		for(i=2;i<n;++i){    
			n3=n1+n2;   
		    n1=n2;    
		    n2=n3;
		    arr[i] = n3;
		    }
		System.out.print("First "+n+" Fibonacci numbers :");
		for(i = 0;i<n;i++) {
			System.out.print(" "+arr[i]);
		}
		}
}
