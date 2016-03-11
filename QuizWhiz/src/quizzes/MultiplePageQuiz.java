package quizzes;

import java.util.*;

public class MultiplePageQuiz {
	private static ArrayList<Question> questions;
	private static HashMap<String, String> userAnswers;
	private long start_time;

	// assumes that question array has been called
	public MultiplePageQuiz() {
		
	}

	public void setQuestionList(ArrayList<Question> newQuestions, boolean random) {
		start_time = System.currentTimeMillis();
		questions = newQuestions;
		userAnswers = new HashMap<String, String>(questions.size());
		if (random) {
			long seed = System.nanoTime();
			Collections.shuffle(questions, new Random(seed));
		}
	}

	public Question getQuestion() {
		Question toReturn = null;
		if(!questions.isEmpty()){
			toReturn = questions.get(0);
			questions.remove(0);
		}
		return toReturn;
	}
	
	public void addUserAnswer(String questionId, String answer){
		userAnswers.put(questionId, answer);
	}
	
	public long getStartTime(){
		return start_time;
	}

}
