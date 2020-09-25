package co.salpa.bookery.mylib.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import co.salpa.bookery.mylib.service.MylibService;

@RequestMapping("/mylib")
@Controller
public class MylibController {
	
	@Autowired MylibService mylibService;
	
	@RequestMapping
	public String myLib(Model model) throws DataAccessException {
		mylibService.myLibService(model);
		return "mylib/mylib";
	}
	
	@RequestMapping(value="/plan/page/{study_id}")
	public String mylibPlanPage(@PathVariable int study_id,Model model) {
		mylibService.selectStudyService(study_id, model);
		return "mylib/plan-page";
	}
}
