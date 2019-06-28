package problems;

public class FullTimeEmployee extends Employee{
	
	private double basic;
	private double allowence;
	
	FullTimeEmployee(){}
	
	public FullTimeEmployee(double basic, double allowence) {
		this.basic = basic;
		this.allowence = allowence;
	}

	public double getBasic() {
		return basic;
	}

	public void setBasic(double basic) {
		this.basic = basic;
	}

	public double getAllowence() {
		return allowence;
	}

	public void setAllowence(double allowence) {
		this.allowence = allowence;
	}
	
	public double Salary() {
		super.setSalary(this.basic+this.allowence);
		return this.basic+this.allowence;
	}
	
	public String toString() {
		return super.toString()+"Basic "+this.basic+"\tAllowence "+this.allowence+"\n";
	}

}
