package main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import users.Achievement;

public class FinalConstants {

	public static final String ERROR_MSG = "An error has occurred. Please try again.";
	
	public static int MAX_RATING = 5;
	
	
	/* Categories */
	public static final String[] CATEGORIES = { "ARTS", "CHEESES", "EDUCATION", "FUN", "LANGUAGE", "MISC", "NATURE", "NEWS", "POP_CULTURE", "SPORTS", "UNCATEGORIZED" };
	public static final HashMap<String, String> CATEGORIES_PLAINTEXT;
	static {
		CATEGORIES_PLAINTEXT = new HashMap<String, String>();
		CATEGORIES_PLAINTEXT.put("ARTS", "Arts");
		CATEGORIES_PLAINTEXT.put("CHEESES", "Cheeses");
		CATEGORIES_PLAINTEXT.put("EDUCATION", "Education");
		CATEGORIES_PLAINTEXT.put("FUN", "Fun");
		CATEGORIES_PLAINTEXT.put("LANGUAGE", "Language");
		CATEGORIES_PLAINTEXT.put("MISC", "Miscellaneous");
		CATEGORIES_PLAINTEXT.put("NATURE", "Nature");
		CATEGORIES_PLAINTEXT.put("NEWS", "News");
		CATEGORIES_PLAINTEXT.put("POP_CULTURE", "Popular Culture");
		CATEGORIES_PLAINTEXT.put("SPORTS", "Sports");
		CATEGORIES_PLAINTEXT.put("UNCATEGORIZED", "Uncategorized");
	}
	
	
	/* Achievements */
	public static final String CREATE_1 = "CREATE_1";
	public static final String CREATE_5 = "CREATE_5";
	public static final String CREATE_10 = "CREATE_10";
	public static final String TOOK_1 = "TOOK_1";
	public static final String TOOK_10 = "TOOK_10";
	public static final String HIGHEST_SCORE = "HIGHEST_SCORE";
	public static final String FRIENDS_10 = "FRIENDS_10";
	public static final String CHALLENGER = "CHALLENGER";
	public static final String PERFECT_SCORE = "PERFECT_SCORE";
	public static final String POPULAR_QUIZ = "POPULAR_QUIZ";
	
	public static final Map<String, Achievement> ACHIEVEMENTS;
	static {
		ACHIEVEMENTS = new HashMap<String, Achievement>();
		ACHIEVEMENTS.put(CREATE_1, new Achievement("Amateur Author", "achievement-icons/compose-icon.png", "Created a quiz.")); //TODO: add imageUrls
		ACHIEVEMENTS.put(CREATE_5, new Achievement("Prolific Author", "achievement-icons/booklet-icon.png", "Created 5 quizzes."));
		ACHIEVEMENTS.put(CREATE_10, new Achievement("Prodigious Author", "achievement-icons/bookshelf-icon.png", "Created 10 quizzes."));
		ACHIEVEMENTS.put(TOOK_1, new Achievement("Beginning Quizzee", "achievement-icons/pencil-icon.png", "Took a quiz."));
		ACHIEVEMENTS.put(TOOK_10, new Achievement("Quiz Machine", "achievement-icons/compose-icon.png", "Took 10 quizzes."));
		ACHIEVEMENTS.put(HIGHEST_SCORE, new Achievement("I am the Greatest", "achievement-icons/trophy-icon.png", "Had the highest score on a quiz."));
		ACHIEVEMENTS.put(FRIENDS_10, new Achievement("Social Butterfly", "achievement-icons/chat-icon.png", "Has 10+ friends."));
		ACHIEVEMENTS.put(CHALLENGER, new Achievement("Challenger", "achievement-icons/racing-flags-icon.png", "Challenged someone to take a quiz."));
		ACHIEVEMENTS.put(PERFECT_SCORE, new Achievement("The Next Einstein", "achievement-icons/brightness-icon.png", "Achieved a perfect score on a quiz."));
		ACHIEVEMENTS.put(POPULAR_QUIZ, new Achievement("Appealing to the Masses", "achievement-icons/megaphone-2-icon.png", "Had a popular quiz."));
	}
	
}
