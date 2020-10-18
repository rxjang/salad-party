package co.salpa.bookery.mylib.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.salpa.bookery.model.V_CalendarDao;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.V_CalendarVo;
import co.salpa.bookery.model.entity.V_StudyVo;

@Service
public class MylibCalendarServiceImpl implements MylibCalendarService {
	
	@Autowired
	SqlSession sqlSession;

	ObjectMapper mapper=new ObjectMapper();
	
	@Override
	public Model calendarService(int user_id, Model model) throws SQLException, JsonProcessingException {
		V_CalendarDao v_calendarDao=sqlSession.getMapper(V_CalendarDao.class);
		List<V_CalendarVo> list=v_calendarDao.selectAllByUserId(user_id);
		Map<String, List<V_CalendarVo>> map=new HashMap<>();
		map.put("cal", list);
		
		String jsonStr=mapper.writeValueAsString(map);
		
		model.addAttribute("map", jsonStr);
		return model;
	}
	
	@Override
	public Boolean checkActive(int study_id) {
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		V_StudyVo v_study=new V_StudyVo();
		v_study=v_studyDao.selectOneByStudyId(study_id);
		double progress=v_study.getProgress_rate();
		if(progress<100) return true;
		else return false;
	}
}
