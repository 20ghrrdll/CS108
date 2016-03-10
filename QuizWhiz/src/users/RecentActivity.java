package users;

import java.util.Comparator;
import java.util.Date;

public class RecentActivity implements Comparable<RecentActivity> {
	
	private int quizId;
	private String userId, type;
	private Date activityDate;
	
	public RecentActivity(int quiz_id, String user_id, String typeOfActivty, Date date) {
		this.quizId = quiz_id;
		this.userId = user_id;
		this.type = typeOfActivty;
		this.activityDate = date;
	}
	
	public int getQuizId(){
		return quizId;
	}
	
	public String getUserId(){
		return userId;
	}
	
	public String getType(){
		return type;
	}

	public Date getDate(){
		return activityDate;
	}

	@Override
	public int compareTo(RecentActivity o) {
		return o.getDate().compareTo(this.getDate());
	}

}

