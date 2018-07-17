

import java.awt.Rectangle;

public class BulletFiring extends Thread {
	
	private GameBoard gameboard;
	private Bullet bullet;
	
	public BulletFiring(GameBoard gameboard, Bullet bullet) {
		
		this.gameboard = gameboard;
		this.bullet = bullet;
	}
	
	public void run(){
		
		
		double velocity = 50, angle = 40, acceleration = -12;
		
		int steps = 200;
		
		double xVelocity = velocity/Math.cos(Math.toRadians(angle));
		double yVelocity = velocity/Math.sin(Math.toRadians(angle));
		
		double totalTime = -2 * yVelocity/acceleration;
		
		double timeIncrement = totalTime/steps;
		double xIncrement = xVelocity * timeIncrement;
		
		double x,y,t;
		
		x = bullet.getX();
		y = bullet.getY();
		t = 0;
		
		for(int i = 0; i <= steps; i++){
			
			t = t + timeIncrement;
			x = x + xIncrement;
			y = yVelocity * t + 0.5 * acceleration * t * t;
			
			
			
			bullet.setX((int)Math.round(x));
			bullet.setY(600 - (int)Math.round(y));
			
			try {
				Thread.sleep(15);
			} 
			catch (Exception e) {
				// TODO Auto-generated catch block
			
			}
			
			gameboard.repaint();
		}

		
		
			
	}
	
	
	
	
	

}
