package quizExtras;

import java.sql.Timestamp;

public class ReportedQuiz {

	private int quizId;
	private String reporter;
	private Timestamp dateReported;
	
	public ReportedQuiz(int quizId, String reporter, Timestamp dateReported) {
		this.quizId = quizId;
		this.reporter = reporter;
		this.dateReported = dateReported;
	}
	
	public int getQuizId() {
		return quizId;
	}
	
	public String getReporter() {
		return reporter;
	}
	
	public Timestamp getDate() {
		return dateReported;
	}
}
