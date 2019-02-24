package problems;

import java.util.Scanner;


public class Task4 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int[][] arr = new int[3][3];
		
		Scanner sc = new Scanner(System.in);
		
		for(int i=0; i<3; i++) {
			for(int j=0; j<3; j++) {
				arr[i][j] = sc.nextInt();
				
			}
		}
		int sum_row = 0;
		int sum_col = 0;
		int diag = 0;
		int anti_diag = 0;
		for(int i = 0;i<3;i++,sum_row=0,sum_col = 0) {
			for(int j =0;j<3;j++) {
				sum_row += arr[i][j];
				sum_col += arr[j][i];
				if(i==j) {
					diag += arr[i][j];
				}
				if(i+j==2) {
					anti_diag+=arr[i][j];
				}
			}
			System.out.println("Each summation of row: "+sum_row);
			System.out.println("Each summation of column: "+sum_col);
			System.out.println("Summation of diagonal: "+diag);
			System.out.println("Summation of anti_diagonal: "+anti_diag);
			
		}
		
			
	}

}
