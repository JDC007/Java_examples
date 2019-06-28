package problems;

public class Line {

	private Point start;
	private Point end;
	
	Line(Point start, Point end){
		this.start = start;
		this.end = end;
	}
	Line(int x1, int y1,int x2, int y2){
		start.setX(x1);
		start.setY(y1);
		end.setX(x2);
		end.setY(y2);
	}
	
	public Point getStart(){
		return this.start;
	}
	
	public Point getEnd(){
		return this.end;
	}
	
	public void setStart(Point point) {
		this.start = point;
	}
	
	public void setEnd(Point point) {
		this.end = point;
	}
	
	public double length() {
		double len = 0;
		len = Math.sqrt((start.getX()-end.getX())*(start.getX()-end.getX()) + (start.getY()-end.getY())*(start.getY()-end.getY()));
		return len;
	}
}
