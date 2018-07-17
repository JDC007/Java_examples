package L7;

public class ThresholdDiscount implements IDiscount {

	private double threshold;
	private double discount;
	
	public ThresholdDiscount(double threshold, double discount) {
		this.threshold = threshold;
		this.discount = discount;
	}

	public double getThreshold() {
		return threshold;
	}

	public void setThreshold(double threshold) {
		this.threshold = threshold;
	}

	public double getDiscount() {
		return discount;
	}

	public void setDiscount(double discount) {
		this.discount = discount;
	}

	public double getTotal(double price) {
		if(price >= threshold){
			price -= discount;
		}
		
		return price;
	}
}