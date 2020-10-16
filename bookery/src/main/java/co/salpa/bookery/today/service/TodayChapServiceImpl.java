package co.salpa.bookery.today.service;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import co.salpa.bookery.model.CheckChapDao;
import co.salpa.bookery.model.CheckPageDao;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.CheckChapVo;
import co.salpa.bookery.model.entity.CheckPageVo;
import co.salpa.bookery.model.entity.V_StudyVo;
import co.salpa.bookery.today.controller.TodayChapController;

@Transactional
@Service
public class TodayChapServiceImpl implements TodayChapService {

	@Autowired
	SqlSession sqlSession;
	
	/**
	 *  sql type 오늘 날짜 구하기 2020-09-24
	 */
	public Date getSqlToday() {
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
		Date today = Date.valueOf(sdf.format(new java.util.Date()));
		
		return today;
	}//getSqlToday
	
	/*
	 *  모든 스터디객체를 담는 리스트 반환
	 */
	
	@Override
	public Model listV_StudyService(Model model) throws DataAccessException {
		V_StudyDao v_studyDao = sqlSession.getMapper(V_StudyDao.class);
		List<V_StudyVo> list = v_studyDao.selectAll();
		model.addAttribute("list", list);
		return model;
	}// listV_StudyService

	@Override
	public Model getV_StudyService(int study_id, Model model) throws DataAccessException {
		V_StudyDao v_studyDao = sqlSession.getMapper(V_StudyDao.class);
		model.addAttribute("v_study", v_studyDao.selectOneByStudyId(study_id));
		return model;
	}// getV_StudyService

	@Override
	public void checkChapService(List<Integer> selectChap, int study_id) throws DataAccessException {
		CheckChapDao checkChapDao = sqlSession.getMapper(CheckChapDao.class);
		
		for(int i=0; i < selectChap.size(); i++) {
			checkChapDao.updateOne(selectChap.get(i));			
		}
		checkChapDao.updateTimeStudy(study_id);
	}// checkPageService

	/*
	 * 오늘 공부한 챕터의 수, 하루에 공부해야 할 챕터의 수를 이용해 오늘 공부량 달성 여부를 백분률로 반환
	 * 가장 최근에 입력한 페이지수. 오늘까지 해야할 페이지. 등일 전달하여 공부 진행상황을
	 * chart로 나타낼 수 있게 함
	 * 
	 */
	@Override
	public Model getTodayProgress(Model model, int study_id) throws DataAccessException {
		//전체 목차 개수 ${v_study.total_chap}
		//비어있다면 0% 입력한적이 있다면 0 ~ 100% 또는 초과달성이면 100%이상이 될 것
		//checkchap 테이블에서 plantime이 오늘날짜인 것들의 개수 "actual_chap"
		//checkchap 테이블에서 actualtime이 오늘날짜인 것들의 개수 "plan_chap"
		CheckChapDao checkChapDao = sqlSession.getMapper(CheckChapDao.class);
		Map<String, String> map1 = new HashMap<String, String>();
			map1.put("study_id", study_id+"");
			map1.put("actualtime", getSqlToday()+""); // 오늘 날짜
		int today_actual_chap = 0;
		try {// actualtime이 오늘 날짜인(입력된) chap의 개수
			today_actual_chap = checkChapDao.selectActualChapsToday(map1);
			System.out.println(getSqlToday());
			System.out.println(today_actual_chap);
		} catch (Exception e) {
			today_actual_chap = 0; //null이면 0으로 처리
		}
		
		Map<String, String> map2 = new HashMap<String, String>();
		map2.put("study_id", study_id+"");
		map2.put("plantime", getSqlToday()+""); // 오늘 날짜
		
		int today_plan_chap = 0;
		try {
			today_plan_chap = checkChapDao.selectPlanChapsToday(map2);
			System.out.println(today_plan_chap);
		} catch (Exception e) {
			today_plan_chap = 0; //null이면 0으로 처리
		}
		
		List<CheckChapVo> listChap = checkChapDao.selectAllByStudyId(study_id);

		model.addAttribute("listChap", listChap); //챕터 리스트
		model.addAttribute("today_plan_chap", today_plan_chap); // 계획된 날짜가 오늘인 챕터
		model.addAttribute("today_actual_chap", today_actual_chap);// 오늘 입력된 챕터
	
		return null;
	}

}
