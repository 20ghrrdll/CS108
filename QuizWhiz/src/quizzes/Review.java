package quizzes;

import java.sql.Timestamp;

public class Review {

	private int quizId, rating;
	private String userId, review;
	private Timestamp timeCreated;

	public Review(int quizId, String userId, int rating, String review, Timestamp timeCreated) {
		this.quizId = quizId;
		this.userId = userId;
		this.rating = rating;
		this.review = review;
		this.timeCreated = timeCreated;
	}
	
	public int getQuizId() {
		return quizId;
	}
	
	public int getRating() {
		return rating;
	}
	
	public String getReviewer() {
		return userId;
	}
	
	public String getReview() {
		return review;
	}
	
	public Timestamp getCreated() {
		return timeCreated;
	}
	
}
