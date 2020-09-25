package co.salpa.bookery.mylib.service;

import java.sql.SQLException;

import org.springframework.ui.Model;

public interface MylibPlanService {

	Model selectStudyService(int study_id, Model model) throws SQLException;

//	Model updateTypeChapService(int study_id, Model model);

//	Model updateTypePageService(int study_id, Model model);

}
