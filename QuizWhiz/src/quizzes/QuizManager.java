package quizzes;

import main.DBConnector;
import java.sql.*;
import java.util.ArrayList;

public class QuizManager {

	private static Connection con = null;
	
	public QuizManager() {
		
	}
	
	/**
	 * Returns Quiz objects for every quiz currently stored in the database.
	 * @return ArrayList of Quiz objects
	 */
	public ArrayList<Quiz> getAllQuizzes() {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		try {
			con = DBConnector.getConnection();
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + "quiz";
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
			}
			DBConnector.closeConnection();
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		
		return quizzes;
	}
	
}
