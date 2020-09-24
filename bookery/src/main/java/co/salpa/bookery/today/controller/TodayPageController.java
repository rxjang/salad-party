package co.salpa.bookery.today.controller;

import java.sql.Date;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import co.salpa.bookery.find.service.FindService;
import co.salpa.bookery.model.entity.V_StudyVo;
import co.salpa.bookery.today.service.TodayPageService;

@Controller
@RequestMapping("/today")
public class TodayPageController {
	@Autowired
	TodayPageService todayPageService;
	@Autowired
	FindService findService;
	
	
	@RequestMapping("/page/{bid}")
	public String pageInput(Model model,@PathVariable int bid) { // 오늘 공부한 페이지 입력하러가기
		try {
//'2', NULL, '14466324', '시나공 정보처리기사 실기 C와 JAVA의 기,산업기사 포함,2019', '3', '2020-09-19 00:18:31', NULL, '2020-09-01', '2020-10-01', '2020-10-17', NULL, 'page', NULL, NULL, NULL, '30', '21', '1200', '840', '680', NULL, NULL, '56.6667', '80.9524', '56.6667', '80.9524'
			findService.getBookService(bid, model);
			todayPageService.getV_StudyService(2, 14466324, model);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/today/page";
	}// pageInput

	@RequestMapping("/page/check/{study_id}/{page}")
	public String pageResult(@PathVariable int study_id,@PathVariable int page) { // 오늘 공부한 페이지 수 입력 결과보기
		
		try {
			todayPageService.checkPageService(page, study_id);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;//에러 났을 경우 보낼 페이지 정하기.
		}
		return null;
	}// pageInput
	
	@RequestMapping("/page/check/{bid}")
	public String pageResult(@PathVariable int bid, Model model) { // 오늘 공부량 체크.
		//1. 미달성
		//2. 달성
		//3. 초과달성   v_study 조회해야함. 스터디 id와 북 id 필요.
		try {
			todayPageService.getV_StudyService(2, bid, model);
		} catch (SQLException e) {
			e.printStackTrace();
			return null; //에러 처리
		}
		return "/today/pageResult";
	}// pageInput
	
	

}// ClassEnd