package co.salpa.bookery.today.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;

import co.salpa.bookery.model.CheckChapDao;
import co.salpa.bookery.model.StudyDao;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.CheckChapVo;
import co.salpa.bookery.model.entity.V_StudyVo;

@Service
public class TodayServiceImpl implements TodayService {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Model listTodayStudiesService(int user_id, Model model) throws SQLException {
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		List<V_StudyVo> list=v_studyDao.selectActiveByUserId(user_id);
		model.addAttribute("studies", list);
		return model;
	}
	
	public List<Integer> listStudy_IDService(int user_id) throws SQLException{
		StudyDao studyDao=sqlSession.getMapper(StudyDao.class);
		List<Integer> list=studyDao.selectIdByUserId(user_id);
		return list;
	}
	
	@Override
	public Model listCheckChapService(int user_id,Model model) throws SQLException {
//		TodayServiceImpl todayServiceImpl=new TodayServiceImpl();
		List<Integer> list=listStudy_IDService(user_id);
		Map<Integer,List<CheckChapVo>> map=new HashMap<Integer,List<CheckChapVo>>();
		for(Integer i : list) {
			CheckChapDao checkChapDao=sqlSession.getMapper(CheckChapDao.class);
			List<CheckChapVo> list2=checkChapDao.selectAllByStudyId(i);
			map.put(i, list2);
		}
		model.addAttribute("checkchap", map);
		return model;
	}
}