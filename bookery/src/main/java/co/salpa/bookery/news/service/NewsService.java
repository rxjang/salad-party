package co.salpa.bookery.news.service;

import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

public interface NewsService {
	Model noticeService(Model model) throws DataAccessException;
}
