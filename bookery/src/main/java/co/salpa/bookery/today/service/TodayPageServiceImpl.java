package co.salpa.bookery.today.service;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import co.salpa.bookery.model.CheckPageDao;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.CheckPageVo;
import co.salpa.bookery.model.entity.V_StudyVo;

@Transactional
@Service
public class TodayPageServiceImpl implements TodayPageService {

	@Autowired
	SqlSession sqlSession;

	SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");

	/**
	 *  sql type 오늘 날짜 구하기 2020-09-24
	 */
	public Date getSqlToday() {
		
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

	/*
	 * user_id와 책 bid로 공부중인 책 정보를 받아온다. 오늘의 진도 페이지 입력페이지에서 책 정보와 공부 진행 상황을 나타낸다.
	 * 
	 */
	@Override
	public Model getV_StudyService(int study_id, Model model) throws DataAccessException {
		V_StudyDao v_studyDao = sqlSession.getMapper(V_StudyDao.class);
		model.addAttribute("v_study", v_studyDao.selectOneByStudyId(study_id));
		return model;
	}// getV_StudyService

	/**
	 * checkpage 테이블에서 study_id와 date를 이용해 업데이트해야하는 레코드를 찾아 공부한 페이지 actualpage를
	 * 입력한다.
	 * 
	 */
	@Override
	public void checkPageService(int actualpage, int study_id) throws DataAccessException {
		CheckPageDao checkPageDao = sqlSession.getMapper(CheckPageDao.class);
		
		List<CheckPageVo> list = checkPageDao.selectAllByStudyId(study_id);
		ArrayList<String> arrDays = new ArrayList<String>();
		java.util.Date today = new java.util.Date();
		//java.util.Date planDay = new java.util.Date();
		
		for (CheckPageVo vo : list) {
			arrDays.add(sdf.format(vo.getDate()));
		}

		//오늘 날짜의 플랜데이가 있으면 업데이트. 없으면 인써트
		if(arrDays.contains(sdf.format(today))) {
			checkPageDao.updateOne(new CheckPageVo(actualpage, study_id, getSqlToday(), 0));//오늘날짜에 공부한페이지 입력
		}else {
			checkPageDao.insertPage(new CheckPageVo(actualpage, study_id, getSqlToday(), 0));
		}
	
		
		checkPageDao.updateTimeStudy(study_id);
	}// checkPageService


	
	/*
	 * 오늘 공부한 페이지 수, 하루에 공부해야할 페이지 수를 이용해 오늘 공부량 달성 여부를 백분률로 반환
	 * 가장 최근에 입력한 페이지수. 오늘까지 해야할 페이지. 등일 전달하여 공부 진행상황을
	 * chart로 나타낼 수 있게 함
	 * 
	 */
//	@Override
//	public Model getTodayProgress(Model model, int study_id) throws DataAccessException {
//
//		CheckPageDao checkPageDao = sqlSession.getMapper(CheckPageDao.class);
//		Map<String, Integer> map1 = new HashMap<String, Integer>();
//			map1.put("id", 1);
//			map1.put("study_id", study_id);//해당 스터디의 checkpage 테이블의 1번 레코드 planpage값 
//		Map<String, Integer> map2 = new HashMap<String, Integer>();
//			map2.put("id", 2);
//			map2.put("study_id", study_id);//해당 스터디의 checkpage 테이블의 2번 레코드 planpage값 
//		
//		//2개의 차이가 하루에 공부해야할 페이지 수, 구간
////		int plan_interval = checkPageDao.selectOneByStudyId(map2).getPlanpage() - checkPageDao.selectOneByStudyId(map1).getPlanpage();
//		int plan_interval = 40;
//		
//		//오늘 날짜의 actual_page값을 구한다. 
//		//비어있다면 0% 입력한적이 있다면 0~100% 또는 초과달성이면 100%이상이 될 것
//		//checkpage 테이블에서 오늘날짜의 actual_page
//		Map<String, String> map3 = new HashMap<String, String>();
//			map3.put("study_id",study_id+"");
//			map3.put("date",getSqlToday()+"");
//		int today_actual_page = 0;
//		int yesterday_actual_page = 0;
//		try {
//			today_actual_page = checkPageDao.selectOneByDate(map3).getActualpage();
//		} catch (Exception e) {
//			today_actual_page = 0; //null이면 0으로 처리
//		}
//		//어제 날짜의 actual page를 구하자..
//		Calendar cal = new GregorianCalendar(Locale.KOREA);
//		cal.setTime(getSqlToday());
//		cal.add(Calendar.DATE, -1);
//		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
//		String yesterday =sdf.format(cal.getTime());				//어제 날짜
//		//System.out.println(yesterday);
//		
//		Map<String, String> map4 = new HashMap<String, String>();
//		map4.put("study_id",study_id+"");
//		map4.put("date",yesterday+"");
//	//	yesterday_actual_page = checkPageDao.selectOneByDate(map4).getActualpage(); //어제날짜의 actualpage
//		//입력된 가장마지막 actualpage 값.  오늘값
//		// 오늘입력한 actualpate - 어제 플랜페이지 값이 분자가 되어야 오늘의 공부달성률이 나오는건가..
//		// 어제 960까지했어야하ㅏㅁ
//		/*
//		 * 오늘 1000페이지까지. 
//		 * 인터벌 40
//		 * 아직 입력안하면 오늘 actual 0페이지  0 - 960 / 40 = ??? 
//		 * 								오늘 공부한 페이지 964 입력>> 964-960/40 >> 4/40 >> 10% 달성률 
//		 * 																음수 일 때는 0%로 처리하자. 
//		 * 
//		 * 그러면 어제 날짜의 actual page는 필요가 없다. 오늘과 어제의 plan page가 필요함. 
//		 * 날짜로 checkpage조회는 이미 만들었으니까 planpage getter로 호출만 하면됨. 
//		 */
//	//	int today_plan_page = checkPageDao.selectOneByDate(map3).getPlanpage(); //오늘
//		int today_success_rate=0;
//		int yesterday_plan_page=-1;
//		try {
//			yesterday_plan_page = checkPageDao.selectOneByDate(map4).getPlanpage(); //어제 
//		} catch (DataAccessException | NullPointerException e1 ) {
//		}
//		today_success_rate = (today_actual_page - yesterday_plan_page)/plan_interval;
//		
//		//model.addAttribute("today_actual_page",today_actual_page);//오늘 공부한 마지막 페이지
//		//model.addAttribute("plan_interval", plan_interval);//구간
//		//구간 값을 page.jsp로 보내주면 하루공부량 달성 여부를 백분률로 나타낼 수 있다.
//		
//		//오늘제외, 마지막으로 입력한 actual page 구하기.  
//		//select max(date) from checkpage where acutalpage is not null
//		
//		int recent_actual_page = 0;
//		try {
//			recent_actual_page = checkPageDao.selectRecentChecked().getActualpage();
//		} catch (Exception e) {
//			recent_actual_page = 0; //null이면 0으로 처리
//		}
//		
//		model.addAttribute("today_actual_page", today_actual_page);//오늘 입력된 페이지
//		model.addAttribute("recent_actual_page",recent_actual_page);//오늘 제외 가장 최근 입력된 페이지
//		//if(today_success_rate<0) today_success_rate = 0;
//		model.addAttribute("today_success_rate",today_success_rate); //pageChecked.jsp에 달성률 전달
//		
//		return null;
//	}

}// classEnd