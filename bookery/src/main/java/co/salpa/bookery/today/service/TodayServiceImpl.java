package co.salpa.bookery.today.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.V_StudyVo;

@Service
public class TodayServiceImpl implements TodayService {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Model listTodayStudiesService(int user_id,Model model) throws SQLException {
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		List<V_StudyVo> list=v_studyDao.selectActiveByUserId(user_id);
		model.addAttribute("studies", list);
		return model;
	}
}
//왜 안올라가지?
