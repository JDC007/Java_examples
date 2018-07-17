package login;

import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.util.Scanner;

import javax.swing.*;

public class Login extends JFrame implements ActionListener{

	private JTextField username;
	private JPasswordField password;
	private JButton btn;
	private Credential [] credentials;
	
	public Login(){
		setLayout(new GridLayout(3, 2, 4, 4));
		
		JLabel uL = new JLabel("Username");
		JLabel pL = new JLabel("Password");
		
		username = new JTextField();
		password = new JPasswordField();
		
		btn = new JButton("Login");
		btn.addActionListener(this);
		
		add(uL);
		add(username);
		add(pL);
		add(password);
		add(new JLabel());
		add(btn);
		
		setVisible(true);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setLocationRelativeTo(null);
		pack();
		
		initCredentials("credentials.txt");
	}
	
	public void initCredentials(String path){
		try {
			credentials = new Credential [10];
			File f = new File(path);
			Scanner s = new Scanner(f);
			int index = 0;
			
			while(s.hasNextLine()){
				String u = s.nextLine();
				String p = s.nextLine();
				Credential c = new Credential(u, p);
				credentials[index] = c;
				index++;
			}
			
			s.close();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public Credential searchCredential(String uName){
		Credential c = null;
		
		for(int i = 0; i < credentials.length; i++){
			if(credentials[i] != null && credentials[i].getUsername().equals(uName)){
				c = credentials[i];
				break;
			}
		}
		
		return c;
	}
	
	public void actionPerformed(ActionEvent e) {
		if(e.getSource() == btn){
			String u = username.getText();
			String p = new String(password.getPassword());
			
			Credential c = searchCredential(u);
			
			if(c == null){
				JOptionPane.showMessageDialog(null, "Invalid credential");
			}
			
			else{
				if(c.getPassword().equals(p)){
					JOptionPane.showMessageDialog(null, "Login Success");
					AnotherWindow a = new AnotherWindow();
					dispose();
				}
				
				else{
					JOptionPane.showMessageDialog(null, "Invalid credential");
				}
			}
		}
		
	}
	
	public static void main (String [] args){
		Login l = new Login();
	}
}