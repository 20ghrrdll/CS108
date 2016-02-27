package users;

public class User {

	private String username, password;
	
	
	public User(String username, String password) {
		this.username = username;
		this.password = password;
	}
	
	
	/**
	 * @return username associated with a user
	 */
	public String getUsername() {
		return username;
	}
	
	
	/**
	 * @return hashed password associated with a user
	 */
	public String getPassword() {
		return password;
	}
	
}
