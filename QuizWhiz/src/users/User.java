package users;

import java.util.ArrayList;
import java.util.Date;

public class User {

	private String username, password;
	private boolean isAdmin;
	private Date joined;
	PrivacySetting profilePrivacy;
	PrivacySetting friendPrivacy;
	
	public User(String username, String password, boolean isAdmin, Date time, PrivacySetting profilePrivacy, PrivacySetting friendPrivacy) {
		this.username = username;
		this.password = password;
		this.isAdmin = isAdmin;
		this.joined = time;
		this.profilePrivacy = profilePrivacy;
		this.friendPrivacy = friendPrivacy;
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
	
	public PrivacySetting getFriendPrivacy() {
		return friendPrivacy;
	}
	
	public void setFriendPrivacy(PrivacySetting p) {
		friendPrivacy = p;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (obj == null) return false;
		User other = (User) obj;
		if (!other.getUsername().equals(this.username)) return false;
		return true;
	}
	
}
