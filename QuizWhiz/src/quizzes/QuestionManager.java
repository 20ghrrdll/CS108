package quizzes;

public class QuestionManager {
	
	public QuestionManager(){
	}
	
	public String QuestionHTML(String type, String RawQuestion){
		String questionhtml = "<h3>This is the question</h3>";
		if(type.equals("FillIn")){
			return fillIn(RawQuestion);
		}
		return questionhtml;
	}
	
	public String AnswerHTML(String type){
		String answerhtml = "<h3>There is no question of this type!</h3>";
		if(type.equals("FillIn")){
			return "";
		}
		else if(type.equals("QuestionResponse")){
			answerhtml = QR();
		}
			
		return answerhtml;
	}
	
	private String QR(){
		//<input type="text" name="answer" />
		return null;
	}
	
	private String fillIn(String infoToFill){
		return null;
	}

}
