package pulse.controllers;

public class AuthenticationController {
	
	public String registerUser(String username, String password)
	{
		try {
			return DBManager.getDBManager().saveUser(username, password);
		} catch (Exception e) {
			return "Fail";
		}
	}
	
	public String loginUser(String username, String password)
	{
		try {
			return DBManager.getDBManager().checkUser(username, password);
		} catch (Exception e) {
			return "Fail";
		}
	}
}
