package co.salpa.bookery.main.service;

import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

public interface MainService {
	Model bookCoverService(Model model) throws DataAccessException;
}
