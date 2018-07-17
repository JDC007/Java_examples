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

public class BMI implements ActionListener{

	private JFrame window;
	private JTextField weight;
	private JTextField height;
	private JTextField bmi;
	private JComboBox heightIn;
	private JButton calculate;
	
	public BMI(){
		window = new JFrame();
		window.setSize(300, 250);
		window.setLayout(new GridLayout(5, 2));
		
		weight = new JTextField();
		height = new JTextField();
		bmi = new JTextField();
		
		heightIn = new JComboBox(new String [] {"Meter", "Inch"});
		
		calculate = new JButton("Calculate");
		calculate.addActionListener(this);
		
		window.add(new JLabel("Weight"));
		window.add(weight);
		window.add(new JLabel("Height in"));
		window.add(heightIn);
		window.add(new JLabel("Height"));
		window.add(height);
		window.add(new JLabel("BMI"));
		window.add(bmi);
		window.add(new JLabel());
		window.add(calculate);
		
		window.setVisible(true);
		window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	
	public void actionPerformed(ActionEvent e){
		if(e.getSource() == calculate){
			double h = Double.parseDouble(height.getText());
			double w = Double.parseDouble(weight.getText());
			String hin = heightIn.getSelectedItem().toString();
			
			if(hin.equals("Inch")){
				h *= 0.0254;
			}
			
			double b = w / (h * h);
			bmi.setText(b + "");
		}
	}
		
	public static void main(String[] args) {
		new BMI();
	}
}