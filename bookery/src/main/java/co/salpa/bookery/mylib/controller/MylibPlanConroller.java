package co.salpa.bookery.mylib.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import co.salpa.bookery.account.service.AccountService;
import co.salpa.bookery.mylib.service.MylibPlanService;

@Controller
public class MylibPlanConroller {

	@Autowired
	MylibPlanService mylibPlanService;
	@Autowired
	AccountService accountService;
	
	@RequestMapping("/mylib/plan/{study_id}")
	public String plan(HttpSession session, @PathVariable int study_id,Model model) throws SQLException {
		Boolean boo=accountService.checkUser(session, study_id);
		Boolean boo2=mylibPlanService.checkPlan(study_id);
		if(boo && boo2) {
			mylibPlanService.selectStudyService(study_id,model);
			return "/mylib/plan";
		}
		else {
			return "redirect:../../error";
		}
	}
}