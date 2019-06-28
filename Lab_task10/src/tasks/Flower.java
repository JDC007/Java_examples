package tasks;

public class Flower extends Plant{
	private Boolean hasSmell;
	private Boolean hasThorn;
	
	Flower(){
		
	}

	Flower(Boolean a, Boolean b){
		this.hasSmell = a;
		this.hasThorn = b;
	}
	
	Flower(String a, String b,Boolean c, Boolean d){
		super(a,b);
		this.hasSmell = c;
		this.hasThorn = d;
	}

	public Boolean getHasSmell() {
		return hasSmell;
	}

	public void setHasSmell(Boolean hasSmell) {
		this.hasSmell = hasSmell;
	}

	public Boolean getHasThorn() {
		return hasThorn;
	}

	public void setHasThorn(Boolean hasThorn) {
		this.hasThorn = hasThorn;
	}
	
	public String toString() {
		return super.toString()+"\n"+this.hasSmell+" "+this.hasThorn;
	}
}
