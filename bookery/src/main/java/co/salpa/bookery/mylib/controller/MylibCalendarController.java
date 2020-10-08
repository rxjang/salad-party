package co.salpa.bookery.mylib.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.salpa.bookery.model.entity.UserVo;
import co.salpa.bookery.mylib.service.MylibCalendarService;

@Controller
public class MylibCalendarController {

	@Autowired
	MylibCalendarService mylibCalendarService;
	
//	ObjectMapper mapper=new ObjectMapper();
	
	@RequestMapping("/mylib/calendar")
	public String calendar(Model model, HttpSession session) throws SQLException, JsonProcessingException {
		UserVo user=(UserVo) session.getAttribute("user");
		int user_id=user.getId();
		mylibCalendarService.calendarService(user_id, model);
		return "/mylib/calendar";
	}
}