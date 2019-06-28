package task2;

public class PercentageDiscount implements Discountable{
	
	private double percentage;
	
	public PercentageDiscount(double percentage) {
		super();
		this.percentage = percentage;
	}

	public double getPercentage() {
		return percentage;
	}

	public void setPercentage(double percentage) {
		this.percentage = percentage;
	}

	@Override
	public double discountedPrice(double price) {
		double p = price * this.percentage;
		return price - p;
	}

}
