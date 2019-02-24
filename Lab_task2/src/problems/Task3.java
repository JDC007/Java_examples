package problems;

public class Task3 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		int max = 150;
		int min = 100;
		
		while(max>min) {
			if(max%8==0) {
				System.out.print(max+" ");
			}
			max--;
		}

	}

}
