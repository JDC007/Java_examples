package tasks;

public class Plant {
	private String name;
	private String color;
	
	Plant(){
		
	}
	
	Plant(String a, String b){
		this.name = a;
		this.color = b;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}
	
	public String toString() {
		return "Name: "+this.name + " Color: "+this.color;
	}
}
