package problems;

import java.util.Scanner;

import javax.swing.JOptionPane;

public class Task1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		int[] arr = new int[6]; //array declaration
		
		int sum=0, count=0;
		
		double average;
		
		Scanner sc = new Scanner(System.in);
		
		//take input
		for(int i=0; i<6; i++){
			arr[i] = sc.nextInt();
			sum+=arr[i];
		}
		
		average = sum/6;
		
		for(int i=0; i<6; i++){
			if(arr[i]> average)
				count++;
			
		}
		System.out.println(count);
		
		double result = (count*100)/6;
		
		System.out.println(result);

//		//Just to show off ;)
//		JOptionPane.showMessageDialog(null, result, "Percentage", 1);
//		//JOptionPane.showMessageDialog(parentComponent,message, title, messageType);
	}

}
