package quizzes;

public class QuestionManager {
	
	public QuestionManager(){
		
	}
	
	//String questionhtml = "<h3>This is the question</h3>";	
	public String QuestionHTML(String type, String RawQuestion){
		System.out.println("I am printing the question html now!");
		if(type.equals("FillIn")){
			return fillIn(RawQuestion);
		}
		else if(type.equals("QuestionResponse")){
			return "<h3>" + RawQuestion + "</h3>";
		}
		else return "<h3>"+type +" has not been handled yet</h3>";
		
	}
	//input 
	public String AnswerHTML(String type, String id){
		String answerhtml = "<h3>There is no question of this type!</h3>";
		if(type.equals("FillIn")){
			return "";
		}
		else if(type.equals("QuestionResponse")){
			answerhtml = QRAnswer(id);
		}
			
		return answerhtml;
	}
	
	private String QRAnswer(String id){
		String html = "<input type="+'"'+"text" +"name="+'"'+id+'"'+" />";
		return html;
	}
	
	private String fillIn(String infoToFill){
		return null;
	}

}
