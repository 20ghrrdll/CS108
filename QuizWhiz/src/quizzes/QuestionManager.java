package quizzes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Random;

import main.DBConnector;
import main.MyDBInfo;

public class QuestionManager {
	private static Connection con;
	
	public QuestionManager(){
		con = DBConnector.getConnection();
	}
	
	public String QuestionHTML(String type, String RawQuestion, String questionID, String quizID, int qNum){
		if(type.equals("QuestionResponse") || type.equals("MultipleChoice")){
			String qRHtml = poseRawQuestion(RawQuestion, qNum) + AnswerHTML(type,questionID, quizID) + "<br><br>";
			return qRHtml;
		}
		else if(type.equals("PictureResponse")){
			return pictureResponse(RawQuestion, qNum) + AnswerHTML(type,questionID, quizID);
		}
		else if(type.equals("FillIn")){
			return fillIn(RawQuestion, questionID, qNum);
		} 
		else return type+" is not one of the types of questions I support!";
		
	}
	//input 
	private String AnswerHTML(String type, String questionID, String quizID){
		String answerhtml = "<h3>There is no question of this type!</h3>";
		if(type.equals("FillIn")){
			answerhtml =  "You should not be calling me!";
		}
		else if(type.equals("QuestionResponse")|| type.equals("PictureResponse")){
			answerhtml = "Answer: <input type=\"text\" name=\""+questionID+"\"/>";
		}
		else if(type.equals("MultipleChoice")){
			long seed = System.nanoTime();
			ArrayList<String> choices = getAllAnswers(quizID, questionID);
			Collections.shuffle(choices, new Random(seed));
			answerhtml = "";
			for(int a = 0; a < choices.size(); a++){
				String choice = choices.get(a);
				answerhtml += "<br><input type = \"radio\" name = \""+questionID+
						"\"  value=\""+choice+"\">"+" "+choice;
			}
			
		}
			
		return answerhtml;
	}
	
	private String poseRawQuestion(String rawQ, int qNum){
		String rawQHtml = "<b>"+qNum + ". " + rawQ +"</b><br>";
		return rawQHtml;
	}
	
	private String pictureResponse(String rawQ, int qNum){
		String delims = "[|]+";
		String[] tokens = rawQ.split(delims);
		String prHtml = poseRawQuestion(tokens[0], qNum) + "\n"+
				"<img src=\""+tokens[1]+"\" alt=\"image not found!\" style=\"width:60%;height:30%;margin:10px;\"><br>";
		return prHtml;
	}
	
	private String fillIn(String infoToFill, String id, int qNum){
		String delims = "[|]+";
		String[] tokens = infoToFill.split(delims);
		String html = "<p>"+qNum+". ";
		for(int a = 0; a < tokens.length-1; a++){
			html+=tokens[a];
			String input = "<input type=\"text\" name=\""+id+"-"+a+"\"/>";
			html+=input;
		}
		
		html +=tokens[tokens.length-1];
		if(infoToFill.charAt(infoToFill.length()-1) == '|')
			html+="<input type="+'"'+"text" +'"'+" name=\""+id+"-"+(tokens.length -1)+"\"/>";
		
		html+="</p><br>";
		return html;
	}
	
	public void closeConnection() {
		DBConnector.closeConnection();
	}
	
	
	public ArrayList<String> getAllAnswers(String quizID, String questionID){
		ArrayList<String> answers = new ArrayList<String>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT answer FROM " + MyDBInfo.ANSWERS_TABLE + " WHERE quizId=\"" + quizID + 
					"\" AND questionId = \""+questionID+"\";";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()){ 
				String answer = rs.getString("answer");
				answers.add(answer);
			}
			return answers;
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return answers;
	}
	
	public void updateQuestionRecordsTable(String userID, String response, boolean correct, boolean answered, int questionId, int quizId){
		String query = "INSERT INTO " + MyDBInfo.QUESTION_RECORDS_TABLE + " (quizId, questionId, userId, response, correct, answered)" + 
				" VALUES (?, ?, ?, ?, ?, ?)";

		try {
			PreparedStatement s = con.prepareStatement(query);
			s.setInt(1, quizId);
			s.setInt(2, questionId);
			s.setString(3, userID);
			s.setString(4, response);
			s.setBoolean(5, correct);
			s.setBoolean(6, answered);
			s.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		

}

}
