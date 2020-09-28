package co.salpa.bookery.mylib.service;


import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import co.salpa.bookery.model.CheckPageDao;
import co.salpa.bookery.model.StudyDao;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.CheckPageVo;
import co.salpa.bookery.model.entity.StudyVo;
import co.salpa.bookery.model.entity.V_StudyVo;

@Service
public class MylibServiceImpl implements MylibService {

	@Autowired
	SqlSession sqlSession;
	
	//mylib페이지 미독, 미완독, 완독 책 권수, 정보 출력
	@Override
	public Model myLibService(Model model) throws DataAccessException{
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		List<V_StudyVo> noGoalBookList=v_studyDao.selectNoGoalBook(3);
		model.addAttribute("nogoalbooklist", noGoalBookList);//임시로 회원번호 3 넣어놓음 로그인 기능 구현시 변경 예정
		List<V_StudyVo> studyingBookList=v_studyDao.selectStudyingBook(3);
		model.addAttribute("studyingbooklist", studyingBookList);
		List<V_StudyVo> finishedBookList=v_studyDao.selectFinishedBook(3);
		model.addAttribute("finishedbooklist",finishedBookList);
		
		model.addAttribute("countnogoalbook",v_studyDao.countNoGoalBook(3));
		model.addAttribute("countstudyingbook",v_studyDao.countStudyingBook(3));
		model.addAttribute("countfinishedbook",v_studyDao.countFinishedBook(3));
		return model;
	}
	
	//page목표 설정 페이지에서 해당 스터디id의 책 정보 출력
	@Override
	public Model selectStudyService(int study_id, Model model) throws DataAccessException {
		V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
		V_StudyVo v_studyVo=v_studyDao.selectOneByStudyId(study_id);
		model.addAttribute("v_study", v_studyVo);
		return null;
	}

	//page 목표설정 값을 study테이블과 checkPage테이블에 입력
	@Override
	public void insertPagePlanService(StudyVo study, int StudyDay,int planPage) throws DataAccessException{
		StudyDao studyDao=sqlSession.getMapper(StudyDao.class);
		CheckPageDao checkPageDao=sqlSession.getMapper(CheckPageDao.class);
		studyDao.assertPlan(study);	//기본적인 정보(시작날짜, 끝나는 날짜, type 입력)
		insertToCheckPage(checkPageDao, study, StudyDay, planPage);
	}

	//page 목표설정 데어터를 날짜별로 테이블에 삽입
	public void insertToCheckPage(CheckPageDao dao,StudyVo study,int StudyDay,int planPage) {
		//studyDay는 enddate-startdate+1한 값으로 실제 공부할 날-자바스크립트로 계산해서 받아옴
		Date startDate=study.getStartdate();//study테이블에서 시작날짜 가져옴
		Date tempDate=startDate;//인서트할 값
		for(int i=0;i<StudyDay;i++) {
			CheckPageVo bean=new CheckPageVo(tempDate,planPage,study.getId());
			dao.insertOne(bean);
			tempDate=nextDay(tempDate);
		}
		
		
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

}
