package pulse.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the posts database table.
 * 
 */
public class Post implements Serializable {
	private static final long serialVersionUID = 1L;

	private int id;

	private String content;

	private Date postTime;

	private String title;

	private String category;

	private String username;

	public Post() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}


	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getPostTime() {
		return this.postTime;
	}

	public void setPostTime(Date postTime) {
		this.postTime = postTime;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCategory() {
		return this.category;
	}

	public void setCategory(String category) {
		this.category = category;
	}


	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	
	
}