package L5;

public class Line {

	private Point start;
	private Point end;
	
	public Line(Point start, Point end) {
		this.start = start;
		this.end = end;
	}

	public Point getStart() {
		return start;
	}

	public void setStart(Point start) {
		this.start = start;
	}

	public Point getEnd() {
		return end;
	}

	public void setEnd(Point end) {
		this.end = end;
	}

	public double length(){
		double x_bar = start.getX() - end.getX();
		double y_bar = start.getY() - end.getY();
		return Math.sqrt((x_bar * x_bar) + (y_bar * y_bar));
	}
	
	public static void main(String[] args) {
		Point p1 = new Point(1, 1);
		Point p2 = new Point(4, 4);
		Line x = new Line(p1, p2);
		System.out.println(x.length());
	}
}