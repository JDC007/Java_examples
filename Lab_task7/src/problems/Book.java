package problems;

public class Book {
	private String title,author;
	private double price;
	Book(){
		this.title = "No title";
		this.author = "No Author";
		this.price = 0;
	}
	
	Book(String tit, String aut, double price){
		this.title = tit;
		this.author = aut;
		this.price = price;
	}
	
	public String getTtile() {
		return this.title;
	}
	
	public String getAuthor() {
		return this.author;
	}
	
	public double getPrice() {
		return this.price;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public void setPrice(double price) {
		this.price = price;
	}
	
	public String toString() {
		return "Title: "+this.title+" Author: "+this.author+" Price: "+this.price;
	}
	
}
