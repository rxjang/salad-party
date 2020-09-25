package co.salpa.bookery.mylib.service;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.V_StudyVo;

@Service
public class MylibServiceImpl implements MylibService {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Model myLibService(Model model) throws DataAccessException{
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		List<V_StudyVo> noGoalBookList=v_studyDao.selectNoGoalBook(3);
		model.addAttribute("nogoalbooklist", noGoalBookList);//임시로 회원번호 3 넣어놓음 로그인 기능 구현시 변경 예정
		List<V_StudyVo> studyingBookList=v_studyDao.selectStudyingBook(3);
		model.addAttribute("studyingbooklist", studyingBookList);
		List<V_StudyVo> finishedBookList=v_studyDao.selectFinishedBook(3);
		model.addAttribute("finishedbooklist",finishedBookList);
		
		model.addAttribute("countnogoalbook",v_studyDao.countNoGoalBook(3));
		model.addAttribute("countstudyingbook",v_studyDao.countStudyingBook(3));
		model.addAttribute("countfinishedbook",v_studyDao.countFinishedBook(3));
		return model;
	}


}
