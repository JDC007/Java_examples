package notepad;

import javax.swing.JFrame;

public class Main {
	
	public static void main(String[]args){
		
		Notepad np = new Notepad();
		np.setTitle("Notepad");
		np.setSize(500,500);
		np.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		np.initWindow();
		np.setVisible(true);
		
	}

}
