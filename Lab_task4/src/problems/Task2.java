package problems;
import java.util.Scanner;
public class Task2 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		String s = new String();
		@SuppressWarnings("resource")
		Scanner sc = new Scanner(System.in);
		s=sc.nextLine(); //takes a line;
		System.out.println("Vowel Count: "+countVowels(s));

	}
	
	public static int countVowels(String str){
		int count=0;
		for(int i=0; i<str.length(); i++){
		switch(str.charAt(i)){
		case 'a':
		case 'e':
		case 'i':
		case 'o':
		case 'u':
			count++;
		default:
			continue;

		}
		}
		return count;

}
}
