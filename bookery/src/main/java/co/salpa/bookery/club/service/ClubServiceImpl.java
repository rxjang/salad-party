package co.salpa.bookery.club.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import co.salpa.bookery.model.ClubDao;
import co.salpa.bookery.model.V_Readers_cntDao;
import co.salpa.bookery.model.entity.ClubVo;
import co.salpa.bookery.model.entity.V_Readers_cntVo;

@Service
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
	



}
