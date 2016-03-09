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
		System.out.println("I am printing the question html now!");
		if(type.equals("FillIn")){
			return fillIn(RawQuestion, id);
		}
		else if(type.equals("QuestionResponse")){
			String qRHtml = "<p>"+RawQuestion +"</p><br>"+'\n'+
					"<div class="+'"'+"answer"+'"'+">Answer:"+
					AnswerHTML(type,id)+
					"</div>";
			System.out.println(qRHtml);
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
		String html = "<input type="+'"'+"text" +'"'+" name="+'"'+id+'"'+" />";
		System.out.println(html);
		return html;
	}
	
	private String fillIn(String infoToFill, String id){
		String delims = "[|]+";
		String[] tokens = infoToFill.split(delims);
		String html = "<p>";
		for(int a = 0; a < tokens.length-1; a++){
			html+=tokens[a];
			html+="<input type="+'"'+"text" +'"'+" name="+'"'+id+'"'+"-"+a+"/>";
		}
		
		html +=tokens[tokens.length-1];
		if(infoToFill.charAt(infoToFill.length()-1) == '|')
			html+="<input type="+'"'+"text" +'"'+" name="+'"'+id+'"'+"-"+(tokens.length -1)+"/>";
		
		html+="</p><br>";
		System.out.println(html);
		return html;
	}
	
	
	ArrayList<String> getAllAnswers(String quizID, String questionID){
		ArrayList<String> answers = new ArrayList<String>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.ANSWERS_TABLE + " WHERE quizId=\"" + quizID + 
					"\" AND questionId = \""+questionID+"\";";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				String answer = rs.getString("answer");
				answers.add(answer);
			}
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return answers;
	}

}
