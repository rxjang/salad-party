package co.salpa.bookery.today.service;

import java.sql.SQLException;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;

public interface TodayService {

	Model todayService(int user_id, Model model) throws SQLException;

}
