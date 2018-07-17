package fileio;

import java.io.*;
import java.util.Scanner;

public class SampleFileIOExample {

	public static void main(String[] args) {
		
		//fileWrite("DATA.txt","hjg  khvkjbjk kjbbkbkh kjguig\n");
		fileRead("DATA.txt");
		
	}
	
	public static void fileRead(String path){
		
		try{
			File f = new File(path);
		
			Scanner input = new Scanner(f);
			
			while(input.hasNextLine() == true){
				System.out.println(input.nextLine());
			}
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
