package co.salpa.bookery.mylib.service;

import java.sql.SQLException;

import org.springframework.ui.Model;

public interface MylibCalendarService {

	Model calendarService(int user_id, Model model) throws SQLException;

}