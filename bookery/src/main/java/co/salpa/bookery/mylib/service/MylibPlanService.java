package co.salpa.bookery.mylib.service;

import java.sql.SQLException;

import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

public interface MylibPlanService {

	Model selectStudyService(int study_id, Model model) throws SQLException;

	Boolean checkPlan(int study_id)  throws DataAccessException;

//	Model updateTypeChapService(int study_id, Model model);

//	Model updateTypePageService(int study_id, Model model);

}
