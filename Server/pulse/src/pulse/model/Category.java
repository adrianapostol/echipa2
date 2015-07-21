package pulse.model;

import java.io.Serializable;
import java.util.List;


/**
 * The persistent class for the category database table.
 * 
 */
public class Category implements Serializable {
	private static final long serialVersionUID = 1L;

	private transient int id;

	private String categoryName;

	public Category() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCategoryName() {
		return this.categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

}