package quizzes;

import java.util.*;

public class MultiplePageQuiz {
	private static ArrayList<Question> questions;
	private static ArrayList<Question> questionsLeft;
	private static ArrayList<Boolean> isCorrect;
	private static HashMap<Integer, String> userAnswers;
	private long start_time;
	private int numQs;
	private String quizType;
	private	int currQuestionNum;
	private boolean immediateScoring;

	// assumes that question array has been called
	public MultiplePageQuiz() {
		
	}

	public void setQuestionList(ArrayList<Question> newQuestions, boolean random, boolean immediateGrading, String quizType) {
		start_time = System.currentTimeMillis();
		questionsLeft = newQuestions;
		userAnswers = new HashMap<Integer, String>(newQuestions.size());
		isCorrect = new ArrayList<Boolean>(newQuestions.size());
		if (random) {
			long seed = System.nanoTime();
			Collections.shuffle(questionsLeft, new Random(seed));
		}
		questions = (ArrayList<Question>)questionsLeft.clone();
		numQs = questions.size();
		this.quizType = quizType;
		currQuestionNum = 1;
		immediateScoring = immediateGrading;
	}

	public Question getQuestion() {
		Question toReturn = null;
		if(!questions.isEmpty()){
			toReturn = questionsLeft.get(0);
			questionsLeft.remove(0);
		}
		return toReturn;
	}
	
	public void addUserAnswer(int questionNum, String answer){
		if(userAnswers != null)
			userAnswers.put(questionNum, answer);
	}
	
	public long getStartTime(){
		return start_time;
	}
	
	public int getNumQuestions(){
		return numQs;
	}
	
	public int getScore(String userId, QuestionManager manager){
		boolean practiceMode = false;
		int score = 0;
		Set<Integer> questionsNums = userAnswers.keySet();
		for(int qNum: questionsNums){
			Question currQuestion = questions.get(qNum);
			String currAnswer = userAnswers.get(qNum);
			boolean correct = currQuestion.isCorrect(currAnswer, userId, practiceMode, manager);
			if(correct){
				score++;
				isCorrect.add(qNum, true);
			}
			else isCorrect.add(qNum, false);
			
		}
		return score;
	}
	
	
	public ArrayList<String> getUserAnswers(){
		ArrayList<String> answers = new ArrayList<String>(numQs);
		for(int a = 0; a < numQs; a++){
			String userAnswer = userAnswers.get(a);
			answers.add(userAnswer);
		}
		return answers;
	}
	
	public String getQuizType(){
		return quizType;
	}
	
	public int getCurrQuestionNum(){
		return currQuestionNum;
	}
	
	public void incrementCurrQuestionNum(){
		currQuestionNum++;
	}
	
	public ArrayList<Question> getAllQuestions(){
		return questions;
	}
	
	public ArrayList<Boolean> getIsCorrect(){
		return isCorrect;
	}
	
	public boolean getImmediateScoring(){
		return immediateScoring;
	}

}
