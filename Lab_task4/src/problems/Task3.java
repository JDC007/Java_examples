package problems;

import java.util.Scanner;

public class Task3 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String str = new String();
		Scanner input = new Scanner(System.in);
		str = input.nextLine();
		System.out.println("The decimal is:  "+bin2Dec(str));

	}
	public static int bin2Dec(String str) {
		
		double dec=0;
	    for(int i=0;i<str.length();i++){
	        if(str.charAt(i)== '1'){
	         dec=dec+ Math.pow(2,str.length()-1-i);
	     }

	    }
	    return (int) dec;
		
	}

}
