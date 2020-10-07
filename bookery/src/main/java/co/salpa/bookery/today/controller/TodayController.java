package co.salpa.bookery.today.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import co.salpa.bookery.model.entity.UserVo;
import co.salpa.bookery.today.service.TodayService;

@Controller
public class TodayController {

	@Autowired
	TodayService todayService;
	
	@RequestMapping("/today") // 오늘 페이지로 이동
	public String today(Model model, HttpSession session) {
		UserVo user=(UserVo) session.getAttribute("user");
		int user_id=user.getId();
		try {
			todayService.todayService(user_id, model);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "/today/today"; // today폴더아래 today.jsp
	}
}//class end
