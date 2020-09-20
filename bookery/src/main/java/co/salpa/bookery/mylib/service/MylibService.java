package co.salpa.bookery.mylib.service;


import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

public interface MylibService {
	Model listNoGoalBookService(Model model) throws DataAccessException;
	Model listStudyinglBookService(Model model) throws DataAccessException;
	Model listFinishedlBookService(Model model) throws DataAccessException;
}
