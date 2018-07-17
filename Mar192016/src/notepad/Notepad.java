package notepad;

import javax.swing.*;
import java.awt.event.*;
import java.io.*;
import java.util.Scanner;

public class Notepad extends JFrame implements ActionListener {

	JMenuItem clear = new JMenuItem("Clear");
	JMenuItem open = new JMenuItem("Open");
	JMenuItem save = new JMenuItem("Save");
	
	JTextArea pad = new JTextArea();
	
	public Notepad(){
		
		super();
	}
	
	
	public void initWindow(){
		
		JMenuBar bar = new JMenuBar();
		
		JMenu file = new JMenu("File");
		
		
		clear.addActionListener(this);
		save.addActionListener(this);
		open.addActionListener(this);
		
		super.setJMenuBar(bar);
		bar.add(file);
		file.add(clear);
		file.add(open);
		file.add(save);
		
		super.add(pad);
	}
	
	public void actionPerformed(ActionEvent e){
		
		if(e.getSource() == clear){
			pad.setText(null);
		}
		
		else if(e.getSource() == save){
			
			JFileChooser jfc = new JFileChooser();
			jfc.showSaveDialog(null);
			File f = jfc.getSelectedFile();
			
			try{
				
				FileWriter fw = new FileWriter(f);
				fw.write(pad.getText());
				fw.close();
			}
			catch(Exception ex){
				
			}
			
		}
		
		else if(e.getSource() == open){
			
			pad.setText(null);
			JFileChooser jfc = new JFileChooser();
			jfc.showOpenDialog(null);
			File f = jfc.getSelectedFile();
			
			try{
				
				Scanner input = new Scanner(f);
				
				while(input.hasNextLine() == true){
					
					String line = input.nextLine();
					pad.append(line + "\n");
					
				}
				
				input.close();
			}
			
			catch(Exception ex){}
			
			
		}
		
		
		
	}
	
	
}
