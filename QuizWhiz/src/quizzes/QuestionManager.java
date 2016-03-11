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
	public String QuestionHTML(String type, String RawQuestion, String questionID, String quizID, int qNum){
		if(type.equals("QuestionResponse") || type.equals("MultipleChoice")){
			String qRHtml = poseRawQuestion(RawQuestion, qNum)+
					"<div class="+'"'+"answer"+'"'+">Answer:"+
					AnswerHTML(type,questionID, quizID)+
					"</div>";
			return qRHtml;
		}
		else if(type.equals("PictureResponse")){
			return pictureResponse(RawQuestion, qNum)+
					"<div class="+'"'+"answer"+'"'+">Answer:"+
					AnswerHTML(type,questionID, quizID)+
					"</div>";
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
			answerhtml = "<input type="+"\"text\" name=\""+questionID+"\"/>";
		}
		else if(type.equals("MultipleChoice")){
			ArrayList<String> choices = getAllAnswers(quizID, questionID);
			System.out.println(choices);
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
		String rawQHtml = "<p>"+qNum+". "+rawQ +"</p><br>";
		return rawQHtml;
	}
	
	private String pictureResponse(String rawQ, int qNum){
		String delims = "[|]+";
		String[] tokens = rawQ.split(delims);
		String prHtml = poseRawQuestion(tokens[0], qNum) + "\n"+
				"<img src=\""+tokens[1]+"\" alt=\"image not found!\" style=\"width:60%;height:30%;\"><br>";
		return prHtml;
	}
	private String fillIn(String infoToFill, String id, int qNum){
		String delims = "[|]+";
		String[] tokens = infoToFill.split(delims);
		String html = "<p>"+qNum+". ";
		for(int a = 0; a < tokens.length-1; a++){
			html+=tokens[a];
			String input = "<input type=\"text\" name=\""+id+"-"+a+"\"/>";
			System.out.println(input);
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
			System.out.println(query);
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()){ 
				String answer = rs.getString("answer");
				//System.out.println("ANSWER: " + answer);
				answers.add(answer);
			}
			return answers;
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return answers;
	}

}
