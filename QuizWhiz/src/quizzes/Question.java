package quizzes;

public interface Question {

	/**
	 * @return The text for a question
	 */
	public String getQuestion();
	
	
	/**
	 * @return One of the answers
	 */
	public String getAnswer();
	
	
	/**
	 * Checks whether the user's answer matches one of the correct answers
	 * @param what the user has typed in as the potential answer
	 * @return true if the user's answer matches one of the correct answers
	 */
	public boolean checkAnswer(String input);
	
}
