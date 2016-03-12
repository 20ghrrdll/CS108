package quizzes;

import java.util.*;


public class Question {

	private int quizId;
	private int questionId;
	private String questionText;
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
	
	public ArrayList<String> getCorrectAnswers() {
		return correctAnswers;
	}
	
	public boolean isCorrect(String userAnswer, String userID, boolean practiceMode,  QuestionManager manager){
		boolean correct = false;
		boolean answered = true;
		if(userAnswer == null) answered = false;
		else if(userAnswer.trim().compareToIgnoreCase(this.correctAnswer) == 0) correct = true;
		else if(this.correctAnswer.equals("go to question_answers")){
			ArrayList<String> possibleAnswers = manager.getAllAnswers(Integer.toString(this.quizId), Integer.toString(this.questionId));
			for(int a = 0; a < possibleAnswers.size(); a++){
				if(userAnswer.trim().compareToIgnoreCase(possibleAnswers.get(a).trim()) == 0){
					correct = true;
					break;
				}	
			}
		}
		
		/*quizId INT NOT NULL,
		questionId INT NOT NULL,
		userId VARCHAR(255) NOT NULL,
		response TEXT,
		correct BOOLEAN,
		answered BOOLEAN*/
		if(practiceMode){
			manager.updateQuestionRecordsTable(userID, userAnswer, correct, answered, this.questionId, this.quizId);
		}
		
		return correct;
	}
	
	
	public ArrayList<Boolean> areCorrect(ArrayList<String> userAnswers, String userID, boolean practiceMode, QuestionManager manager){
		ArrayList<Boolean> results = new ArrayList<Boolean>(1);
		results.add(isCorrect(userAnswers.get(0), userID, practiceMode, manager));
		return results;
		
		
	}
	
	public ArrayList<String> potentialAnswers(QuestionManager manager){
		ArrayList<String> possibleAnswers = manager.getAllAnswers(Integer.toString(this.quizId), Integer.toString(this.questionId));
		return possibleAnswers;
	}

	
	private String ListResponses(ArrayList<String> userResponses){
		String CommaSeparatedResponses = "";
		if(userResponses.size() == 1) return userResponses.get(0);
		else{
			for(int a = 0; a < userResponses.size() - 1; a++){
				CommaSeparatedResponses += userResponses.get(a) + ", ";
			}
			CommaSeparatedResponses += userResponses.get(userResponses.size() -1);
		}
		return CommaSeparatedResponses;
	}
	
	

}
