package quizzes;

public class Question {

	private int quizId;
	private int questionId;
	private String questionText;
	private String correctAnswer;
	private int order;
	
	public Question(int quiz_id, int question_id, String question_text, String correct_answer, int questionOrder){
		this.quizId = quiz_id;
		this.questionId = question_id;
		this.questionText = question_text;
		this.questionText = correct_answer;
		this.order = questionOrder;
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
	
	public int getOrder(){
		return this.order;
	}

}
