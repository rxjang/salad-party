package co.salpa.bookery.mylib.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import co.salpa.bookery.model.V_CalendarDao;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.V_CalendarVo;
import co.salpa.bookery.model.entity.V_StudyVo;

@Service
public class MylibCalendarServiceImpl implements MylibCalendarService {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Model calendarService(int user_id, Model model) throws SQLException {
		V_CalendarDao v_calendarDao=sqlSession.getMapper(V_CalendarDao.class);
		List<V_CalendarVo> list=v_calendarDao.selectAllByUserId(user_id);
		model.addAttribute("cals", list);
		return model;
	}
}
