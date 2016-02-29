package quizzes;

import java.util.ArrayList;

public class Quiz {

	private int id;
	private String name, description, creator, type;
	private boolean practiceMode, multiplePages, random, immediateCorrection;
	private ArrayList<Question> questions;
	
	public Quiz(int id, String name, String description, String creator, 
				String type, boolean practiceMode, boolean multiplePages, 
				boolean random, boolean immediateCorrection) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.creator = creator;
		this.type = type;
		this.practiceMode = practiceMode;
		this.multiplePages = multiplePages;
		this.random = random;
		this.immediateCorrection = immediateCorrection;
	}

	
	public int getQuizID() {
		return id;
	}
	
	public String getQuizName() {
		return name;
	}
	
	public String getQuizDescription() {
		return description;
	}

	public String getQuizCreator() {
		return creator;
	}
	
	public String getQuizType() {
		return type;
	}
	
	public boolean hasPracticeMode() {
		return practiceMode;
	}
	
	public boolean displayMultiplePages() {
		return multiplePages;
	}
	
	public boolean randomOrder() {
		return random;
	}
	
	public boolean hasImmediateCorrection() {
		return immediateCorrection;
	}
}
