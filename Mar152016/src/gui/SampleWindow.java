package gui;

import javax.swing.*;

public class SampleWindow {

	public static void main(String[] args) {
		
		JFrame window = new JFrame();
		window.setTitle("Demo Window");
		window.setSize(300, 100);
		window.setLocation(300,300);
		window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		window.setVisible(true);
		
	}

}
