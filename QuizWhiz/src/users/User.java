package users;

import java.util.ArrayList;
import java.util.Date;

public class User {

	private String username, password;
	private boolean isAdmin;
	private Date joined;
	
	
	public User(String username, String password, boolean isAdmin, Date time) {
		this.username = username;
		this.password = password;
		this.isAdmin = isAdmin;
		this.joined = time;
	}
	
	public String getUsername() {
		return username;
	}
	
	public String getPassword() {
		return password;
	}
	
	public boolean isAdmin() {
		return isAdmin;
	}
	
	public Date getJoinDate(){
		return joined;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (obj == null) return false;
		User other = (User) obj;
		if (!other.getUsername().equals(this.username)) return false;
		return true;
	}
	
}
