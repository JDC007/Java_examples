package theorymid;

public class Time {
	private int hour;
	private int minute;
	private int second;
	
	public Time(int hour, int minute, int second){
		setTime(hour, minute, second);
	}
	
	public void setTime(int hour, int minute, int second){
		setHour(hour);
		setMinute(minute);
		setSecond(second);
	}
	
	public int getHour(){
		return hour;
	}
	
	public int getMinute(){
		return minute;
	}
	
	public int getSecond(){
		return second;
	}
	
	public void setHour(int hour){
		if(hour >=0 && hour <24){
			this.hour = hour;
		}
	}
	
	public void setMinute(int minute){
		if(minute >=0 && minute <60){
			this.minute = minute;
		}
	}
	
	public void setSecond(int second){
		if(second >=0 && second < 60){
			this.second = second;
		}
	}
	
	public String toString(){
		return hour + ":" + minute + ":" + second;
	}
	
	public Time nextSecond(){
		second += 1;
		
		if(second > 59){
			second = 0;
			nextMinute();
		}
		
		return this;
	}
	
	public Time nextMinute(){
		minute += 1;
		
		if(minute > 59){
			minute = 0;
			nextHour();
		}
		
		return this;
	}
	
	public Time nextHour(){
		hour += 1;
		
		if(hour > 23){
			hour = 0;
		}
		
		return this;
	}
	
	public Time previousSecond(){
		second -= 1;
		
		if(second < 0){
			second = 59;
			previousMinute();
		}
		
		return this;
	}
	
	public Time previousMinute(){
		minute -= 1;
		
		if(minute < 0){
			minute = 59;
			previousHour();
		}
		
		return this;
	}
	
	public Time previousHour(){
		hour -= 1;
		
		if(hour < 0){
			hour = 23;
		}
		
		return this;
	}
}