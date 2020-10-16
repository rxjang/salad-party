package co.salpa.bookery.mylib.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

import co.salpa.bookery.model.entity.StudyVo;

public interface MylibService {
	Model myLibService(Model model, int user_id) throws DataAccessException;
	
	Model selectStudyService(int study_id, Model model) throws DataAccessException;
	
	void insertPagePlanService(StudyVo study, int studyDay, int planPage) throws DataAccessException;
	
	Model selectChapStudyService(int study_id, Model model) throws DataAccessException;
	
	void insertChapPlanService(StudyVo study, int planChap, List<String> tocs) throws DataAccessException;
	
	Model awardService(Model model,int user_id) throws DataAccessException;
	
	Boolean checkPlan(int study_id) throws DataAccessException;
}
