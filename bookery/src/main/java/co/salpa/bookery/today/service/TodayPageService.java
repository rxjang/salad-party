package co.salpa.bookery.today.service;


import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

public interface TodayPageService {

	Model listV_StudyService(Model model) throws DataAccessException;

	Model getV_StudyService(int user_id, int bid, Model model) throws DataAccessException;

	void checkPageService(int actualpage, int study_id) throws DataAccessException;
	
	Model getTodayProgress(Model model, int study_id) throws DataAccessException;
	
	
	
}
