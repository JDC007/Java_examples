package gui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class LoginWindow implements ActionListener {

	JButton login = new JButton("Login");
	JButton cancel = new JButton("Cancel");
	
	JTextField username = new JTextField();
	JPasswordField password = new JPasswordField();
	
	JFrame window = new JFrame();
	
	public LoginWindow(){}
	
	public void initWindow(){
		
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
		window.setSize(300 ,100);
		window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		login.addActionListener(this);
		cancel.addActionListener(this);
		
		window.setVisible(true);
		
	}
	
	public void actionPerformed(ActionEvent e){
		
		if(e.getSource() == login){
			
			//System.out.print("Username = " + username.getText() + "\n");
			//System.out.print("Password = " + password.getText());
			
			JOptionPane.showMessageDialog(null, "Username = " + username.getText() + "\n" + "Password = " + password.getText() );
			
		}
		
		else if(e.getSource() == cancel){
			
			window.dispose();
		}
		
	}
	
	
	
}
