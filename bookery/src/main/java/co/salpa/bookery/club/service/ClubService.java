package co.salpa.bookery.club.service;


import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;


public interface ClubService {

	Model listBookClubService(Model model) throws DataAccessException;
	Model listReadersService(Model model) throws DataAccessException;
	Model getReaderService(int bid, Model model) throws DataAccessException;
	
}
