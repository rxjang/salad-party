package co.salpa.bookery.find.service;


import org.jsoup.nodes.Document;
import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.StudyVo;

public interface FindService {
	public String searchService(int start, String search, String select);

	public Model crawlingService(int bid, Model model);

	public Model listTocService(Model model, int bid) throws DataAccessException;
	
	public Model listBookService(Model model) throws DataAccessException;

	public Model listMostBookService(Model model) throws DataAccessException;
	

	public void insertStudyService(BookVo book, StudyVo study, String chapters) throws DataAccessException;


	public Model getBookService(int bid, Model model) throws DataAccessException;

	public void updateService() throws DataAccessException;

	public void deleteService() throws DataAccessException;

	public Model getStudyOverlapChk(int id, int bid,Model model);

	String listReadersService() throws DataAccessException;
}
