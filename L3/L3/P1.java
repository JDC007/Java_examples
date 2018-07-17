package L3;

public class P1 {

	public static void main(String[] args) {
		int [] a =  {1, 2, 1, 3, 4, 1, 3, 6};
		
		// find the maximum number
		int max = a[0];
		
		for(int i = 0; i < a.length; i++){
			if(a[i] > max){
				max = a[i];
			}
		}
		
		// take an array where frequency for each number will be stored
		int [] frequency = new int [max + 1];
		
		// calculate frequency
		for(int i = 0; i < a.length; i++){
			int temp = a[i];
			frequency[temp]++;
		}
		
		for(int j = 0; j < frequency.length; j++){
			if(frequency[j] > 0){
				System.out.println("Frequency of " + j + " : " + frequency[j]);
			}
		}
	}
}