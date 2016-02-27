package users;

import main.DBConnector;
import java.util.ArrayList;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class UserManager {

	private DBConnector connector;
	private Connection con;
	
	public UserManager() {
		connector = new DBConnector();
		con = connector.getConnection();
	}
	
	
	/*public ArrayList<User> getAllUsers() {
		ArrayList<User> users = new ArrayList<User>();
		try {
			Statement stmt = con.createStatement();
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		
		return users;
	}*/
	
	
	/**
	 * Returns a User object associated with the given username from the 
	 * MySQL database and null if no user with the given username exists.
	 * @param username
	 * @return User object using data from the database or null if user doesn't exist
	 */
	public User getUser(String username) {
		User user = null;
		ArrayList<User> users = new ArrayList<User>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + "TABLE" + " WHERE username=\"" + username + "\";";
			ResultSet rs = stmt.executeQuery(query);
			if (rs.next()) {
				user = new User(rs.getString("username"), rs.getString("password"));
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
		try {
			Statement stmt = con.createStatement();
			// TODO: correct table name
			String update = "INSERT INTO " + "TABLE" + " VALUES(\"" + username + "\",\"" + hashedPassword + "\");";
			stmt.executeUpdate(update);
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
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
	
}