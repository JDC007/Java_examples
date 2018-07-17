package codes;


import javax.swing.*;

import java.awt.*;
import java.awt.event.*;

public class GameBoard extends JPanel{

	
	
	int fighterCount = 1;
	
	
	public GameBoard(){
		
	}
	
	
	public void paint(Graphics g){
	
		super.paint(g);
		
		ImageIcon background = new ImageIcon("images//background.png");
		g.drawImage(background.getImage(),0,0,null);
		
		
		
		
		ImageIcon fighterPic = new ImageIcon("images//" + fighterCount  + ".png");
		g.drawImage(fighterPic.getImage(),200,200,null);
		
		
		
		++fighterCount;
		
		if(fighterCount == 4)
			fighterCount = 0;
		
		
	}

	public void startGame(){
		
		while(true){
			
			super.repaint();
		
		
			try{
				
				Thread.sleep(150);
				
			}
			catch(Exception e){}
		
		
		}
		
		
	}
		
	
	
}
