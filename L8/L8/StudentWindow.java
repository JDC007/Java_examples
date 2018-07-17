package L8;

import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.FileWriter;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;

public class StudentWindow implements ActionListener{

	private JFrame window;
	private JTextField id;
	private JTextField name;
	private JComboBox gender;
	private JComboBox department;
	private JButton submit;
	
	public StudentWindow(){
		window = new JFrame();
		window.setSize(300, 250);
		window.setLayout(new GridLayout(5, 2));
		
		id = new JTextField();
		name = new JTextField();
		
		gender = new JComboBox(new String [] {"Male", "Female"});
		department = new JComboBox(new String [] {"CSE", "BBA"});
		
		submit = new JButton("Submit");
		submit.addActionListener(this);
		
		window.add(new JLabel("ID"));
		window.add(id);
		window.add(new JLabel("Name"));
		window.add(name);
		window.add(new JLabel("Gender"));
		window.add(gender);
		window.add(new JLabel("Department"));
		window.add(department);
		window.add(new JLabel());
		window.add(submit);
		
		window.setVisible(true);
		window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	
	public void actionPerformed(ActionEvent e){
		if(e.getSource() == submit){
			try {
				String i = id.getText();
				String n = name.getText();
				String g = gender.getSelectedItem().toString();
				String d = department.getSelectedItem().toString();
				
				FileWriter f = new FileWriter("output.txt", true);
				f.write(i + "\n" + n + "\n" + g + "\n" + d + "\n");
				f.close();
				
				System.out.println("File write successful!");
			} catch (Exception ex) {
				System.out.println(ex.getMessage());
			}
		}
	}
	
	public static void main(String[] args) {
		new StudentWindow();
	}
}