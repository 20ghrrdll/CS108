package quizzes;

import java.util.*;

public class Question {

	private int quizId;
	private int questionId;
 String questionText;
	private String correctAnswer;
	private int numAnswers;
	private ArrayList<String> correctAnswers;
	
	public Question(int quiz_id, int question_id, String question_text, String correct_answer, int num_answers, ArrayList<String> correct_answers){
		this.quizId = quiz_id;
		this.questionId = question_id;
		this.questionText = question_text;
		this.correctAnswer = correct_answer;
		this.numAnswers = num_answers;
		this.correctAnswers = correct_answers;
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
	
	public int getNumAnswers(){
		return this.numAnswers;
	}
	
	//Will have to do some wiggling to figure out how to handle questions w/ multiple parts...
	public boolean isCorrect(String response){
		System.out.println("the user response is " + response);
		System.out.println("the correct answer is " + this.correctAnswer);
		if(response.equals(this.correctAnswer)) return true;
		return false;
	}
	
	public ArrayList<Boolean> areCorrect(ArrayList<String> userAnswers){
		ArrayList<Boolean> results = new ArrayList<Boolean>(this.numAnswers);
		for(int a = 0; a < this.numAnswers; a++){
			String userAnswer = userAnswers.get(a);
			if(userAnswer.equals(this.correctAnswers.get(a))){
				results.add(true);
			}
			else results.add(false);
		}
		return results;
		
	}

}
