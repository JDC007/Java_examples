package problems;

public class Point {

	private int x;
	private int y;
	
	Point(int x, int y){
		this.x = x;
		this.y = y;
	}
	
	Point(){
		this.x = 0;
		this.y = 0;
	}
	
	public int getX() {
		return this.x;
	}
	
	public int getY() {
		return this.y;
	}
	
	public int[] getXY(){
		int[] a = new int[2];
		a[0] = this.x;
		a[1] = this.y;
		return a;
	}
	
	public void setX(int x) {
		this.x = x;
	}
	
	public void setY(int y) {
		this.y = y;
	}
	
	public String toString() {
		String a = this.x +" , "+ this.y;
		return a;
	}
	
	public double distance(Point point) {
		double dist = 0;
		int x1 = point.x;
		int y1 = point.y;
		int x2 = this.x;
		int y2 = this.y;
		dist = Math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
		return dist;
	}
}
