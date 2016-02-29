package quizzes;

import java.util.ArrayList;

public class Question {
//	
//	quizId INT NOT NULL,
//	userId VARCHAR(255) NOT NULL,
//	questionId INT NOT NULL,
//	questionText VARCHAR(8000) NOT NULL,
//	correctAnswer VARCHAR(255) NOT NULL,
	private int quizId;
	private int questionId;
	private String questionText;
	private String correctAnswer;
	//private ArrayList<String> answers;
	
	public Question(int quiz_id, int question_id, String question_text, String correct_answer){
		this.quizId = quiz_id;
		this.questionId = question_id;
		this.questionText = question_text;
		this.questionText = correct_answer;
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

}
