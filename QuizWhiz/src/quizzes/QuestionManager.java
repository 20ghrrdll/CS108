package quizzes;

public class QuestionManager {
	
	public QuestionManager(){
		
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
			return "You should not be calling me!";
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
			html+="<input type="+'"'+"text" +'"'+" name="+'"'+id+'"'+"_"+a+"/>";
		}
		
		html +=tokens[tokens.length-1];
		if(infoToFill.charAt(infoToFill.length()-1) == '|')
			html+="<input type="+'"'+"text" +'"'+" name="+'"'+id+'"'+"_"+(tokens.length -1)+"/>";
		
		html+="</p><br>";
		System.out.println(html);
		return html;
	}

}
