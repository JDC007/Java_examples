package problems;

import java.util.Scanner;

public class Task3 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		int[][] arr = new int[3][3];
		
		int arr2[][] = new int[3][3];
		
		int [][]result = new int[3][3];
		
		//all initializations are valid;
		Scanner sc = new Scanner(System.in);
		//take input for arr
		for(int i=0; i<3; i++)
			for(int j=0; j<3; j++)
				arr[i][j] = sc.nextInt();

		//take input for arr2
		for(int i=0; i<3; i++)
		for(int j=0; j<3; j++)
		arr2[i][j] = sc.nextInt();

		//calculate result
		for(int i=0; i<3; i++)
		for(int j=0; j<3; j++)
		result[i][j] = arr[i][j] + arr2[i][j];

		//ouptut result
		System.out.println("\nRESULT OUTPUT:");
		for(int i=0; i<3; i++){
		for(int j=0; j<3; j++)
		System.out.print(result[i][j]+"\t");
		System.out.println();
		}

	}

}
