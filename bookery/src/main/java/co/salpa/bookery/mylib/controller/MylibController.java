package co.salpa.bookery.mylib.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import co.salpa.bookery.mylib.service.MylibService;

@RequestMapping("/mylib")
@Controller
public class MylibController {
	
	@Autowired MylibService mylibService;
	
	@RequestMapping
	public String myLib(Model model) throws DataAccessException {
		mylibService.listNoGoalBookService(model);
		mylibService.listStudyingBookService(model);
		mylibService.listFinishedBookService(model);
		mylibService.countNoGoalBookService(model);
		mylibService.countStudyingBookService(model);
		mylibService.countFinishedBookService(model);
		return "mylib/mylib";
	}
	
	@RequestMapping("/plan-page")
	public String mylibPlanPage() {
		
		return "mylib/plan-page";
	}
}
