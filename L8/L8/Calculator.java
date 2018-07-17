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

public class Calculator implements ActionListener{

	private JFrame window;
	private JTextField inp1;
	private JTextField inp2;
	private JTextField result;
	private JButton addition;
	private JButton substraction;
	private JButton multiplication;
	private JButton division;
	
	public Calculator(){
		window = new JFrame();
		window.setSize(300, 250);
		window.setLayout(new GridLayout(5, 2));
		
		inp1 = new JTextField("Input 1");
		inp2 = new JTextField("Input 2");
		result = new JTextField("Result");
		
		addition = new JButton("+");
		addition.addActionListener(this);
		
		substraction = new JButton("-");
		substraction.addActionListener(this);
		
		multiplication = new JButton("X");
		multiplication.addActionListener(this);
		
		division = new JButton("/");
		division.addActionListener(this);
		
		window.add(new JLabel());
		window.add(result);
		window.add(inp1);
		window.add(inp2);
		window.add(addition);
		window.add(substraction);
		window.add(multiplication);
		window.add(division);
		window.setVisible(true);
		window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	
	public void actionPerformed(ActionEvent e){
		if(e.getSource() == addition){
			double i1 = Double.parseDouble(inp1.getText());
			double i2 = Double.parseDouble(inp2.getText());
			double r = i1 + i2;
			result.setText(r + "");
		}
		
		else if(e.getSource() == substraction){
			double i1 = Double.parseDouble(inp1.getText());
			double i2 = Double.parseDouble(inp2.getText());
			double r = i1 - i2;
			result.setText(r + "");
		}
		
		else if(e.getSource() == multiplication){
			double i1 = Double.parseDouble(inp1.getText());
			double i2 = Double.parseDouble(inp2.getText());
			double r = i1 * i2;
			result.setText(r + "");
		}
		
		else if(e.getSource() == division){
			double i1 = Double.parseDouble(inp1.getText());
			double i2 = Double.parseDouble(inp2.getText());
			double r = i1 / i2;
			result.setText(r + "");
		}
	}
		
	public static void main(String[] args) {
		new Calculator();
	}
}