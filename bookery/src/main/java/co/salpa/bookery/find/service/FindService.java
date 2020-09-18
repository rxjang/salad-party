package co.salpa.bookery.find.service;

import java.sql.SQLException;

import org.jsoup.nodes.Document;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;


public interface FindService {
	public String searchService(int start, String search, String select);
	public Document crawlingService(int bid);
	public void listService( ) throws SQLException;
	public void oneAddService( ) throws SQLException;
	public void detailService( ) throws SQLException;
	public void updateService( ) throws SQLException;
	public void deleteService( ) throws SQLException;
}
