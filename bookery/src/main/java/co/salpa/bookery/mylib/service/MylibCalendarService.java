package co.salpa.bookery.mylib.service;

import java.sql.SQLException;

import org.springframework.ui.Model;

public interface MylibCalendarService {

	Model selectStudyService(int study_id, Model model) throws SQLException;

}