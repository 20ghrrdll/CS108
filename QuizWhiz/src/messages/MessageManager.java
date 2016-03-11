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
					message = new Message(rs.getString("senderId"),rs.getString("subject"), rs.getString("body"), rs.getString("type"), rs.getBoolean("unread"), rs.getShort("messageId"));
				} else {
					message = new Message(rs.getString("senderId"),rs.getString("subject"), rs.getString("body"), rs.getString("type"), rs.getBoolean("unread"), rs.getInt("quizId"), rs.getShort("messageId"));
				}
				userMessages.add(message);
			}
		} catch (SQLException e) {
		}
		return userMessages;
	}

	public boolean sendMessage(String sender, String username, String subject, String body){
		try {
			Statement stmt = con.createStatement();
			String query = "INSERT INTO  " + MyDBInfo.MESSAGE_TABLE + " (senderId, recipientId, subject, body, type) VALUES ('" + sender +"','" + username +"', '" + subject +"','" + body +"','NOTE');";
			stmt.executeUpdate(query);
		} catch (SQLException e) {
			return false;
		}
		return true;
	}
	
	public boolean sendChallenge(String sender, String username, int quizId){
		try {
			Statement stmt = con.createStatement();
			String query = "INSERT INTO  " + MyDBInfo.MESSAGE_TABLE + " (senderId, recipientId, quizId, type) VALUES ('" + sender +"','" + username +"', '" + quizId +"','CHALLENGE');";
			System.out.println(query);
			stmt.executeUpdate(query);
			System.out.println(query);
		} catch (SQLException e) {
			return false;
		}
		return true;
	}

	public void setAsRead(int messageId){
		try {
			Statement stmt = con.createStatement();
			String query = "UPDATE " + MyDBInfo.MESSAGE_TABLE + " SET unread=false WHERE messageId='" + messageId +"';";
			stmt.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void closeConnection() {
		DBConnector.closeConnection();
	}

}
