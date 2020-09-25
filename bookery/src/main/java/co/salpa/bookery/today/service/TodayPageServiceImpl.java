package co.salpa.bookery.today.service;

import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import co.salpa.bookery.model.CheckPageDao;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.CheckPageVo;
import co.salpa.bookery.model.entity.V_StudyVo;

@Transactional
@Service
public class TodayPageServiceImpl implements TodayPageService {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Model listV_StudyService(Model model) throws SQLException {
		V_StudyDao v_studyDao = sqlSession.getMapper(V_StudyDao.class);
		List<V_StudyVo> list = v_studyDao.selectAll();
		model.addAttribute("list", list);
		return model;
	}//listV_StudyService

	
	/*
	 *	user_id와 책 bid로 공부중인 책 정보를 받아온다. 오늘의 진도 페이지 입력페이지에서
	 *	책 정보와 공부 진행 상황을 나타낸다.
	 * 	
	 */
	@Override
	public Model getV_StudyService(int user_id,int bid, Model model) throws SQLException {
		V_StudyDao v_studyDao = sqlSession.getMapper(V_StudyDao.class);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("user", user_id);
		map.put("bid", bid);
		model.addAttribute("v_study", v_studyDao.selectOne(map));
		return model;
	}//getV_StudyService

	
	/**
	 *  checkpage 테이블에서 study_id와 date를 이용해 업데이트해야하는 레코드를 찾아
	 *  공부한 페이지 actualpage를 입력한다.
	 */
	@Override
	public void checkPageService(int actualpage, int study_id) throws SQLException {
		CheckPageDao checkPageDao = sqlSession.getMapper(CheckPageDao.class);
		
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
		Date today = Date.valueOf(sdf.format(new java.util.Date()));
		
		checkPageDao.updateOne(new CheckPageVo(actualpage, study_id, today, 0));
	}//checkPageService

}//classEnd