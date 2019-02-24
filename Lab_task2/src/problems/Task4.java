package problems;

public class Task4 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		int max = 2020;
		int min = 1990;
		int random = (int)(min+ Math.random()*(max-min+1));
		if((random % 400==0) || ((random % 4 == 0) && (random % 100 !=0))){
			System.out.print(random+" : true");
		}
		else
			System.out.print(random+" : false");

	}

}
