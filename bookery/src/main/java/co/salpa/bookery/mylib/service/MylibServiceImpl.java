package co.salpa.bookery.mylib.service;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import co.salpa.bookery.model.MylibDao;

@Service
public class MylibServiceImpl implements MylibService {

	@Autowired
	SqlSession sqlSession;
	
	//목표설정 되지 않은 책 반환
	@Override
	public Model listNoGoalBookService(Model model) throws DataAccessException{
		MylibDao mylibDao=sqlSession.getMapper(MylibDao.class);
		return model.addAttribute("nogoalbook", mylibDao.selectNoGoalBook(3));//임시로 회원번호 3 넣어놓음 로그인 기능 구현시 변경 예정
	}

	@Override
	public Model listStudyinglBookService(Model model) throws DataAccessException {
		MylibDao mylibDao=sqlSession.getMapper(MylibDao.class);
		return model.addAttribute("studyingbook",mylibDao.selectStudyingBook(3));
	}

	@Override
	public Model listFinishedlBookService(Model model) throws DataAccessException {
		MylibDao mylibDao=sqlSession.getMapper(MylibDao.class);
		return model.addAttribute("finishedbook",mylibDao.selectFinishedBook(3));
	}

}
