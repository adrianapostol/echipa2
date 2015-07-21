package pulse.ws;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import pulse.controllers.AuthenticationController;


@Path("/authenticate")
public class Register {
	
	@GET
	@Path("/register/{username}/{password}")
	@Produces(MediaType.APPLICATION_JSON)
	public String registerUser(@PathParam("username") String username, @PathParam("password") String password)
	{
		return new AuthenticationController().registerUser(username, password);
	}
	
	@GET
	@Path("/login/{username}/{password}")
	@Produces(MediaType.APPLICATION_JSON)
	public String loginUser(@PathParam("username") String username, @PathParam("password") String password)
	{
		return new AuthenticationController().loginUser(username, password);
	}
}
