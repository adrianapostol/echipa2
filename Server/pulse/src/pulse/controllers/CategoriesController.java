package pulse.controllers;

import java.util.ArrayList;
import java.util.List;

import pulse.model.Category;

public class CategoriesController {
	
	public List<Category> getCategories()
	{
		try {
			return DBManager.getDBManager().listAllCategories();
		} catch (Exception e) {
			return new ArrayList<Category>();
		}
	}
	
}
