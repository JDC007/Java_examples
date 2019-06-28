package problems;

public class PartTimeEmployee extends Employee{
	
	private double hours;
	private double rate;
	
	PartTimeEmployee(){}
	
	PartTimeEmployee(double hours, double rate){
		this.hours = hours;
		this.rate = rate;
	}

	public double getHours() {
		return hours;
	}

	public void setHours(double hours) {
		this.hours = hours;
	}

	public double getRate() {
		return rate;
	}

	public void setRate(double rate) {
		this.rate = rate;
	}

	public double Salary() {
		super.setSalary(this.hours* this.rate);
		return this.rate * this.hours;
	}
	public String toString() {
		return super.toString()+"Hours "+this.hours+"\tRate "+this.rate+"\n";
	}

}
