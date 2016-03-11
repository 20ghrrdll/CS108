package administration;

import main.MyDBInfo;
import messages.Message;
import quizExtras.ReportedQuiz;
import main.FinalConstants;
import main.DBConnector;
import java.util.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.text.SimpleDateFormat;

public class AdminManager {

	private static Connection con;
	
	public AdminManager() {
		con = DBConnector.getConnection();
	}
	
	/**
	 * @return number of users on the website
	 */
	public int getNumUsers() {
		int numUsers = 0;
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM " + MyDBInfo.USER_TABLE + ";");
			if (rs.next()) {
				numUsers = rs.getInt(1);
			}
		} catch (SQLException e) {
			return 0;
		}
		
		return numUsers;
	}
	
	/**
	 * @return number of quizzes that have been taken by users
	 */
	public int getNumQuizzesTaken() {
		int numQuizzesTaken = 0;
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT count( DISTINCT(quizId) ) FROM " + MyDBInfo.QUIZ_RECORDS_TABLE + ";");
			if (rs.next()) {
				numQuizzesTaken = rs.getInt(1);
			}
		} catch (SQLException e) {
		}
		
		return numQuizzesTaken;
	}
	
	
	/**
	 * @return number of quizzes created
	 */
	public int getNumQuizzesCreated() {
		int numQuizzesCreated = 0;
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT count( DISTINCT(quizId) ) FROM " + MyDBInfo.QUIZ_TABLE + ";");
			if (rs.next()) {
				numQuizzesCreated = rs.getInt(1);
			}
		} catch (SQLException e) {
		}
		
		return numQuizzesCreated;
	}
	
	
	/**
	 * Creates an announcement to be displayed on the homepage
	 * @param title
	 * @param text
	 */
	public boolean createAnnouncement(String username, String subject, String body) {
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(dt);
		try {
			String update = "INSERT INTO " + MyDBInfo.ANNOUNCEMENTS_TABLE + " (userId, posted, subject, body) VALUES(?, ?, ?, ?);";
			PreparedStatement s = con.prepareStatement(update);
			s.setString(1, username);
			s.setString(2, date);
			s.setString(3, subject);
			s.setString(4, body);
			s.executeUpdate();
		} catch (SQLException e) {
			return false;
		}
		return true;
	}
	
	
	/**
	 * Deletes an announcement from the database
	 * @param announcementId
	 * @return
	 */
	public boolean deleteAnnouncement(int announcementId) {
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.ANNOUNCEMENTS_TABLE + " WHERE announcementId='" + announcementId + "';");
		} catch (SQLException e) {
			return false;
		}
		return true;
	}
	
	
	/**
	 * Deletes a given user from relevant tables in the database including 
	 * the users table, friends table, etc.
	 * @param username
	 */
	public boolean deleteUser(String username) {
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.USER_TABLE + " WHERE username=\"" + username + "\";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.FRIENDS_TABLE + " WHERE user1=\"" + username + "\" OR user2=\"" + username + "\";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.ACHIEVEMENTS_TABLE + " where userId=\"" + username + "\";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.FRIEND_REQUEST_TABLE + " WHERE userToId=\"" + username + "\" OR userFromId=\"" + username + "\";");
		} catch (SQLException e) {
			return false;
		}
		return true;
	}
	
	
	/**
	 * Deletes a given quiz from the database, including any records
	 * @param quizId
	 */
	public boolean deleteQuiz(int quizId) {
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.QUIZ_TABLE + " WHERE quizId=" + quizId + ";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.QUIZ_RECORDS_TABLE + " WHERE quizId=" + quizId + ";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.ANSWERS_TABLE + " WHERE quizId=" + quizId + ";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.QUESTION_TABLE + " WHERE quizId=" + quizId + ";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.QUESTION_RECORDS_TABLE + " WHERE quizId=" + quizId + ";");
		} catch (SQLException e) {
			return false;
		}
		return true;
	}
	
	
	/**
	 * Clears all history information for a given quiz
	 * @param quizId
	 */
	public boolean clearQuizHistory(int quizId) {
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.QUIZ_RECORDS_TABLE + " WHERE quizId=" + quizId + ";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.QUESTION_RECORDS_TABLE + " WHERE quizId=" + quizId + ";");
		} catch (SQLException e) {
			return false;
		}
		return true;
	}
	
	
	/**
	 * Makes a given user an admin
	 * @param username
	 */
	public boolean makeAdmin(String username) {
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("UPDATE " + MyDBInfo.USER_TABLE + " SET admin=TRUE WHERE username='" + username + "';");
		} catch (SQLException e) {
			return false;
		}
		return true;
	}
	
	
	/**
	 * Deletes a reported quiz from the database and removes from list of reported quiz
	 * @param quizId
	 * @return
	 */
	public boolean deleteReportedQuiz(int quizId) {
		try {
			Statement stmt = con.createStatement();		
			deleteQuiz(quizId);
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.REPORTED_QUIZZES + " WHERE quizId='" + quizId + "';");
		} catch (SQLException e1) {
			return false;
		}
		return true;
	}
	
	
	/**
	 * Removes a quiz from the reported quiz list without deleting it
	 * @param quizId
	 * @return
	 */
	public boolean ignoreReportedQuiz(int quizId) {
		try {
			Statement stmt = con.createStatement();		
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.REPORTED_QUIZZES + " WHERE quizId='" + quizId + "';");
		} catch (SQLException e1) {
			return false;
		}
		return true;
	}
	
	
	/**
	 * Returns a list of quizzes that have been reported. Multiples are allowed.
	 * @return
	 */
	public ArrayList<ReportedQuiz> getReportedQuizzes() {
		ArrayList<ReportedQuiz> quizzes = new ArrayList<ReportedQuiz>();
		try {
			Statement stmt = con.createStatement();		
			ResultSet rs = stmt.executeQuery("SELECT * FROM " + MyDBInfo.REPORTED_QUIZZES + " ORDER BY reportedDate DESC;");
			while (rs.next()) {
				ReportedQuiz r = new ReportedQuiz(rs.getInt("quizId"), rs.getString("reportedBy"), rs.getTimestamp("reportedDate"));
				quizzes.add(r);
			}
		} catch (SQLException e1) {
		}
		return quizzes;
	}
	
	
	public void closeConnection() {
		DBConnector.closeConnection();
	}
	
}
