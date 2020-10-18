package co.salpa.bookery.mylib.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.salpa.bookery.account.service.AccountService;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.UserVo;
import co.salpa.bookery.model.entity.V_StudyVo;
import co.salpa.bookery.mylib.service.MylibCalendarService;
import co.salpa.bookery.mylib.service.MylibPlanService;

@Controller
public class MylibCalendarController {

	@Autowired
	MylibCalendarService mylibCalendarService;
	@Autowired
	MylibPlanService mylibPlanService;
	@Autowired
	AccountService accountService;
	
	@RequestMapping("/mylib/calendar")
	public String calendar(Model model, HttpSession session) throws SQLException, JsonProcessingException {
		UserVo user=(UserVo) session.getAttribute("user");
		int user_id=user.getId();
		mylibCalendarService.calendarService(user_id, model);
		return "/mylib/calendar";
	}
	@RequestMapping("/mylib/{type}/{study_id}")
	public String todayPlan(HttpSession session,@PathVariable String type,@PathVariable int study_id,Model model) throws SQLException {
		Boolean boo=accountService.checkUser(session, study_id);// log-in user == study user
		Boolean boo2=mylibCalendarService.checkActive(study_id);// progress rate < 100; true : active; false : completed
		System.out.println(study_id);
		System.out.println(boo);
		System.out.println(boo2);
		
		if(boo && boo2) {
			mylibPlanService.selectStudyService(study_id,model);
			return "/today/{type}/{study_id}";
		}else if(boo && !boo2){
			return "/mylib";
		}
		else {
			return "redirect:../../error";
		}
	}
}