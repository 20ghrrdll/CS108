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
				numUsers = rs.getInt(0);
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
	
	public void closeConnection() {
		DBConnector.closeConnection();
	}
	
}
