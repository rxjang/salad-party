package co.salpa.bookery.club.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import co.salpa.bookery.model.ClubDao;
import co.salpa.bookery.model.entity.ClubVo;

@Service
public class ClubServiceImpl implements ClubService {

	@Autowired
	SqlSession sqlSession;

	
	/*
	 * 북클럽 메인에서 책 목록 불러오기. 
	 */
	@Override
	public Model listBookClub(Model model) throws DataAccessException {
		List<ClubVo> list = new ArrayList<ClubVo>();
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		
		return model.addAttribute("list", clubDao.selectBookClubAll());
	}//listBookClub
	



}
