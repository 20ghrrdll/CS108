package users;

public class Message {
	
	private String title, body, type;
	
	public Message(String messageTitle, String messageBody, String messageType) {
		this.title = messageTitle;
		this.body = messageBody;
		this.type = messageType;
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

}
