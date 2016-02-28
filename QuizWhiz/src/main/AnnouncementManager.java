package main;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import users.User;

public class AnnouncementManager {

	private static Connection con = null;

	public AnnouncementManager(){

	}

	public ArrayList<Announcement> getAnnouncements(){
		Announcement announcement = null;
		ArrayList<Announcement> announcements = new ArrayList<Announcement>();
		try {
			con = DBConnector.getConnection();
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM " + MyDBInfo.ANNOUNCEMENTS_TABLE + ";";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				announcement = new Announcement(rs.getInt("announcementId"),
						rs.getString("userId"),
						rs.getTime("posted"),
						rs.getString("subject"),
						rs.getString("body"));
				announcements.add(announcement);
				
			}
			DBConnector.closeConnection();
			return announcements;
		} catch (SQLException e) {
			e.printStackTrace(); // TODO: what to do here
		}
		return null;
	}
	

}
