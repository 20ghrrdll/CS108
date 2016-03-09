package quizzes;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import main.DBConnector;
import main.MyDBInfo;

public class QuestionManager {
	private static Connection con;
	
	public QuestionManager(){
		con = DBConnector.getConnection();
	}
	
	//String questionhtml = "<h3>This is the question</h3>";	
	public String QuestionHTML(String type, String RawQuestion, String id){
		if(type.equals("FillIn")){
			return fillIn(RawQuestion, id);
		}
		else if(type.equals("QuestionResponse")){
			String qRHtml = "<p>"+RawQuestion +"</p><br>"+'\n'+
					"<div class="+'"'+"answer"+'"'+">Answer:"+
					AnswerHTML(type,id)+
					"</div>";
			return qRHtml;
		}
		else return fillIn(RawQuestion, id);
		
	}
	//input 
	private String AnswerHTML(String type, String id){
		String answerhtml = "<h3>There is no question of this type!</h3>";
		if(type.equals("FillIn")){
			answerhtml =  "You should not be calling me!";
		}
		else if(type.equals("QuestionResponse")){
			answerhtml = QRAnswer(id);
		}
			
		return answerhtml;
	}
	
	private String QRAnswer(String id){
		String html = "<input type="+"\"text\" name=\""+id+"\"/>";
		return html;
	}
	
	private String fillIn(String infoToFill, String id){
		String delims = "[|]+";
		String[] tokens = infoToFill.split(delims);
		String html = "<p>";
		for(int a = 0; a < tokens.length-1; a++){
			html+=tokens[a];
			String input = "<input type=\"text\" name=\""+id+"-"+a+"\"/>";
			System.out.println(input);
			html+=input;
		}
		
		html +=tokens[tokens.length-1];
		if(infoToFill.charAt(infoToFill.length()-1) == '|')
			html+="<input type="+'"'+"text" +'"'+" name="+'"'+id+'"'+"-"+(tokens.length -1)+"/>";
		
		html+="</p><br>";
		return html;
	}
	
	
	ArrayList<String> getAllAnswers(String quizID, String questionID){
		ArrayList<String> answers = new ArrayList<String>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT answer FROM " + MyDBInfo.ANSWERS_TABLE + " WHERE quizId=\"" + quizID + 
					"\" AND questionId = \""+questionID+"\";";
			System.out.println(query);
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				System.out.println("There is a next!");
				String answer = rs.getString("answer");
				System.out.println(answer);
				answers.add(answer);
			}
			return answers;
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return answers;
	}

}
