package quizzes;
import java.sql.*;
import java.util.Calendar;
import java.util.Date;

public class QuizPerformance {
	private String userName;
	private int score;
	private Timestamp startTime;
	private Timestamp endTime;


	public QuizPerformance(String userName, int score, Timestamp startTime, Timestamp endTime) {
		this.userName 	= userName;
		this.score 		= score;
		this.startTime 	= startTime;
		this.endTime 	= endTime;
	}
	public String getUserName() {
		return userName;
	}
	public int getScore() {
		return score; 
	}
	
	
	//TODO: we can change this to diff. time intervals to test if works
	public boolean wasToday() {
		long endInMillis = endTime.getTime();
		Calendar endTimeDate = Calendar.getInstance();
		endTimeDate.setTimeInMillis(endInMillis);
		Calendar today = Calendar.getInstance();
		if (today.get(Calendar.YEAR) == endTimeDate.get(Calendar.YEAR) && today.get(Calendar.DAY_OF_YEAR) == endTimeDate.get(Calendar.DAY_OF_YEAR)) {
			return true;
		}
		return false;
	}

	
	public String getDate() {
		String d = endTime.toString();
		return ((d.substring(5, 7) + "/" + d.substring(8, 10) + "/" + d.substring(0, 4)));
	}
	
}
