package pulse.model;

import java.io.Serializable;


/**
 * The persistent class for the ratings database table.
 * 
 */
public class Rating implements Serializable {
	private static final long serialVersionUID = 1L;

	private int id;

	private int rating;

	private Post post;

	private User user;

	public Rating() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getRating() {
		return this.rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public Post getPost() {
		return this.post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}