package co.salpa.bookery.find.service;

import java.sql.SQLException;

import org.jsoup.nodes.Document;
import org.springframework.ui.Model;

import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.StudyVo;

public interface FindService {
	public String searchService(int start, String search, String select);

	public Document crawlingService(int bid);

	public Model listTocService(Model model, int bid) throws SQLException;
	
	public Model listBookService(Model model) throws SQLException;

	public Model listMostBookService(Model model) throws SQLException;
	
	public void insertStudyService(BookVo book, StudyVo study, String chapters) throws SQLException;

	public Model getBookService(int bid, Model model) throws SQLException;

	public void updateService() throws SQLException;

	public void deleteService() throws SQLException;
}
