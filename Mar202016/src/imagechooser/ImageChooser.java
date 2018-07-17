package imagechooser; 

import javax.swing.*;
import java.awt.event.*;

public class ImageChooser extends JFrame implements ItemListener {
	
	String[] options = {"alcazar","tintin","calculus"};
	String[] imagePaths = {"images//alcazar.jpeg","images//tintin.png","images//calculus.png"};
	
	JComboBox combo = new JComboBox(options);
	JLabel imageLabel = new JLabel();
	
	
	public ImageChooser(){
		super();
	}
	
	public void initWindow(){
		
		
		super.setLayout(null);
		
		combo.setBounds(0,0,300,50);
		imageLabel.setBounds(0, 50, 300, 250);
		
		super.add(combo);
		super.add(imageLabel);
		
		combo.addItemListener(this);
		
		
	}
	

	public void itemStateChanged(ItemEvent e){
		
		int index = combo.getSelectedIndex();
		String path = imagePaths[index];
		
		ImageIcon icon = new ImageIcon(path);
		imageLabel.setIcon(icon);
		
	}
	
}
