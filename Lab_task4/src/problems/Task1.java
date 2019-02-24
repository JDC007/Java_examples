package problems;

public class Task1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		//compare two strings
		String str = "Hello People";
		String anotherString = "hello people";
		Object objStr = str;

		System.out.println("str.compareTo(anotherString): "+ str.compareTo(anotherString) );
		System.out.println("str.compareToIgnoreCase(anotherString): "+

		str.compareToIgnoreCase(anotherString));
		System.out.println("str.compareTo(objStr.toString()): "+str.compareTo(objStr.toString()));

		String s1 = "leo_messi";
		String s2 = "leo_messi";
		String s3 = new String ("Lionel Andrés Messi");
		System.out.println("s1.equals(s2): "+s1.equals(s2));
		System.out.println("s2.equals(s3): "+s2.equals(s3));
		System.out.println("s1 == s2: "+ (s1 == s2));
		System.out.println("s2 == s3: "+ (s2 == s3));
		//search the last position of a substring
		int lastIndex = s3.lastIndexOf("Messi");
		if(lastIndex == - 1){
		System.out.println("Messi not found");
		}else {
		System.out.println("Last occurrence of Messi is at index "+ lastIndex);
		}
		//replace a substring inside a string by another one
		String st = "May Argentina fall tonight!!";
		System.out.println( st.replace( "fall" ,"WIN" ) );
		//convert a string totally into upper case
		System.out.println("String changed to upper case: " + st.toUpperCase());
		//String length
		System.out.println("String length: " + st.length());
		//Concatenation
		s1 = s1+" is a good player. ";
		s1 = s1.concat("His full name is: ");
		s1 = s1.concat(s3);
		System.out.println("String s1 becomes: " + s1);
		//To know the character in particular index of the String
		System.out.println("String s1 becomes: " + s3.charAt(14));

	}

}
