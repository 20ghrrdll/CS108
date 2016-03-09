package administration;

import main.MyDBInfo;
import messages.Message;
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
			e.printStackTrace(); // TODO: what to do here
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
			e.printStackTrace(); // TODO: what to do here
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
			e.printStackTrace(); // TODO: what to do here
		}
		
		return numQuizzesCreated;
	}
	
	
	/**
	 * Creates an announcement to be displayed on the homepage
	 * @param title
	 * @param text
	 */
	public void createAnnouncement(String username, String subject, String body) {
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(dt);
		
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("INSERT INTO " + MyDBInfo.ANNOUNCEMENTS_TABLE + "(userId, posted, subject, body) VALUES('" + username + "', '" + date + "', '" + subject + "', '" + body + "');");
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
	}
	
	
	// TODO: make sure there are no links to deleted users' profiles? like its just name, no link
	// TODO: delete announcements?
	/**
	 * Deletes a given user from relevant tables in the database including 
	 * the users table, friends table, etc.
	 * @param username
	 */
	public void deleteUser(String username) {
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.USER_TABLE + " WHERE username=\"" + username + "\";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.FRIENDS_TABLE + " WHERE user1=\"" + username + "\" OR user2=\"" + username + "\";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.ACHIEVEMENTS_TABLE + " where userId=\"" + username + "\";");
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
	}
	
	
	/**
	 * Deletes a given quiz from the database, including any records
	 * @param quizId
	 */
	public void deleteQuiz(int quizId) {
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.QUIZ_TABLE + " WHERE quizId=" + quizId + ";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.QUIZ_RECORDS_TABLE + " WHERE quizId=" + quizId + ";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.ANSWERS_TABLE + " WHERE quizId=" + quizId + ";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.QUESTION_TABLE + " WHERE quizId=" + quizId + ";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.QUESTION_RECORDS_TABLE + " WHERE quizId=" + quizId + ";");
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
	}
	
	
	/**
	 * Clears all history information for a given quiz
	 * @param quizId
	 */
	public void clearQuizHistory(int quizId) {
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.QUIZ_RECORDS_TABLE + " WHERE quizId=" + quizId + ";");
			stmt.executeUpdate("DELETE FROM " + MyDBInfo.QUESTION_RECORDS_TABLE + " WHERE quizId=" + quizId + ";");
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
	}
	
	
	/**
	 * Makes a given user an admin
	 * @param username
	 */
	public void makeAdmin(String username) {
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("UPDATE " + MyDBInfo.USER_TABLE + " SET admin=TRUE WHERE username='" + username + "';");
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
	}
	
	
	public void closeConnection() {
		DBConnector.closeConnection();
	}
	
}
