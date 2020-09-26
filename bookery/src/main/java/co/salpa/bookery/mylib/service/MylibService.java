package co.salpa.bookery.mylib.service;


import java.sql.SQLException;

import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

public interface MylibService {
	Model myLibService(Model model) throws DataAccessException;
	
	Model selectStudyService(int study_id, Model model) throws DataAccessException;
}
