package users;

import java.util.ArrayList;

public class User {

	private String username, password;
	private boolean isAdmin;
	
	
	public User(String username, String password, boolean isAdmin) {
		this.username = username;
		this.password = password;
		this.isAdmin = isAdmin;
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
	
	@Override
	public boolean equals(Object obj) {
		if (obj == null) return false;
		User other = (User) obj;
		if (!other.getUsername().equals(this.username)) return false;
		return true;
	}
	
}
