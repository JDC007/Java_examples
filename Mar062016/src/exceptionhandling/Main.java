package exceptionhandling;

public class Main {

	public static void main(String[] args) {
		
		System.out.println("Main starts here");
		
		try{
			
			//int z = 3/0;
			
			int[] x = new int[10];
			x[100] = 2;
		}
		catch(Exception e){
			System.out.println(e.toString());
		}
		/*catch(ArrayIndexOutOfBoundsException e){
			
			System.out.println("Array Index Error");
		}
		catch(ArithmeticException e){
			
			System.out.println("Divide by zero");
		}*/
		
		System.out.println("Main ends here");
		
		
	}

}
