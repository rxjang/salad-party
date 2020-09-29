package co.salpa.bookery.today.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import co.salpa.bookery.find.service.FindService;
import co.salpa.bookery.model.entity.UserVo;
import co.salpa.bookery.today.service.TodayPageService;

@Controller
@RequestMapping("/today")
public class TodayPageController {
	@Autowired
	TodayPageService todayPageService;
	@Autowired
	FindService findService;
	
	//bid나 stuyd_id나 둘중에 하나를 넘겨받아야함. 지금은 bid인데 수정가능.
	@RequestMapping("/page/{bid}")
	public String pageInput(Model model,@PathVariable int bid,HttpServletRequest request) { // 오늘 공부한 페이지 입력하러가기
		try {
//'2', NULL, '14466324', '시나공 정보처리기사 실기 C와 JAVA의 기,산업기사 포함,2019', '3', '2020-09-19 00:18:31', NULL, '2020-09-01', '2020-10-01', '2020-10-17', NULL, 'page', NULL, NULL, NULL, '30', '21', '1200', '840', '680', NULL, NULL, '56.6667', '80.9524', '56.6667', '80.9524'
			
			HttpSession session = request.getSession();
			UserVo user = (UserVo) session.getAttribute("user");
			findService.getBookService(bid, model);
			todayPageService.getV_StudyService(user.getId(), bid, model);//파라미터 userid와 bid
			
			//오늘의 메뉴에서 목표설정 >> 플랜페이지가 생김. >> 목표설정 후 페이지 입력 버튼 누르면 여기로옴.
			//그럼 study_id도 받을 수 있고 study id를 이용해서 plan page 구간값을 얻을 수 있다. >>오늘 하루 공부 % 나타내기위한값
			todayPageService.getTodayProgress(model, 3);
		
		} catch (DataAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/today/page";
	}// pageInput

	@RequestMapping("/page/check/{study_id}/{page}")
	public String pageResult(@PathVariable int study_id,@PathVariable int page) { // 오늘 공부한 페이지 수 입력
		
		try {
			todayPageService.checkPageService(page, study_id);
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null;//에러처리
		}
		return null;
	}// pageInput
	
	@RequestMapping("/page/check/{bid}")
	public String pageResult(@PathVariable int bid, Model model) { //페이지 입력 결과 보기
		//1. 미달성
		//2. 달성
		//3. 초과달성   v_study 조회해야함. 스터디 id와 북 id 필요.
		try {
			todayPageService.getV_StudyService(2, bid, model);
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null; //에러 처리
		}
		return "/today/pageChecked";
	}// pageInput
	
	

}// ClassEnd