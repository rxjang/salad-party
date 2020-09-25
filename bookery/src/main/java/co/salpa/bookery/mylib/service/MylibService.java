package co.salpa.bookery.mylib.service;


import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

public interface MylibService {
	Model myLibService(Model model) throws DataAccessException;
}
