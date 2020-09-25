package co.salpa.bookery.mylib.service;

import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import co.salpa.bookery.model.StudyDao;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.StudyVo;
import co.salpa.bookery.model.entity.V_StudyVo;

@Service
public class MylibPlanServiceImpl implements MylibPlanService {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Model selectStudyService(int study_id, Model model) throws SQLException {
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		V_StudyVo v_studyVo=v_studyDao.selectOneByStudyId(study_id);
		model.addAttribute("v_study", v_studyVo);
		return null;
	}
	
//	@Override
//	public Model updateTypeChapService(int study_id, Model model) {
//		StudyDao studyDao=sqlSession.getMapper(StudyDao.class);
//		StudyVo studyVo=studyDao.updateTypeChap(study_id);
//		model.addAttribute("studyChap", studyVo);
//		return model;
//	}
//
//	@Override
//	public Model updateTypePageService(int study_id, Model model) {
//		StudyDao studyDao=sqlSession.getMapper(StudyDao.class);
//		StudyVo studyVo=studyDao.updateTypePage(study_id);
//		model.addAttribute("studyPage", studyVo);
//		return model;
//	}

}
