package main;

import java.util.HashMap;
import java.util.Map;
import users.Achievement;

public class FinalConstants {

	public static final String CREATE_1 = "CREATE_1";
	public static final String CREATE_5 = "CREATE_5";
	public static final String CREATE_10 = "CREATE_10";
	public static final String TOOK_1 = "TOOK_1";
	public static final String TOOK_10 = "TOOK_10";
	public static final String HIGHEST_SCORE = "HIGHEST_SCORE";
	public static final String PRACTICER = "PRACTICER";
	public static final String FRIENDS_10 = "FRIENDS_10";
	public static final String CHALLENGER = "CHALLENGER";
	public static final String PERFECT_SCORE = "PERFECT_SCORE";
	
	public static final Map<String, Achievement> ACHIEVEMENTS;
	static {
		ACHIEVEMENTS = new HashMap<String, Achievement>();
		ACHIEVEMENTS.put(CREATE_1, new Achievement("Amateur Author", "/achievement-icons/compose-icon.png", "Created a quiz.")); //TODO: add imageUrls
		ACHIEVEMENTS.put(CREATE_5, new Achievement("Prolific Author", "/achievement-icons/booklet-icon.png", "Created 5 quizzes."));
		ACHIEVEMENTS.put(CREATE_10, new Achievement("Prodigious Author", "/achievement-icons/bookshelf-icon.png", "Created 10 quizzes."));
		ACHIEVEMENTS.put(TOOK_1, new Achievement("Beginning Quizzee", "/achievement-icons/pencil-icon.png", "Took a quiz."));
		ACHIEVEMENTS.put(TOOK_10, new Achievement("Quiz Machine", "/achievement-icons/compose-icon.png", "Took 10 quizzes."));
		ACHIEVEMENTS.put(HIGHEST_SCORE, new Achievement("I am the Greatest", "/achievement-icons/trophy-icon.png", "Had the highest score on a quiz."));
		ACHIEVEMENTS.put(PRACTICER, new Achievement("Practice Makes Perfect", "/achievement-icons/magic-wand-icon.png", "Took a quiz in practice mode."));
		ACHIEVEMENTS.put(FRIENDS_10, new Achievement("Social Butterfly", "/achievement-icons/chat-icon.png", "Has 10+ friends."));
		ACHIEVEMENTS.put(CHALLENGER, new Achievement("Challenger", "/achievement-icons/racing-flags-icon.png", "Challenged someone to take a quiz."));
		ACHIEVEMENTS.put(PERFECT_SCORE, new Achievement("The Next Einstein", "/achievement-icons/brightness-icon.png", "Achieved a perfect score on a quiz."));
	}
	
}
