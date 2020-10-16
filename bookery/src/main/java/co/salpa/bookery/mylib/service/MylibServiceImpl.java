package co.salpa.bookery.mylib.service;

import java.sql.Date;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.salpa.bookery.model.BookDao;
import co.salpa.bookery.model.CheckChapDao;
import co.salpa.bookery.model.CheckPageDao;
import co.salpa.bookery.model.MedalDao;
import co.salpa.bookery.model.StudyDao;
import co.salpa.bookery.model.TocDao;
import co.salpa.bookery.model.V_AwardsDao;
import co.salpa.bookery.model.V_CalendarDao;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.CheckChapVo;
import co.salpa.bookery.model.entity.CheckPageVo;
import co.salpa.bookery.model.entity.MedalVo;
import co.salpa.bookery.model.entity.StudyVo;
import co.salpa.bookery.model.entity.TocVo;
import co.salpa.bookery.model.entity.UserVo;
import co.salpa.bookery.model.entity.V_AwardsVo;
import co.salpa.bookery.model.entity.V_CalendarVo;
import co.salpa.bookery.model.entity.V_StudyVo;

@Service
public class MylibServiceImpl implements MylibService {

	@Autowired
	SqlSession sqlSession;
	
	ObjectMapper objectMapper=new ObjectMapper();
	
	//mylib페이지 미독, 미완독, 완독 책 권수, 정보 출력
	@Override
	public Model myLibService(Model model, int user_id) throws DataAccessException{
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		List<V_StudyVo> noGoalBookList=v_studyDao.selectNoGoalBook(user_id);
		model.addAttribute("nogoalbooklist", noGoalBookList);
		List<V_StudyVo> studyingBookList=v_studyDao.selectStudyingBook(user_id);
		model.addAttribute("studyingbooklist", studyingBookList);
		List<V_StudyVo> finishedBookList=v_studyDao.selectFinishedBook(user_id);
		model.addAttribute("finishedbooklist",finishedBookList);
		
		model.addAttribute("countnogoalbook",v_studyDao.countNoGoalBook(user_id));
		model.addAttribute("countstudyingbook",v_studyDao.countStudyingBook(user_id));
		model.addAttribute("countfinishedbook",v_studyDao.countFinishedBook(user_id));
		return model;
	}
	
	//page목표 설정 페이지에서 해당 스터디id의 책 정보 출력
	@Override
	public Model selectStudyService(int study_id, Model model) throws DataAccessException {
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		V_CalendarDao v_CalendarDao=sqlSession.getMapper(V_CalendarDao.class);
		BookDao bookDao=sqlSession.getMapper(BookDao.class);
		V_StudyVo v_studyVo=v_studyDao.selectOneByStudyId(study_id);
		List<V_CalendarVo> list=v_CalendarDao.selectFinData(study_id);
		BookVo bookVo=bookDao.selectOneByStudyId(study_id);
		Map<String,List<V_CalendarVo>> map=new HashMap<String,List<V_CalendarVo>>();
		map.put("key", list);
		String jsonStr=null;
		try {
			jsonStr = objectMapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		model.addAttribute("v_study", v_studyVo);
		model.addAttribute("finData", jsonStr);
		model.addAttribute("bookInfo", bookVo);
		return null;
	}

	/************************************ plan-page ***********************************************/
	//page 목표설정 값을 study테이블과 checkPage테이블에 입력
	@Override
	public void insertPagePlanService(StudyVo study, int StudyDay,int planPage) throws DataAccessException{
		StudyDao studyDao=sqlSession.getMapper(StudyDao.class);
		CheckPageDao checkPageDao=sqlSession.getMapper(CheckPageDao.class);
		studyDao.assertPlan(study);	//기본적인 정보(시작날짜, 끝나는 날짜, type 입력)
		insertToCheckPage(checkPageDao, study, StudyDay, planPage);
	}

	//page 목표설정 데어터를 날짜별로 테이블에 삽입
	public void insertToCheckPage(CheckPageDao dao,StudyVo study,int StudyDay,int planPage) throws DataAccessException {
		BookDao bookDao=sqlSession.getMapper(BookDao.class);
		//studyDay는 enddate-startdate+1한 값으로 실제 공부할 날-자바스크립트로 계산해서 받아옴
		Date  startDate=study.getStartdate();//study테이블에서 시작날짜 가져옴
		Date tempDate=startDate;//인서트할 값
		int tempPage=planPage;
		for(int i=0;i<StudyDay-1;i++) {
			CheckPageVo bean=new CheckPageVo(tempDate,tempPage,study.getId());
			dao.insertOne(bean);
			tempDate=nextDay(tempDate);
			tempPage+=planPage;
		}
		//마지막 날 입력
		int bid=study.getBook_bid();
		BookVo bean=bookDao.selectOne(bid);
		int pages=bean.getPages();
		tempDate=lastDay(startDate,StudyDay);
		CheckPageVo pageVo=new CheckPageVo(tempDate,pages,study.getId());
		dao.insertOne(pageVo);
		
	}

	//다음날짜 구하는 함수
	private Date nextDay(java.util.Date date){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DATE,1);
		date=calendar.getTime();
		Date nextday=new Date(date.getTime());
		return nextday;
	}
	
