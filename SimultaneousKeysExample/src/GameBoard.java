


import javax.swing.*;

import java.awt.*;
import java.awt.event.*;

public class GameBoard extends JPanel implements KeyListener{

	Bird redBird = new Bird(0,0,"images//red.png");
	Bird whiteBird = new Bird(0,510,"images//white.png");
	boolean rightKeyPressed = false, leftKeyPressed = false, DKeyPressed = false, AKeyPressed = false;
	
	public GameBoard(){
	
		super.setFocusable(true);
		super.addKeyListener(this);
				
	}
	
	
	public void paint(Graphics g){
	
		super.paint(g);
		
		ImageIcon background = new ImageIcon("images//background.png");
		g.drawImage(background.getImage(),0,0,null);
		
		redBird.draw(g);
		whiteBird.draw(g);
		
		
		
	}

	
		
		
	


	@Override
	public void keyPressed(KeyEvent e) {
		
		if(this.DKeyPressed== false && e.getKeyCode() == e.VK_D){
			this.DKeyPressed = true;
			if(redBird.getX() < 800)
				   redBird.setX(redBird.getX() + 15);
		}
		
		else if(this.rightKeyPressed== false && e.getKeyCode() == e.VK_RIGHT){
			this.rightKeyPressed = true;
			if(whiteBird.getX() < 800)
				   whiteBird.setX(whiteBird.getX() + 15);
		}
		
		
		else if(this.AKeyPressed== false && e.getKeyCode() == e.VK_A){
			this.AKeyPressed = true;
			if(redBird.getX() > 0 )
				   redBird.setX(redBird.getX() - 15);
		}
		
		else if(this.leftKeyPressed== false && e.getKeyCode() == e.VK_LEFT){
			this.leftKeyPressed = true;
			if(whiteBird.getX() > 0)
				   whiteBird.setX(whiteBird.getX() - 15);
		}

		
		
		
		super.repaint();
		
	}


	@Override
	public void keyReleased(KeyEvent e) {
		
		if(e.getKeyCode() == e.VK_D)
			this.DKeyPressed = false;
		
		if(e.getKeyCode() == e.VK_RIGHT)
			this.rightKeyPressed = false;
		
		if(e.getKeyCode() == e.VK_A)
			this.AKeyPressed = false;
		
		if(e.getKeyCode() == e.VK_LEFT)
			this.leftKeyPressed = false;
		
	}


	@Override
	public void keyTyped(KeyEvent e) {
		// TODO Auto-generated method stub
		
	}
		
	

}
