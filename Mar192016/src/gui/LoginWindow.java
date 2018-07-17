package gui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.util.Scanner;


public class LoginWindow implements ActionListener { 

	JFrame window = new JFrame();
	
	JButton login = new JButton("Login");
	JButton cancel = new JButton("Cancel");
	
	JTextField username = new JTextField();
	JPasswordField password = new JPasswordField();
	
	public LoginWindow(){}
	
	public void initGUI(){
		
		JLabel userLabel = new JLabel("Username");
		JLabel passLabel = new JLabel("Password");
		
		GridLayout gl = new GridLayout(3,2,5,5);
		window.setLayout(gl);
		
		window.add(userLabel);
		window.add(username);
		
		window.add(passLabel);
		window.add(password);
		
		window.add(login);
		window.add(cancel);
		
		
		window.setTitle("Login Window");
		window.setSize(300,100);
		window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		login.addActionListener(this);
		cancel.addActionListener(this);
		
		window.setVisible(true);
		
		
		
	}
	
	public void actionPerformed(ActionEvent e){
		
		if(e.getSource() == login){
			
			//System.out.println("Username = " + username.getText() + "\n" + " Password " + password.getText());
			
			//JOptionPane.showMessageDialog(null, "Username = " + username.getText() + "\n" + " Password " + password.getText());
			
			boolean isFound = authentication();
			
			if(isFound == true)
				JOptionPane.showMessageDialog(null, "Login successful");
			else
				JOptionPane.showMessageDialog(null, "Login unsuccessful");
			
			
		}
		
		else if(e.getSource() == cancel){
			
			window.dispose();
		}
		
		
	}
	
	
	public boolean authentication(){
		
		try{
			
			File f = new File("password.txt");
			
			Scanner input = new Scanner(f);
			
			String u = username.getText();
			String p = password.getText();
			
			
			while(input.hasNextLine() == true){
				
				if(u.equals(input.nextLine()) == true && p.equals(input.nextLine()) == true)
					return true;
				
			}
			
			input.close();
		}
		
		
		catch(Exception e){
			
			System.out.println("File error");
		}
		
		
		return false;
		
		
	}
	
	
	
	
	
}
