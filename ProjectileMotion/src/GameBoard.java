

import javax.swing.*;

import java.awt.*;
import java.awt.event.*;

public class GameBoard extends JPanel implements KeyListener{

	
	Cannon ship;
	Bullet[] bullets = new Bullet[14];
	int bulletCount = 0;
	
	public GameBoard(){
		
		
		ship = new Cannon(0,510,"images//cannon.png");
		
		int xGhost = 5, yGhost = 5;
		
		for(int i = 0; i < bullets.length; i++){
			
			
			bullets[i] = new Bullet(-20,-20,"images//ball.png");
		}
		
		
		super.addKeyListener(this);
		super.setFocusable(true);
		
		
		
		
	}
	
	
	public void paint(Graphics g){
	
		super.paint(g);
		
		ImageIcon background = new ImageIcon("images//background.png");
		g.drawImage(background.getImage(),0,0,null);
		
		ship.draw(g);
		
		for(int i = 0; i < bullets.length; i++){
			
			bullets[i].draw(g);
			
		}
		
		
	}


	@Override
	public void keyPressed(KeyEvent e) {
		
		
		if(e.getKeyCode() == e.VK_UP){
			
			bullets[bulletCount].setX(0); 	
			bullets[bulletCount].setY(490);
			
			repaint();
			
			BulletFiring bulletFire = new BulletFiring(this,bullets[bulletCount]);
			bulletFire.start();
			
			bulletCount++;
			
			if(bulletCount == 13)
				bulletCount = 0;
		}
		
		
		super.repaint();
	}


	@Override
	public void keyReleased(KeyEvent e) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void keyTyped(KeyEvent e) {
		// TODO Auto-generated method stub
		
	}
	
	
	
}
