package problems;
import java.util.Scanner;
public class Task5 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner input = new Scanner(System.in);
		System.out.print("Enter size: ");
		int  n = input.nextInt();
		
		int[] arr = new int[n];
		System.out.print("Enter numbers: ");
		for(int i = 0;i<n;i++) {
			arr[i] = input.nextInt();
		}
		
		for(int i = 0;i<n-2;i++) {
			if(arr[i]==arr[i+1] && arr[i]==arr[i+2]) {
				System.out.print(arr[i]);
			}
		}
		
	}

}
