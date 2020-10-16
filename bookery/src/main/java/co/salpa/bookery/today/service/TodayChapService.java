package co.salpa.bookery.today.service;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

public interface TodayChapService {

	Model listV_StudyService(Model model) throws DataAccessException;

	Model getV_StudyService(int study_id, Model model) throws DataAccessException;

	void checkChapService(List<Integer> id, int study_id) throws DataAccessException;
	
	Model getTodayProgress(Model model, int study_id) throws DataAccessException;

	Boolean checkPlan(int study_id) throws DataAccessException;

}
