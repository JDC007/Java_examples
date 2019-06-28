package problems;

public class Interface {

	public static void main(String[] args) {
		//System.out.println(f.toString());
		PartTimeEmployee f = new PartTimeEmployee(5,45.25);
		f.setName("Joy");
		f.setAge(25);
		f.setGender("Male");
		f.setDepartment("CSE");
		f.setId("151");
		FullTimeEmployee f1 = new FullTimeEmployee(512.125,45.25);
		double f_sal = f.Salary();
		double f1_sal = f1.Salary();
		System.out.println(f.toString());
		System.out.println(f1.toString());
	}

}
