package co.salpa.bookery.club.service;


import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;


public interface ClubService {

	Model listBookClub(Model model) throws DataAccessException;

	
}