	//마지막 날 구하는 함수
	private Date lastDay(java.util.Date date,int studyDay){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DATE,studyDay-1);
		date=calendar.getTime();
		Date nextday=new Date(date.getTime());
		return nextday;
	}

	//chap 목표 설정 페이지에서 해당 스터디id의 책 정보 출력
		@Override
		public Model selectChapStudyService(int study_id, Model model) throws DataAccessException {
			V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
			V_StudyVo v_studyVo=v_studyDao.selectOneByStudyId(study_id);
			// 목차 가져오기
			TocDao tocDao = sqlSession.getMapper(TocDao.class);
			List<TocVo> tocList = tocDao.selectOne(v_studyVo.getBook_bid());
			model.addAttribute("v_study", v_studyVo);
			model.addAttribute("tocList", tocList);
			return null;
		}
		
		@Override
		public void insertChapPlanService(StudyVo study, int planChap, List<String> tocs) throws DataAccessException {
			StudyDao studyDao=sqlSession.getMapper(StudyDao.class);
			CheckChapDao checkChapDao = sqlSession.getMapper(CheckChapDao.class);
			studyDao.assertPlan(study);	//기본적인 정보(시작날짜, 끝나는 날짜, type 입력)
			insertToCheckChap(checkChapDao, study, planChap, tocs);
			
		}

		public void insertToCheckChap(CheckChapDao checkChapDao, StudyVo study, int planChap, List<String> tocs) {
			Date startDate = study.getStartdate();//study테이블에서 시작날짜 가져옴
			Date tempDate = startDate;
			int tempChap = planChap;
			for(int i=0 ; i<tocs.size();i++) {
				
				if(tempChap == 0) 
					tempChap = planChap;
				if(i!=0 && tempChap == planChap) 
					tempDate = nextDay(tempDate);
				
				CheckChapVo bean=new CheckChapVo();
				bean.setToc(tocs.get(i));
				bean.setPlantime(tempDate);
				bean.setStudy_id(study.getId());
				checkChapDao.insertOne(bean);
				tempChap--;
			}
		}
		
	/************************************ award ***********************************************/
	@Override
	public Model awardService(Model model,int user_id) throws DataAccessException {
		MedalDao medalDao=sqlSession.getMapper(MedalDao.class);
		V_AwardsDao v_AwardsDao=sqlSession.getMapper(V_AwardsDao.class);
		List<MedalVo> medalList=medalDao.selectAllMedal();
		List<V_AwardsVo> awardList=v_AwardsDao.selectAchieveMedal(user_id);
		Map<String,List<MedalVo>> medalMap=new HashMap<String,List<MedalVo>>();
		Map<String,List<V_AwardsVo>> awardMap=new HashMap<String,List<V_AwardsVo>>();
		medalMap.put("medalKey", medalList);
		awardMap.put("awardKey", awardList);
		
		String jsonMedal=null;
		String jsonAward=null;
		try {
			jsonMedal = objectMapper.writeValueAsString(medalMap);
			jsonAward = objectMapper.writeValueAsString(awardMap);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		model.addAttribute("medalList", medalList);
		model.addAttribute("awardList", awardList);
		model.addAttribute("medalJson", jsonMedal);
		model.addAttribute("awardJson", jsonAward);
		model.addAttribute("countAchieveMedal", v_AwardsDao.countAchieveMedal(user_id));
		return null;
	}

	@Override
	public Boolean checkPlan(int study_id) throws DataAccessException {
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		V_StudyVo v_StudyVo=v_studyDao.selectOneByStudyId(study_id);
		if(v_StudyVo != null) {
			Date startDate=v_StudyVo.getStartdate();
			if(startDate==null) {
				return true;
			}else {
				return false;
			}
		} else {
			return false;
		}
		
	}

}
