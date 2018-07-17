package codes;
import javax.swing.*;

public class Main {

	public static void main(String[] args) {
		
		GameBoard gb = new GameBoard();
		
		JFrame window = new JFrame();
		window.add(gb);
		
		window.setSize(800,600);
		window.setLocation(250,15);
		window.setTitle("Character Animater");
		window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		window.setVisible(true);
		
		gb.startGame();
		
		
	}

}
