package users;

import java.util.ArrayList;
import java.util.Date;

public class User {

	private String username, password;
	private boolean isAdmin;
	private Date joined;
	PrivacySetting profilePrivacy;
	
	public User(String username, String password, boolean isAdmin, Date time, PrivacySetting profilePrivacy) {
		this.username = username;
		this.password = password;
		this.isAdmin = isAdmin;
		this.joined = time;
		this.profilePrivacy =profilePrivacy;
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
	
	public PrivacySetting getProfilePrivacy() {
		return profilePrivacy;
	}
	
	public void setProfilePrivacy(PrivacySetting p) {
		profilePrivacy = p;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (obj == null) return false;
		User other = (User) obj;
		if (!other.getUsername().equals(this.username)) return false;
		return true;
	}
	
}
