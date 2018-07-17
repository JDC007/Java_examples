package codes;


import javax.swing.*;

import java.awt.*;
import java.awt.event.*;

public class GameBoard extends JPanel implements KeyListener{

	
	
	int fighterCount = 0;
	static boolean isKicking = false;
	Fighter fighter;
	
	public GameBoard(){
		
		super.addKeyListener(this);
		super.setFocusable(true);
		fighter = new Fighter(200,200,null);
		
	}
	
	
	public void paint(Graphics g){
	
		super.paint(g);
		
		ImageIcon background = new ImageIcon("images//background.png");
		g.drawImage(background.getImage(),0,0,null);
		
		
		if(isKicking == false){
			fighter.setImagePath("images//stand//" + fighterCount  + ".png");
			fighterCount = ++fighterCount % 3;
		}
		
		
		fighter.draw(g);
	}

	public void startGame(){
		
		while(true){
			
			super.repaint();
		
		
			try{
				
				Thread.sleep(250);
				
			}
			catch(Exception e){}
		
		
		}
		
		
	}


	@Override
	public void keyPressed(KeyEvent e) {
		
		if(isKicking == false && e.getKeyCode() == e.VK_K){
			isKicking = true;
			KickMove km = new KickMove(this,fighter);
			km.start();
			
		}
		
		
		
	}


	@Override
	public void keyReleased(KeyEvent arg0) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void keyTyped(KeyEvent arg0) {
		// TODO Auto-generated method stub
		
	}
		
	
	
}
