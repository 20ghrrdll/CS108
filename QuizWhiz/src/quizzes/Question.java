package quizzes;

public class Question {

	private int quizId;
	private int questionId;
	private String questionText;
	private String correctAnswer;
	private int order;
	
	public Question(int quiz_id, int question_id, String question_text, String correct_answer){
		this.quizId = quiz_id;
		this.questionId = question_id;
		this.questionText = question_text;
		this.correctAnswer = correct_answer;
	}
	
	public String getQuestionText(){
		return this.questionText;
	}
	
	public String getCorrectAnswer(){
		return this.correctAnswer;
	}
	
	public int getQuizId(){
		return this.quizId;
	}
	
	public int getQuestionId(){
		return this.questionId;
	}
	
	//Will have to do some wiggling to figure out how to handle questions w/ multiple parts...
	public boolean isCorrect(String response){
		if(response.equals(this.correctAnswer)) return true;
		return false;
	}

}
