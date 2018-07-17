package fileio;

import java.io.File;
import java.io.FileWriter;
import java.util.Scanner;

public class NumbersExample {

	public static void main(String[] args) {
	
		/*for(int i = 1; i <= 100; i++)
			fileWrite("numbers.txt", i + "\n");
		*/
		
		fileRead("numbers.txt");
	}
	
	public static void fileRead(String path){
		
		try{
			File f = new File(path);
		
			Scanner input = new Scanner(f);
			
			int sum = 0;
			
			while(input.hasNextInt() == true){
				//System.out.println(input.nextInt());
				sum = sum + input.nextInt();
			}
			
			System.out.println(sum);
		}
		catch(Exception e){}
		
		
	}
	
	
	
	
	
	
	public static void fileWrite(String path, String data){
		
		try{
			FileWriter fw = new FileWriter(path,true);
			fw.write(data);
			fw.close();
		}
		catch(Exception e){
			
			System.out.println(e.toString());
		}
		
		
	}
	


}
