package problems;

public class Task1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		int min = 5;
		int max = 25;
		int random = (int)(min+ Math.random()*(max-min+1));
		System.out.println("Random Integer: "+random);
		
		for(int i = 1;i <= random;i++) {
			System.out.print(i+" ");
		}
		

	}

}
