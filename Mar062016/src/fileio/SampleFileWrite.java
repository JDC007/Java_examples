package fileio;

import java.io.*;

public class SampleFileWrite {

	public static void main(String[] args) {
		
		try{
		
			FileWriter fw = new FileWriter("data.txt",true);
			fw.write("Hello welcome to the  files class");
			//fw.write("\n THis is the second line");
			fw.close();
			
		}
		catch(Exception e){
			
			System.out.println("File Handling Error");
		}
		
		

	}

}
