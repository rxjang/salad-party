package co.salpa.bookery.mylib.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import co.salpa.bookery.mylib.service.MylibCalendarService;
import co.salpa.bookery.mylib.service.MylibPlanService;

@Controller
public class MylibCalendarController {

	@Autowired
	MylibCalendarService mylibCalendarService;
	
	@RequestMapping("/mylib/calendar/{study_id}")
	public String calendar(@PathVariable int study_id,Model model) throws SQLException {
		mylibCalendarService.selectStudyService(study_id,model);
		return "/mylib/calendar";
	}
}