package co.salpa.bookery.news.service;

import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

import co.salpa.bookery.model.entity.ClubVo;

public interface NewsService {
	Model noticeService(Model model) throws DataAccessException;
	
	void insertQuestion(ClubVo club) throws DataAccessException;
}
