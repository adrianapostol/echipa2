package pulse.controllers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import pulse.model.Category;
import pulse.model.Post;

public class DBManager {

	Connection conn = null;
	public static DBManager instance = null;

	public static DBManager getDBManager() throws Exception
	{
		if(instance!=null)
		{
			return instance;
		}
		else
		{
			instance = new DBManager();
			return instance;
		}
	}
	
	private DBManager() throws Exception {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test?"
				+ "user=root");
	}

	public String saveUser(String username, String password) {
		// the mysql insert statement
		String query = "insert into Users(username, pass,lastActionTime) values (?,?,?)";

		// create the mysql insert preparedstatement
		PreparedStatement preparedStmt;
		try {
			preparedStmt = conn.prepareStatement(query);

			preparedStmt.setString(1, username);
			preparedStmt.setString(2, password);
			preparedStmt.setDate(3, new Date(System.currentTimeMillis()));

			// execute the preparedstatement
			preparedStmt.execute();

		} catch (SQLException e) {
			return "Fail";
		}

		return checkUser(username, password);
	}
	
	public String checkUser(String username, String password) {
		// the mysql insert statement
		String query = "select * from users where username='" + username +"' and pass='" + password+"'";

		// create the mysql insert preparedstatement
		Statement statement;
		try {
			statement = conn.createStatement();
			

			ResultSet rs = statement.executeQuery(query);
			if (rs.next()) {
				return String.valueOf(rs.getInt(1));
			} else {
				return "Fail";
			}

		} catch (SQLException e) {
			return "Fail";
		}
	}
	
	public int getAnonymousUserId() {
		// the mysql insert statement
		String query = "select id from users where username='anonymous'";

		// create the mysql insert preparedstatement
		Statement statement;
		try {
			statement = conn.createStatement();
			

			ResultSet rs = statement.executeQuery(query);
			if (rs.next()) {
				return rs.getInt(1);
			} else {
				return -1;
			}

		} catch (SQLException e) {
			return -1;
		}
	}
	
	public String getUsername(int userId) {
		// the mysql insert statement
		String query = "select username from users where id='"+userId+"'";

		// create the mysql insert preparedstatement
		Statement statement;
		try {
			statement = conn.createStatement();

			ResultSet rs = statement.executeQuery(query);
			if (rs.next()) {
				return rs.getString(1);
			} else {
				return "Fail";
			}

		} catch (SQLException e) {
			return "Fail";
		}
	}
	
	public Category getCategoryById(int id)
	{
		List<Category> categories = listAllCategories();
		for(Category categ : categories)
		{
			if(categ.getId() == id)
			{
				return categ;
			}
		}
		
		return new Category();
	}
	
	public List<Category> listAllCategories()
	{
		// the mysql insert statement
		String query = "select * from category";
		List<Category> results = new ArrayList<Category>();
		// create the mysql insert preparedstatement
		Statement statement;
		try {
			statement = conn.createStatement();
			

			ResultSet rs = statement.executeQuery(query);
			while (rs.next()) {
				Category categ = new Category();
				categ.setId(rs.getInt(1));
				categ.setCategoryName(rs.getString(2));
				results.add(categ);
			} 

		} catch (SQLException e) {
			return results;
		}
		
		return results;
	}
	
	public String savePost(String title, int userId, String content, int categoryId)
	{
		// the mysql insert statement
		String query = "insert into Posts(title, userId, content, categoryId, postTime) values (?,?,?,?,?)";

		// create the mysql insert preparedstatement
		PreparedStatement preparedStmt;
		try {
			preparedStmt = conn.prepareStatement(query);

			preparedStmt.setString(1, title);
			preparedStmt.setInt(2, userId);
			preparedStmt.setString(3, content);
			preparedStmt.setInt(4, categoryId);
			preparedStmt.setDate(5, new Date(System.currentTimeMillis()));

			// execute the preparedstatement
			preparedStmt.execute();

		} catch (SQLException e) {
			return "Could not save post!";
		}

		return "Success";
	}
	
	public List<Post> retrievePosts(String query)
	{
		List<Post> results = new ArrayList<Post>();
		// create the mysql insert preparedstatement
		Statement statement;
		try {
			statement = conn.createStatement();
			

			ResultSet rs = statement.executeQuery(query);
			if (rs.next()) {
				Post post = new Post();
				
				post.setId(rs.getInt(1));
				post.setTitle(rs.getString(2));
				post.setUsername(getUsername(rs.getInt(3)));
				post.setContent(rs.getString(4));
				post.setCategory(getCategoryById(rs.getInt(5)).getCategoryName());
				post.setPostTime(rs.getDate(6));
				results.add(post);
			} 

		} catch (SQLException e) {
			return results;
		}
		
		return results;
	}
	
	public String saveComments(String title, int userId, String content, int categoryId)
	{
		// the mysql insert statement
		String query = "insert into Comments(userId, content, postId, commentTime) values (?,?,?,?)";

		// create the mysql insert preparedstatement
		PreparedStatement preparedStmt;
		try {
			preparedStmt = conn.prepareStatement(query);

			preparedStmt.setInt(1, userId);
			preparedStmt.setString(2, content);
			preparedStmt.setInt(3, categoryId);
			preparedStmt.setDate(4, new Date(System.currentTimeMillis()));

			// execute the preparedstatement
			preparedStmt.execute();

		} catch (SQLException e) {
			return "Could not save post!";
		}

		return "Success";
	}
}
