package problems;

public class PaperBook extends Book {
	int bookcount= 0;
	double weight,cost;
	
	PaperBook(String s,String a, double p, double x){
		super(s,a,p);
		this.weight = x;
	}
	
	public double getShippingWeight() {
		return this.weight;
	}
	
	public boolean getInStock() {
		return true;
	}
	
	public String toString(){
		return super.toString()+" Bookcount: "+this.bookcount+" Weight: "+this.weight;
	}

}
