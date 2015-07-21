package pulse.controllers;

import java.util.ArrayList;
import java.util.List;

import pulse.model.Post;

public class PostsController {
	
	public String addPost(String title, int userId, String content, int categoryId, boolean anonymous)
	{
		int userIdForInsert = userId;
		try {
			if(anonymous)
			{
				userIdForInsert = DBManager.getDBManager().getAnonymousUserId();
			}
			return DBManager.getDBManager().savePost(title, userId, content, categoryId);
		} catch (Exception e) {
			return "Could not save post!";
		}
	}
	
	
	public List<Post> retrievePopularPosts(int categoryId)
	{
		// the mysql insert statement
		String query = "select * from posts";
		try {
			return DBManager.getDBManager().retrievePosts(query);
		} catch (Exception e) {
			return new ArrayList<Post>();
		}
	}

}
