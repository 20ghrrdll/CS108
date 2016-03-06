package messages;

public class Message {
	
	private String title, body, type, sender;
	private boolean unread;
	private int quizId, id;
	
	public Message(String senderId, String messageTitle, String messageBody, String messageType, boolean messageUnread, int messageId) {
		this.sender = senderId;
		this.title = messageTitle;
		this.body = messageBody;
		this.type = messageType;
		this.unread = messageUnread;
		this.id = messageId;
	}
	
	public Message(String senderId, String messageTitle, String messageBody, String messageType, boolean messageUnread, int messageQuizId, int messageId) {
		this.sender = senderId;
		this.title = messageTitle;
		this.body = messageBody;
		this.type = messageType;
		this.unread = messageUnread;
		this.quizId = messageQuizId;
		this.id = messageId;
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
	
	public int getId(){
		return id;
	}

}
