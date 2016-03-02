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
	
	public static final Map<String, Achievement> ACHIEVEMENTS;
	static {
		ACHIEVEMENTS = new HashMap<String, Achievement>();
	}
	
}
