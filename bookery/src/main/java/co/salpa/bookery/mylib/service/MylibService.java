package co.salpa.bookery.mylib.service;


import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

public interface MylibService {
	Model listNoGoalBookService(Model model) throws DataAccessException;
	Model listStudyingBookService(Model model) throws DataAccessException;
	Model listFinishedBookService(Model model) throws DataAccessException;
	Model countNoGoalBookService(Model model) throws DataAccessException;
	Model countStudyingBookService(Model model) throws DataAccessException;
	Model countFinishedBookService(Model model) throws DataAccessException;
}
