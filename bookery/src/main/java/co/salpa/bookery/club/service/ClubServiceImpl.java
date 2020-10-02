package co.salpa.bookery.club.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import co.salpa.bookery.model.ClubDao;
import co.salpa.bookery.model.V_Readers_cntDao;
import co.salpa.bookery.model.entity.ClubVo;
import co.salpa.bookery.model.entity.UserVo;
import co.salpa.bookery.model.entity.V_Readers_cntVo;

@Service
@Transactional
public class ClubServiceImpl implements ClubService {

	@Autowired
	SqlSession sqlSession;

	
	/*
	 * 북클럽 메인에서 책 목록 불러오기. 
	 */
	@Override
	public Model listBookClubService(Model model) throws DataAccessException {
		List<ClubVo> list = new ArrayList<ClubVo>();
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		
		return model.addAttribute("list", clubDao.selectBookClubAll());
	}//listBookClub

	
	/*
	 * 책제목, 커버, 함꼐읽는 사람수. 리스트로 반환. 
	 */
	@Override
	public Model listReadersService(Model model) throws DataAccessException {
		V_Readers_cntDao v_Readers_cntDao = sqlSession.getMapper(V_Readers_cntDao.class);

		return model.addAttribute("cntReaders", v_Readers_cntDao.selectAll());
	}//listReadersService


	@Override
	public Model getReaderService(int book_bid, Model model) throws DataAccessException {
		V_Readers_cntDao v_Readers_cntDao = sqlSession.getMapper(V_Readers_cntDao.class);
		
		return model.addAttribute("cntReaders", v_Readers_cntDao.selectOne(book_bid));
	}

	/*
	 * 하나의 책과 관련된 게시글들을 불러온다. 리스트
	 */
	@Override
	public Model listOfOneBookService(int book_bid,Model model) throws DataAccessException {
		// TODO Auto-generated method stub
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		return model.addAttribute("list", clubDao.selectAboutBook(book_bid));
	}

	
	/*
	 * 게시글 내용 보기. 디테일
	 */
	@Override
	public Model getOneService(int id, Model model) throws DataAccessException {
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		return model.addAttribute("club", clubDao.selectOneClub(id));
	}

	/*
	 * 게시글 쓰기
	 */
	@Override
	public void addPostService(ClubVo club, HttpSession session ,Model model) throws DataAccessException {
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		UserVo user = (UserVo) session.getAttribute("user");
		club.setUser_id(user.getId());
		clubDao.insertOneClub(club);
	}
	



}
