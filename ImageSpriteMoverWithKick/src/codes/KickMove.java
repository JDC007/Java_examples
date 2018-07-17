package codes;

public class KickMove extends Thread {
	
	private GameBoard gb;
	private Fighter fighter;
	
	public KickMove(GameBoard gb, Fighter fighter) {
		this.gb = gb;
		this.fighter = fighter;
	}
	
	public void run(){
		
		for(int i = 0; i < 5; i++){
			
			fighter.setImagePath("images//kick//" + i + ".png");
			
			try{
				
				Thread.sleep(250);
			}
			
			catch(Exception e){}
			
			
			gb.repaint();
		}
		
		gb.isKicking = false;
		
		
	}
	

}
