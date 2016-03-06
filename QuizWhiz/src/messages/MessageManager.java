package messages;

import main.MyDBInfo;
import messages.Message;
import main.DBConnector;
import java.util.*;
import java.sql.*;

public class MessageManager {

	private static Connection con;
	
	public MessageManager() {
		con = DBConnector.getConnection();
	}

	
	/**
	 * Returns all of the messages sent to a given user
	 * @param username
	 * @return an arraylist of messages for a given user
	 */
	public ArrayList<Message> getMessages(String username, boolean unread) {
		ArrayList<Message> userMessages = new ArrayList<Message>();
		try {
			Statement stmt = con.createStatement();
			String query;
			if(unread){
				query = "SELECT * FROM " + MyDBInfo.MESSAGE_TABLE + " WHERE recipientId=\"" + username + "\" and unread=true;";
			} else {
				query = "SELECT * FROM " + MyDBInfo.MESSAGE_TABLE + " WHERE recipientId=\"" + username + "\" ORDER BY timeSent;";
			}
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Message message;
				if(rs.getString("type").equals("NOTE")){
					message = new Message(rs.getString("senderId"),rs.getString("subject"), rs.getString("body"), rs.getString("type"), rs.getBoolean("unread"));
				} else {
					message = new Message(rs.getString("senderId"),rs.getString("subject"), rs.getString("body"), rs.getString("type"), rs.getBoolean("unread"), rs.getInt("quizId"));
				}
				userMessages.add(message);
			}
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return userMessages;
	}
	
	public void setAsRead(String username){
		
	}
	
	public void closeConnection() {
		DBConnector.closeConnection();
	}

}
