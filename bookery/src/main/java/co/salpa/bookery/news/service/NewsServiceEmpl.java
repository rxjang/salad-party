package co.salpa.bookery.news.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import co.salpa.bookery.model.BookDao;
import co.salpa.bookery.model.ClubDao;
import co.salpa.bookery.model.V_NoticeDao;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.ClubVo;
import co.salpa.bookery.model.entity.V_NoticeVo;
import co.salpa.bookery.model.entity.V_StudyVo;

@Service
public class NewsServiceEmpl implements NewsService {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public Model newsMainService(Model model) throws DataAccessException {
		BookDao bookDao = sqlSession.getMapper(BookDao.class);
		ClubDao clubDao=sqlSession.getMapper(ClubDao.class);
		V_StudyDao v_StudyDao=sqlSession.getMapper(V_StudyDao.class);
		List<BookVo> list = bookDao.selectMostBook();
		List<ClubVo> noticeList=clubDao.selectNewsNotice();
		List<ClubVo> contentList=clubDao.selectContentForNews();
		List<ClubVo> popularContents=clubDao.popularContents();
		List<V_StudyVo> bestUserList=v_StudyDao.bestAchieveUser();
		model.addAttribute("bestBooks", list);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("contentList", contentList);
		model.addAttribute("bestUserList", bestUserList);//꺼낼때 nickname,pages(완독한 책 수)
		model.addAttribute("popularContents", popularContents);//꺼낼때 title,id,num(추천수)
		return model;
	}
	
	
	/***************************** notice **************************************/
	@Override
	public Model noticeService(Model model) throws DataAccessException {
		ClubDao clubDao=sqlSession.getMapper(ClubDao.class);
		V_NoticeDao v_NoticeDao=sqlSession.getMapper(V_NoticeDao.class);
		List<ClubVo> noticeList=clubDao.selectNotice();
		List<ClubVo> noticeOneToOne=clubDao.selectOneToOne();
		List<V_NoticeVo> noticeQnA=v_NoticeDao.selectQnA();
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("noticeOneToOne", noticeOneToOne);
		model.addAttribute("noticeQnA", noticeQnA);
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
		System.out.println("newsServiceImpl"+club.getDepth());
	}

	@Override
	public void deleteNotice(int id) throws DataAccessException {
		ClubDao clubDao=sqlSession.getMapper(ClubDao.class);
		clubDao.deleteClubData(id);
	}

	@Override
	public void writeAnswer(int id,ClubVo club) throws DataAccessException {
		ClubDao clubDao=sqlSession.getMapper(ClubDao.class);
		clubDao.insertNotice(club);
		clubDao.updateRef(id);
	}


}
