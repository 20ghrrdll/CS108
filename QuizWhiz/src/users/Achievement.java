package users;

public class Achievement {

	private String name, imageUrl, description;
	
	public Achievement(String name, String imageUrl, String description) {
		this.name = name;
		this.imageUrl = imageUrl;
		this.description = description;
	}
	
	public String getName() {
		return name;
	}
	
	public String getImageUrl() {
		return imageUrl;
	}
	
	public String getDescription() {
		return description;
	}
	
}
