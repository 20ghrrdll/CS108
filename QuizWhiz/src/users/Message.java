package users;

public class Message {
	
	private String title, body, type, sender;
	private boolean unread;
	private int quizId;
	
	public Message(String senderId, String messageTitle, String messageBody, String messageType, boolean messageUnread) {
		this.sender = senderId;
		this.title = messageTitle;
		this.body = messageBody;
		this.type = messageType;
		this.unread = messageUnread;
	}
	
	public Message(String senderId, String messageTitle, String messageBody, String messageType, boolean messageUnread, int messageQuizId) {
		this.sender = senderId;
		this.title = messageTitle;
		this.body = messageBody;
		this.type = messageType;
		this.unread = messageUnread;
		this.quizId = messageQuizId;
	}
	
	public String getSender(){
		return sender;
	}
	public String getTitle() {
		return title;
	}
	
	public String getBody() {
		return body;
	}
	
	public String getType() {
		return type;
	}
	
	public boolean isUnread(){
		return unread;
	}
	
	public int getQuizId(){
		return quizId;
	}

}
