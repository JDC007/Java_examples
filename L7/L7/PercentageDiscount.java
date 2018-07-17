package L7;

public class PercentageDiscount implements IDiscount {

	private double percentage;
	
	public PercentageDiscount(double percentage) {
		this.percentage = percentage;
	}

	public double getPercentage() {
		return percentage;
	}

	public void setPercentage(double percentage) {
		this.percentage = percentage;
	}

	public double getTotal(double price) {
		return price - price * percentage / 100.00;
	}
}