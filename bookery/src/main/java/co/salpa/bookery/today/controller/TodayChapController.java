package co.salpa.bookery.today.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.salpa.bookery.account.service.AccountService;
import co.salpa.bookery.find.service.FindService;
import co.salpa.bookery.model.entity.UserVo;
import co.salpa.bookery.today.service.TodayChapService;

@Controller
@RequestMapping("/today")
public class TodayChapController {
	@Autowired
	TodayChapService todayChapService;
	@Autowired
	FindService findService;
	@Autowired
	AccountService accountService;
	
	@RequestMapping("/chap/{study_id}")
	public String chapInput(HttpSession session, Model model, @PathVariable int study_id) { // 오늘 공부한 챕터 입력하러가기
		
			Boolean boo = accountService.checkUser(session, study_id);
			Boolean boo2 = todayChapService.checkPlan(study_id);
			
			if(boo && boo2) {
				todayChapService.getV_StudyService(study_id, model);//파라미터 userid와 bid
				//오늘의 메뉴에서 목표설정 >> 플랜페이지가 생김. >> 목표설정 후 페이지 입력 버튼 누르면 여기로옴.
				//그럼 study_id도 받을 수 있고 study id를 이용해서 plan page 구간값을 얻을 수 있다. >>오늘 하루 공부 % 나타내기위한값
				todayChapService.getTodayProgress(model, study_id);
				
				return "/today/chap";
			} else {
				return "redirect:../../error";
			}
	}// chapInput
	
	@RequestMapping("/chap/process/{study_id}")
	@ResponseBody
	public String chapResult(@PathVariable int study_id,@RequestParam(value="chaps") List<Integer> chaps) { // 오늘 공부한 챕터 입력
		
		try {
			todayChapService.checkChapService(chaps, study_id);
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null;//에러처리
		}
		return null;
		
	}// chapInput
	
	@RequestMapping("/chap/check/{study_id}")
	public String chapResult(@PathVariable int study_id, HttpSession session, Model model) { //페이지 입력 결과 보기
		
		Boolean boo = accountService.checkUser(session, study_id);
		Boolean boo2 = todayChapService.checkPlan(study_id);
		if(boo && boo2) {
			//1. 미달성
			//2. 달성
			//3. 초과달성   v_study 조회해야함. 스터디 id 필요.
			todayChapService.getV_StudyService(study_id, model);
			
			return "/today/chapChecked";
		} else {
			return "redirect:../../error";
		}
	}// chapResult
	

}
