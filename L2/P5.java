package L2;

public class P5 {

	public static void main(String[] args) {
		int [] a = {1, 2, 3, 4, 5};
		int [] b = new int [a.length];
		int index = 0;
		
		for(int i = a.length - 1; i >= 0; i--){
			b[index] = a[i];
			index++;
		}
		
		/*
		 * another way to copy in reverse order is this:
		 * for(int i = 0; i < a.length; i++){
		 *     b[i] = a[a.length - 1 - i];
		 * }
		 */
		
		for(int i = 0; i < b.length; i++){
			System.out.print(b[i] + " ");
		}
	}
}