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
	
	@Override
	public boolean equals(Object obj) {
		if (obj == null) return false;
		Achievement other = (Achievement) obj;
		if (!other.getName().equals(this.name)) return false;
		return true;
	}
}
