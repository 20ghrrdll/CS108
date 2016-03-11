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
		else if(userAnswer.compareToIgnoreCase(this.correctAnswer) == 0) correct = true;
		else if(this.correctAnswer.equals("go to question_answers")){
			ArrayList<String> possibleAnswers = manager.getAllAnswers(Integer.toString(this.quizId), Integer.toString(this.questionId));
			for(int a = 0; a < possibleAnswers.size(); a++){
				if(userAnswer.compareToIgnoreCase(possibleAnswers.get(a)) == 0){
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
	
	/*public ArrayList<Boolean> areCorrect(ArrayList<String> userAnswers, String userID, boolean practiceMode, QuestionManager manager){
		ArrayList<Boolean> results = new ArrayList<Boolean>(this.numAnswers);
		boolean answeredOne = true;
		boolean allTrue = true;
		
		for(int a = 0; a < this.numAnswers; a++){
			String userAnswer = userAnswers.get(a);
			System.out.println("The user answer is "+ userAnswer);
			System.out.println(this.correctAnswers);
			System.out.println(this.correctAnswers.get(a));
			if(userAnswer == null){
				userAnswers.set(a, "No Answer");
				answeredOne = false;
				results.add(false);
				allTrue = false;
			}
			else if(userAnswer.compareToIgnoreCase(this.correctAnswers.get(a)) == 0){
				results.add(true);
			}
			else{
				allTrue = false;
				results.add(false);
			}
		}
		
		if(!practiceMode){
			String UserResponsesList = ListResponses(userAnswers);
			manager.updateQuestionRecordsTable(userID, UserResponsesList, allTrue, answeredOne, this.questionId, this.quizId);
		}
		
		System.out.println("The results are "+ results);
		return results;

		
	}*/
	
	
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
