package co.salpa.bookery.mylib.service;

import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

import co.salpa.bookery.model.entity.CheckPageVo;
import co.salpa.bookery.model.entity.StudyVo;

public interface MylibService {
	Model myLibService(Model model, int user_id) throws DataAccessException;
	
	Model selectStudyService(int study_id, Model model) throws DataAccessException;
	
	void insertPagePlanService(StudyVo study, int studyDay, int planPage) throws DataAccessException;
}
