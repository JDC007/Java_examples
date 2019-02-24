package problems;
import java.util.Scanner;
public class Task5 {
	static double balance = 0;
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner input = new Scanner(System.in);
		
		while(true) {
			System.out.println("1. Deposit\n" + 
					"2. Withdraw\n" + 
					"3. Balance\n" + 
					"4. Exit");
			System.out.println();
			int n = input.nextInt();
			if(n==4) {
				break;
			}
			else {
				switch(n) {
				case 1 :
					double x;
					x = input.nextDouble();
					x = deposit(x);
					balance = x;
					break;
				case 2 :
					double y;
					y = input.nextDouble();
					y = withdraw(y);
					balance  = y;
					break;
				case 3 :
					System.out.println(balance);
					break;
				}
			}
			
		}
		
		
		
	}
	public static double deposit(double amount) {
		double new_amount = amount + balance;
		return new_amount;
		
	}
	public static double withdraw(double amount) {
		double new_amount = balance - amount;
		return new_amount;
		
	}
	
}
