package co.salpa.bookery.mylib.service;

import java.sql.SQLException;

import org.springframework.ui.Model;

import com.fasterxml.jackson.core.JsonProcessingException;

public interface MylibCalendarService {

	Model calendarService(int user_id, Model model) throws SQLException, JsonProcessingException;

	Boolean checkActive(int study_id);

}