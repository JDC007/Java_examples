package tasks;

import java.util.Scanner;

public class Test {

	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		Scanner input = new Scanner(System.in);
		Scanner input2 = new Scanner(System.in);
		Plant [] plants = new Plant[50];
		
		while(true) {
			System.out.println("1.Add\n2.Remove\n3.Search\n4.Display");
			int a = sc.nextInt();
			if(a==1) {
				String s = input.nextLine();
				String s2 = input2.nextLine();
				Plant p = new Plant(s,s2);
				add(plants, p);
				System.out.println(plants[0].getName());
			}
			else if(a==2) {
				String s = sc.nextLine();
				remove(plants, s);
			}
			else if(a==3) {
				String s = sc.nextLine();
				Plant p1 = search(plants, s);
				System.out.println(p1.toString());
			}
			else if(a==4) {
				display(plants);
			}

		}
		
	}
	
	static void add(Plant [] plants, Plant p) {
		for(int i = 0;i<plants.length;i++) {
			if(plants[i] == null) {
				plants[i] = p;
				break;
			}
		}
	}
	
	static void remove(Plant [] plants, String n) {
		for(int i = 0; i< plants.length;i++) {
			if(plants[i].getName()==n) {
				plants[i] = null;
			}
		}
	}
	
	static Plant search(Plant [] plants, String n) {
		int c = 0;
		int i = 0;
		for(i = 0; i< plants.length;i++) {
			if(plants[i].getName()==n) {
				c= 1;
				break;
			}
		}
		if(c==0)
			return null;
		else
			return plants[i];
	}
	
	static void display(Plant [] plants) {
		for(int i=0;i<plants.length;i++) {
			if(plants[i] != null)
				System.out.println(plants[i].toString());
			else
				break;
		}
	}

}
