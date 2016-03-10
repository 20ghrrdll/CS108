package quizzes;

import java.util.ArrayList;
import java.sql.Timestamp;

public class Quiz {

	private int id;
	private String name, description, creator;
	private QuizType type;
	private boolean practiceMode, multiplePages, random, immediateCorrection;
	private Timestamp timeCreated;

	public Quiz(int id, String name, String description, Timestamp timeCreated, String creator, 
			QuizType type, boolean practiceMode, boolean multiplePages, 
			boolean random, boolean immediateCorrection) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.timeCreated = timeCreated;
		this.creator = creator;
		this.type = type;
		this.practiceMode = practiceMode;
		this.multiplePages = multiplePages;
		this.random = random;
		this.immediateCorrection = immediateCorrection;
	}

	public Quiz(String name, String description, Timestamp timeCreated, String creator, 
			QuizType type, boolean practiceMode, boolean multiplePages, 
			boolean random, boolean immediateCorrection) {
		this.name = name;
		this.description = description;
		this.timeCreated = timeCreated;
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

	public QuizType getQuizType() {
		return type;
	}

	public Timestamp getTimeCreated() {
		return timeCreated;
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
