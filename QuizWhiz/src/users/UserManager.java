package users;

import main.MyDBInfo;
import messages.Message;
import main.FinalConstants;
import main.DBConnector;
import java.util.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.text.SimpleDateFormat;

public class UserManager {

	private static Connection con;
	
	public UserManager() {
		con = DBConnector.getConnection();
	}
	
	
	/**
	 * Returns a User object associated with the given username from the 
	 * MySQL database and null if no user with the given username exists.
	 * @param username
	 * @return User object using data from the database or null if user doesn't exist
	 */
	public User getUser(String username) {
		User user = null;
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.USER_TABLE + " WHERE username=\"" + username + "\";";
			ResultSet rs = stmt.executeQuery(query);
			if (rs.next()) {
				user = new User(rs.getString("username"), rs.getString("password"), rs.getBoolean("admin"), rs.getDate("joinDate"));
			}
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		
		return user;
	}
	
	
	/**
	 * Returns an ArrayList of all usernames (essentially all users)
	 * @return ArrayList of all usernames in the database
	 */
	public ArrayList<String> getAllUsernames() {
		ArrayList<String> usernames = new ArrayList<String>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT username FROM " + MyDBInfo.USER_TABLE + ";";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				usernames.add(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return usernames;
	}
	
	
	/**
	 * Hashes the given password then adds that and the associated 
	 * username to the database.
	 * @param username
	 * @param password - plain password
	 */
	public void addUser(String username, String password) {
		String hashedPassword = generateHashedPassword(password);
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = 
		     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentTime = sdf.format(dt);
		try {
			Statement stmt = con.createStatement();
			String update = "INSERT INTO " + MyDBInfo.USER_TABLE + " (username, password, joinDate)" + " VALUES(\"" + username + "\",\"" + hashedPassword + "\", \"" + currentTime + "\");";
			stmt.executeUpdate(update);
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
	}
	
	
	/**
	 * Returns true if a given user is an admin
	 * @param username
	 * @return true if a user is an admin
	 */
	public boolean isAdmin(String username) {
		boolean admin = false;
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT admin FROM " + MyDBInfo.USER_TABLE + " WHERE username='" + username + "';");
			if (rs.next()) {
				admin = rs.getBoolean("admin");
			}
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return admin;
	}
	
	
	/**
	 * Queries the database to find all friends of a given username.
	 * @param username
	 * @return ArrayList of Users that are friends with the given username
	 */
	public Set<String> getFriends(String username) {
		Set<String> friends = new HashSet<String>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.FRIENDS_TABLE + " WHERE user1=\"" + username + "\" OR user2=\"" + username + "\";";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				if(rs.getString("user1").equals(username))
					friends.add(rs.getString("user2").toLowerCase());
				else
					friends.add(rs.getString("user1").toLowerCase());
			}
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return friends;
	}
	
	
	/**
	 * Adds the friendship for two given users to the database
	 * @param user1
	 * @param user2
	 * @param data - SimpleDataFormat of when they became friends
	 */
	public void addFriends(String user1, String user2) {
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(dt);
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("INSERT INTO " + MyDBInfo.FRIENDS_TABLE + " VALUES(\"" + user1 + "\", \"" + user2 + "\", \"" + date + "\");");		
			if (getFriends(user1).size() == 25) addAchievement(user1, FinalConstants.FRIENDS_10);
			if (getFriends(user2).size() == 25) addAchievement(user2, FinalConstants.FRIENDS_10);
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
	}
	
	
	/**
	 * Adds a given achievement ID for a given user
	 * @param username
	 * @param achievementID
	 * @param data - SimpleDataFormat of when the achievement was unlocked
	 */
	public void addAchievement(String username, String achievementID) {
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(dt);
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("INSERT INTO " + MyDBInfo.ACHIEVEMENTS_TABLE + " VALUES(\"" + username + "\", \"" + achievementID + "\", \"" + date + "\");");		
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
	}
	
	
	/**
	 * Returns a set of achievements for a given user
	 * @param username
	 * @return a set of achievements for a given user
	 */
	public Set<Achievement> getAchievements(String username) {
		Set<Achievement> userAchievements = new HashSet<Achievement>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.ACHIEVEMENTS_TABLE + " WHERE userId=\"" + username + "\";";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Achievement a = FinalConstants.ACHIEVEMENTS.get(rs.getString("achievementId")); // TODO FIX MYSQL SO STRING?
				userAchievements.add(a);
			}
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return userAchievements;
	}
	
	
	/**
	 * Hashes a given password
	 * @param password
	 * @return hashed password
	 */
	public String generateHashedPassword(String password) {
		byte[] hash = null;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA");
			hash = md.digest(password.getBytes());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		StringBuffer buff = new StringBuffer();
		for (int i=0; i<hash.length; i++) {
			int val = hash[i];
			val = val & 0xff;  // remove higher bits, sign
			if (val<16) buff.append('0'); // leading 0
			buff.append(Integer.toString(val, 16));
		}
		return buff.toString();
	}
	
	
	public void closeConnection() {
		DBConnector.closeConnection();
	}
	
}
