package pulse.ws;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import pulse.controllers.PostsController;

@Path("/comments")
public class Comments {
	@GET
	@Path("/addComment/{postId}/{userId}/{content}/{categoryId}/{anonymous}")
	@Produces(MediaType.APPLICATION_JSON)
	public String addPost(@PathParam("postId") String postId, @PathParam("userId")  int userId,@PathParam("content") String content,@PathParam("categoryId") int categoryId,@PathParam("anonymous") boolean anonymous)
	{
		return new PostsController().addPost(postId, userId, content, categoryId, anonymous);
	}
}
