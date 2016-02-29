package main;

import java.sql.Time;

public class Announcement {
	
	private int announcementId;
	private String userId;
	private Time postedTime;
	private String subject;
	private String body;
	
	
	public Announcement(int announcement_id, String user_id, Time posted, String announcement_subject, String announcement_body){
		this.announcementId = announcement_id;
		this.userId = user_id;
		this.postedTime = posted;
		this.subject = announcement_subject;
		this.body = announcement_body;
	}
	
	public String getUser(){
		return this.userId;
	}
	
	public String getSubject(){
		return this.subject;
	}
	
	public String getBody(){
		return this.body;
	}
	
	public Time getTime(){
		return this.postedTime;
	}

}
