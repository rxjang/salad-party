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
	@RequestMapping("/page/{study_id}")
	public String pageInput(Model model,@PathVariable int study_id,HttpServletRequest request) { // 오늘 공부한 페이지 입력하러가기
		try {
			HttpSession session = request.getSession();
			UserVo user = (UserVo) session.getAttribute("user");
			todayPageService.getV_StudyService(study_id, model);//파라미터 userid와 bid
		} catch (DataAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/today/page";
	}// pageInput

	@RequestMapping("/page/check/{study_id}/{page}")
	@ResponseBody
	public String pageResult(@PathVariable int study_id,@PathVariable int page) { // 오늘 공부한 페이지 수 입력
		
		try {
			todayPageService.checkPageService(page, study_id);
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null;//에러처리
		}
		return null;
	}// pageInput
	
	@RequestMapping("/page/check/{study_id}")
	public String pageResult(@PathVariable int study_id, Model model) { //페이지 입력 결과 보기
		//1. 미달성
		//2. 달성
		//3. 초과달성   v_study 조회해야함. 스터디 id와 북 id 필요.
		try {
			todayPageService.getV_StudyService(study_id, model);
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null; //에러 처리
		}
		return "/today/pageChecked";
	}// pageInput
	
}// ClassEnd