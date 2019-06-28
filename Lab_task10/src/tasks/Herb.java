package tasks;

public class Herb extends Plant{
	private Boolean isMedicinal;
	private String season;

	Herb(){
		
	}
	Herb(Boolean a, String b){
		this.isMedicinal = a;
		this.season = b;
	}
	Herb(String a, String b,Boolean c, String d){
		super(a,b);
		this.isMedicinal = c;
		this.season = d;
	}
	public Boolean getIsMedicinal() {
		return isMedicinal;
	}
	public void setIsMedicinal(Boolean isMedicinal) {
		this.isMedicinal = isMedicinal;
	}
	public String getSeason() {
		return season;
	}
	public void setSeason(String season) {
		this.season = season;
	}
	
	public String toString() {
		return super.toString()+"\n"+this.isMedicinal+" "+this.season;
	}
}
