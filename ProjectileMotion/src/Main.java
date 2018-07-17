import javax.swing.*;

public class Main {

	public static void main(String[] args) {
		
		GameBoard gb = new GameBoard();
		
		JFrame window = new JFrame();
		window.add(gb);
		window.setSize(1200,600);
		window.setLocation(250,15);
		window.setTitle("Space Invaderz");
		window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		window.setVisible(true);
		
		
		
		
	}

}
