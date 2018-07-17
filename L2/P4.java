package L2;

public class P4 {

	public static void main(String[] args) {
		int [] numbers = {4, 6, 64, 120, 496, 8128};
		
		for(int i = 0; i < numbers.length; i++){
			int sumOfDivisors = 0;
			
			for(int j = 1; j <= numbers[i] / 2; j++){
				if(numbers[i] % j == 0){
					sumOfDivisors += j;
				}
			}
			
			if(sumOfDivisors == numbers[i]){
				System.out.println(numbers[i] + " is perfect");
			}
		}
	}
}