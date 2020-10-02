package co.salpa.bookery.news.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import co.salpa.bookery.model.ClubDao;
import co.salpa.bookery.model.entity.ClubVo;

@Repository
public class NewsServiceEmpl implements NewsService {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public Model noticeService(Model model) throws DataAccessException {
		ClubDao clubDao=sqlSession.getMapper(ClubDao.class);
		List<ClubVo> noticeList=clubDao.selectNoticeAll();
		model.addAttribute("noticeList", noticeList);
		return null;
	}

	@Override
	public void insertQuestion(ClubVo club) throws DataAccessException {
		ClubDao clubDao=sqlSession.getMapper(ClubDao.class);
		clubDao.insertNotice(club);
	}

	@Override
	public Model detailNoticeService(int id, Model model) throws DataAccessException {
		ClubDao clubDao=sqlSession.getMapper(ClubDao.class);
		ClubVo club=clubDao.selectOneNotice(id);
		model.addAttribute("noticeOne", club);
		return null;
	}

	@Override
	public void updateNotice(ClubVo club) throws DataAccessException {
		ClubDao clubDao=sqlSession.getMapper(ClubDao.class);
		clubDao.updateNotice(club);
	}

	@Override
	public void deleteNotice(int id) throws DataAccessException {
		ClubDao clubDao=sqlSession.getMapper(ClubDao.class);
		clubDao.deleteClubData(id);
	}

}
