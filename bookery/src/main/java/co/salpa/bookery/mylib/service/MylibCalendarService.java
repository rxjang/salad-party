package co.salpa.bookery.mylib.service;

import java.sql.SQLException;

import org.springframework.ui.Model;

public interface MylibCalendarService {

	Model listTodayStudiesService(int study_id, Model model) throws SQLException;

}