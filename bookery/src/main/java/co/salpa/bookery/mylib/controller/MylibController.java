package co.salpa.bookery.mylib.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import co.salpa.bookery.account.service.AccountService;
import co.salpa.bookery.model.entity.StudyVo;
import co.salpa.bookery.model.entity.UserVo;
import co.salpa.bookery.model.entity.V_StudyVo;
import co.salpa.bookery.mylib.service.MylibService;

@RequestMapping("/mylib")
@Controller
public class MylibController {
	
	@Autowired MylibService mylibService;
	@Autowired AccountService accountService;
	
	@RequestMapping
	public String myLib(Model model, HttpServletRequest request) throws DataAccessException {
		HttpSession session = request.getSession();
		UserVo user = (UserVo) session.getAttribute("user");
		V_StudyVo v_study = new V_StudyVo();
		v_study.setUser_id(user.getId());
		mylibService.myLibService(model,v_study.getUser_id());
		return "mylib/mylib";
	}
	
	@RequestMapping("/{study_id}")
	public String mylib(@PathVariable int study_id,Model model) {
		mylibService.selectStudyService(study_id, model);
		return "mylib/detail";
	}
	
	
	/************************************ plan-page ***********************************************/
	
	@RequestMapping(value="/plan/page/{study_id}")
	public String mylibPlanPage(@PathVariable int study_id,Model model,HttpSession session) {
		Boolean boo=accountService.checkUser(session, study_id);
		Boolean boo2=mylibService.checkPlan(study_id);
		if(boo&&boo2) {
			mylibService.selectStudyService(study_id, model);
			return "mylib/plan-page";
		}else {
			return "redirect:../../../error";
		}
	}
	
	@RequestMapping(value = "/plan/page",method = RequestMethod.POST)
	public String insertPagePlan(@ModelAttribute StudyVo study,int studyDay, int planPage) {
		System.out.println(study.getEnddate());
		int study_id=study.getId();
		mylibService.insertPagePlanService(study, studyDay, planPage);
		return "redirect:../../today/page/"+study_id;
	}
	
	@RequestMapping(value="/plan/chap/{study_id}")
	public String mylibChapPlan(@PathVariable int study_id, Model model) {
		mylibService.selectChapStudyService(study_id, model);
		return "mylib/plan-chap";
	}
	
	@RequestMapping(value = "/plan/chap",method = RequestMethod.POST)
	public String insertChapPlan(@ModelAttribute StudyVo study,int studyDay, int planChap, @RequestParam(value="toc") List<String> toc) {
		// 목차 개수와 목차명, 하루에 진행할 chap개수, (StudyVO)startdate enddate 모두 가져오기
	
		for(String tocItem : toc) {
			System.out.println(tocItem);
		}
		System.out.println(planChap);
		System.out.println(study.getStartdate());
		System.out.println(study.getEnddate());
		mylibService.insertChapPlanService(study, planChap, toc);
		
		return "redirect:../../today/chap/"+study.getBook_bid();
	}
	

	/************************************ award ***********************************************/

	@RequestMapping("/award")
	public String awards(Model model,HttpSession session) {
		UserVo user=(UserVo) session.getAttribute("user");
		int user_id=user.getId();
		mylibService.awardService(model,user_id);
		return "mylib/award";
	}
}
