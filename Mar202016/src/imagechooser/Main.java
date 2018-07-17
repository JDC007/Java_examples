package imagechooser;

import javax.swing.JFrame;

public class Main {

	public static void main(String[] args) {
		
		ImageChooser ic = new ImageChooser();
		ic.setTitle("Image Chooser");
		ic.setSize(300,300);
		ic.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		ic.initWindow();
		ic.setVisible(true);
		
		
	}

}
