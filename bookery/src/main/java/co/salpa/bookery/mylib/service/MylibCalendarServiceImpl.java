package co.salpa.bookery.mylib.service;

import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.V_StudyVo;

@Service
public class MylibCalendarServiceImpl implements MylibCalendarService {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Model selectStudyService(int study_id, Model model) throws SQLException {
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		V_StudyVo v_studyVo=v_studyDao.selectOneByStudyId(study_id);
		return model.addAttribute("v_study", v_studyVo);
	}

}
