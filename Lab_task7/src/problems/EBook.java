package problems;

public class EBook extends Book {
	
	String url;
	double sizeMB;
	
	EBook(String s,String a, double p, double x, String y){
		super(s,a,p);
		this.sizeMB = x;
		this.url = y;
	}
	
	public String getDownloadURL() {
		return this.url;
	}
	
	public double getSizeMB() {
		return this.sizeMB;
	}
	
	public String toString(){
		return super.toString()+" URL: "+this.url+" Size: "+this.sizeMB;
	}

}
