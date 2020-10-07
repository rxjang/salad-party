package co.salpa.bookery.club.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

import co.salpa.bookery.model.entity.ClubVo;

public interface ClubService {

	Model listBookClubService(Model model) throws DataAccessException;

	Model listReadersService(Model model) throws DataAccessException;

	Model getReaderService(int bid, Model model) throws DataAccessException;

	Model OneBooListService(int book_bid, Model model, String search) throws DataAccessException;

	Model getOneService(int id, Model model) throws DataAccessException;

	void addPostService(ClubVo club, HttpSession session, Model model) throws DataAccessException;

	String listMoreService(ClubVo club) throws DataAccessException;

	String addReplyService(ClubVo club, HttpSession session) throws DataAccessException;

	Model listReplyService(int id, Model model) throws DataAccessException;

	void updatePostSerivce(ClubVo club) throws DataAccessException;

	void deletePostService(int id) throws DataAccessException;

	void updateReplyService(ClubVo club) throws DataAccessException;

	void recommendUpService(int id) throws DataAccessException;

	ClubVo getOneService(int id) throws DataAccessException;

	void recommendUpChkService(HttpSession session, int id) throws DataAccessException;

	void listRecommendByUserService(Model model, HttpSession session) throws DataAccessException;

	void recommendDownService(int id)throws DataAccessException;

	void recommendDownChkService(HttpSession session, int id)throws DataAccessException;

	Model listStudyingBookService(HttpSession session,Model model) throws DataAccessException;
}
