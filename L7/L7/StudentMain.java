package L7;

import java.io.File;
import java.util.Scanner;

public class StudentMain {

	public static void main(String[] args) {
		try {
			File f = new File("info.txt");
			Scanner s = new Scanner(f);
			Student [] students = new Student [3];
			int index = 0;

			while(s.hasNextLine()){
				students[index] = new Student(s.nextLine(), s.nextLine());
				index++;
			}

			for(int i = 0; i < students.length; i++){
				System.out.println(students[i]);
			}
			int max=students[0].getId();
			for(int i =0;i<students.length;i++){
				if(max<students[i])
					max=students[i];
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
