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
				user = new User(rs.getString("username"), rs.getString("password"), rs.getBoolean("admin"), rs.getDate("joinDate"), PrivacySetting.valueOf(rs.getString("profilePrivacy")));
			}
		} catch (SQLException e) {
			return null;
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
			e.printStackTrace(); 
		}
		return usernames;
	}
	
	
	/**
	 * Hashes the given password then adds that and the associated 
	 * username to the database.
	 * @param username
	 * @param password - plain password
	 */
	public boolean addUser(String username, String password) {
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
			return false;
		}
		return true;
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
			e.printStackTrace(); 
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
			e.printStackTrace(); 
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
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
	}
	
	/**
	 * Sends a friend request
	 * @param user1
	 * @param user2
	 * @param data - SimpleDataFormat of when they became friends
	 */
	public void sendFriendRequest(String user1, String user2) {
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(dt);
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("INSERT INTO " + MyDBInfo.FRIEND_REQUEST_TABLE + " VALUES(\"" + user2 + "\", \"" + user1 + "\");");		
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
	}
	
	/**
	 * Queries the database to find all friends requests of a given username.
	 * @param username
	 * @return ArrayList of Users that are friends with the given username
	 */
	public ArrayList<String> getFriendRequests(String username) {
		ArrayList<String> friends = new ArrayList<String>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.FRIEND_REQUEST_TABLE + " WHERE userToId=\"" + username + "\";";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				friends.add(rs.getString("userFromId").toLowerCase());
			}
		} catch (SQLException e) {
			e.printStackTrace(); 
		}
		return friends;
	}
	
	/**
	 * Queries the database to find all friends requested by a given username.
	 * @param username
	 * @return ArrayList of Users that are friends with the given username
	 */
	public ArrayList<String> getSentRequests(String username) {
		ArrayList<String> friends = new ArrayList<String>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.FRIEND_REQUEST_TABLE + " WHERE userFromId=\"" + username + "\";";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				friends.add(rs.getString("userToId").toLowerCase());
			}
		} catch (SQLException e) {
		}
		return friends;
	}
	
	/**
	 * Updates the database to handle friend accept/ignore
	 * @param username
	 * @return ArrayList of Users that are friends with the given username
	 */
	public Set<String> handleFriendResponse(String userFriend, String userName, boolean decision) {
		Set<String> friends = new HashSet<String>();
		try {
			Statement stmt = con.createStatement();
			String query  = "DELETE FROM " + MyDBInfo.FRIEND_REQUEST_TABLE +  " WHERE userToId=\"" + userName + "\" AND userFromId=\"" + userFriend + "\";";
			System.out.print(query);
			stmt.executeUpdate(query);
			if(decision){
				stmt.executeUpdate("INSERT INTO " + MyDBInfo.FRIENDS_TABLE + " (user1, user2) VALUES(\"" + userName + "\", \"" + userFriend +  "\");");	
				System.out.print("INSERT INTO " + MyDBInfo.FRIENDS_TABLE + " (user1, user2) VALUES(\"" + userName + "\", \"" + userFriend +  "\");");

			}
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return friends;
	}
	
	
	/**
	 * Adds a given achievement ID for a given user
	 * @param username
	 * @param achievementID
	 * @param data - SimpleDataFormat of when the achievement was unlocked
	 */
	public boolean addAchievement(String username, String achievementID) {
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = sdf.format(dt);
		try {
			Statement stmt = con.createStatement();
			stmt.executeUpdate("INSERT INTO " + MyDBInfo.ACHIEVEMENTS_TABLE + " VALUES(\"" + username + "\", \"" + achievementID + "\", \"" + date + "\");");		
		} catch (SQLException e) {
			return false; 
		}
		
		return true;
	}
	
	
	/**
	 * Returns a set of achievements for a given user
	 * @param username
	 * @return a set of achievement names for a given user
	 */
	public ArrayList<String> getAchievements(String username) {
		ArrayList<String> userAchievements = new ArrayList<String>();
		try {
			Statement stmt = con.createStatement();
			String query = "SELECT DISTINCT achievementId FROM " + MyDBInfo.ACHIEVEMENTS_TABLE + " WHERE userId=\"" + username + "\";";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				userAchievements.add(rs.getString("achievementId"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userAchievements;
	}
	
	/**
	 * Returns recent activity on the site
	 * @param username
	 * @return a set of achievement names for a given user
	 */
	public ArrayList<RecentActivity> getRecentActivity(String username, Set<String> friends) {
		ArrayList<RecentActivity> activityData = new ArrayList<RecentActivity>();
		if(friends.isEmpty())
			return activityData;
		try {
			Statement stmt = con.createStatement();
			String quizUsers = "";
			Iterator<String> iter = friends.iterator();
			while(iter.hasNext()){
				quizUsers += "creatorId='"+ iter.next() + "'";
				if(iter.hasNext())
					quizUsers+= " OR ";
			}
			String quizRecordUsers = "";
			Iterator<String> it = friends.iterator();
			while(it.hasNext()){
				quizRecordUsers += "userId='"+ it.next() + "'";
				if(it.hasNext())
					quizRecordUsers+= " OR ";
			}
			String quizQuery = "SELECT quizId, creatorId, created FROM " + MyDBInfo.QUIZ_TABLE + " WHERE "+ quizUsers + " ORDER BY created DESC;";
			String quizRecordQuery = "SELECT quizId, userId, end_time FROM " + MyDBInfo.QUIZ_RECORDS_TABLE + " WHERE "+ quizRecordUsers + " ORDER BY end_time DESC;";
			
			ResultSet rs = stmt.executeQuery(quizQuery);
			while (rs.next()) {
				RecentActivity activity = new RecentActivity(rs.getInt("quizId"), rs.getString("creatorId"), "created", rs.getDate("created"));
				activityData.add(activity);
			}
			
			rs = stmt.executeQuery(quizRecordQuery);
			while (rs.next()) {
				RecentActivity activity = new RecentActivity(rs.getInt("quizId"), rs.getString("userId"), "taken", rs.getDate("end_time"));
				activityData.add(activity);
			}
			
			Collections.sort(activityData);
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return activityData;
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
	
	public static String toJavascriptArray(Set<String> arr){
	    StringBuffer sb = new StringBuffer();
	    sb.append("[");
	    int i = 0;
	    for(String user: arr){
	        sb.append("\"").append(user).append("\"");
	        if(i < arr.size()){
	            sb.append(",");
	        }
	        i++;
	    }
	    sb.append("]");
	    return sb.toString();
	}
	
	public void setPrivacy(String privacyType, String username, String privacy) {
		String query = "UPDATE " + MyDBInfo.USER_TABLE + " SET " + privacyType + "='" +privacy+"' where username='" + username + "';";
		System.out.println(query);
		try {
			Statement stmt = con.createStatement();
			stmt.execute(query);
		} catch (SQLException e) {
			e.printStackTrace(); 
		}
		
	}
	
	public PrivacySetting getProfilePrivacy(String username) {
		String query = "SELECT profilePrivacy from " + MyDBInfo.USER_TABLE + " WHERE username='" + username + "';";
		Statement stmt;
		String privacy = "";
		try {
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				 privacy = rs.getString("profilePrivacy");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return PrivacySetting.valueOf(privacy);
	}
	
	
	public void closeConnection() {
		DBConnector.closeConnection();
	}
	
}
