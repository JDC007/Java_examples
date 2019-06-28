package problems;

public class Faculty extends Employee{
	
	private String initial;
	private String rank;
	
	Faculty(){}
	
	Faculty(String initial, String rank){
		this.initial = initial;
		this.rank = rank;
	}
	
	Faculty(String name, String gender, int age, String id, String department, double salary,String initial, String rank) {
		super(name, gender, age, id, department, salary);
		this.initial = initial;
		this.rank = rank;
	
	}

	public String getInitial() {
		return initial;
	}

	public void setInitial(String initial) {
		this.initial = initial;
	}

	public String getRank() {
		return rank;
	}

	public void setRank(String rank) {
		this.rank = rank;
	}
	
	public String toString() {
		return super.toString()+"Initial "+this.initial+"\tRank "+this.rank+"\n";
	}
	
}
