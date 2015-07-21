package pulse.ws;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import pulse.controllers.PostsController;
import pulse.model.Category;
import pulse.model.Post;

@Path("/posts")
public class Posts {

	@GET
	@Path("/addPost/{title}/{userId}/{content}/{categoryId}/{anonymous}")
	@Produces(MediaType.APPLICATION_JSON)
	public String addPost(@PathParam("title") String title,@PathParam("userId")  int userId,@PathParam("content") String content,@PathParam("categoryId") int categoryId,@PathParam("anonymous") boolean anonymous)
	{
		return new PostsController().addPost(title, userId, content, categoryId, anonymous);
	}
	
	@GET
	@Path("/getPopular/{categoryId}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Post> getPopular(@PathParam("categoryId") int categoryId)
	{
		return new PostsController().retrievePopularPosts(categoryId);
	}
	
	@GET
	@Path("/getTopRated/{categoryId}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Post> getTopRated(@PathParam("categoryId") int categoryId)
	{
		return new PostsController().retrievePopularPosts(categoryId);
	}
	
	@GET
	@Path("/getRecent/{categoryId}")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Post> getRecent(@PathParam("categoryId") int categoryId)
	{
		return new PostsController().retrievePopularPosts(categoryId);
	}
	
}
