package problems;

import java.util.Scanner;

public class Task4 {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String str = new String();
		Scanner input = new Scanner(System.in);
		str = input.nextLine();
		int x;
		x = isPalindrome(str);
		if(x==1) {
			System.out.println("This is a palindrome String");
		}
		else {
			System.out.println("This is not a palindrome String");
		}
			

	}
	public static int isPalindrome(String str) {
		
		String reverse = "";
		for(int i = str.length() - 1; i >= 0; i--)
        {
            reverse = reverse + str.charAt(i);
        }
		//System.out.println(reverse);
		//System.out.println(str);
		if(str.compareTo(reverse)==0) {
			return 1;
		}
		else {
			return 0;
		}
			
		
	}
}
