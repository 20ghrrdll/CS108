package users;

import main.MyDBInfo;
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
	 * Queries the database to find all friends of a given username.
	 * @param username
	 * @return ArrayList of Users that are friends with the given username
	 */
	public Set<User> getFriends(String username) {
		Set<User> friends = new HashSet<User>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.FRIENDS_TABLE + " WHERE user1=\"" + username + "\" OR user2=\"" + username + "\";";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				User friend = new User(rs.getString("username"), rs.getString("password"), rs.getBoolean("admin"), rs.getDate("joinDate"));
				friends.add(friend);
			}
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return friends;
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
