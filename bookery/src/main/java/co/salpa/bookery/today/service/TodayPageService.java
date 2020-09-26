package co.salpa.bookery.today.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import co.salpa.bookery.model.entity.V_StudyVo;

public interface TodayPageService {

	Model listV_StudyService(Model model) throws SQLException;

	Model getV_StudyService(int user_id, int bid, Model model) throws SQLException;

	void checkPageService(int actualpage, int study_id) throws SQLException;
	
	Model getTodayProgress(Model model, int study_id) throws SQLException;
	
	
	
}
