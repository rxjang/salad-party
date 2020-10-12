package co.salpa.bookery.today.service;

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
public class TodayServiceImpl implements TodayService {
	
	@Autowired
	SqlSession sqlSession;
	
	ObjectMapper mapper=new ObjectMapper();
	
	@Override
	public Model todayService(int user_id, Model model) throws SQLException, JsonProcessingException{
		// 로그인 user_id에 해당하는 진행중인 study_id 목록 전달
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		List<V_StudyVo> list_v_study=new ArrayList<V_StudyVo>();
		list_v_study=v_studyDao.selectActiveByUserId(user_id);
		model.addAttribute("studyList", list_v_study);
		
		return model;
	}

	@Override
	public Object todayChartService(int study_id) throws JsonProcessingException {
		// 책 표지 눌렀을때 해당 차트 자료 전달
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		V_StudyVo v_study=new V_StudyVo();
		v_study=v_studyDao.selectOneByStudyId(study_id);
		
		V_CalendarDao v_calendarDao=sqlSession.getMapper(V_CalendarDao.class);
		List<V_CalendarVo> list_v_calendar=new ArrayList<V_CalendarVo>();
		list_v_calendar=v_calendarDao.selectAllByStudyId(study_id);

		Map<String,Object> map=new HashMap<String,Object>();
		map.put("study", v_study);
		map.put("calList", list_v_calendar);
		map.put("code","OK");
		
//		String jsonStr=mapper.writeValueAsString(map);
		
		return map;
	}
}