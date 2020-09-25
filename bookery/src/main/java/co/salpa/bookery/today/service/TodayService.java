package co.salpa.bookery.today.service;

import java.sql.SQLException;

import org.springframework.ui.Model;

public interface TodayService {

	Model listTodayStudiesService(int user_id, Model model) throws SQLException;

}
