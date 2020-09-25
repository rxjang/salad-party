package co.salpa.bookery.today.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import co.salpa.bookery.today.service.TodayService;

@Controller
public class TodayController {

	@Autowired
	TodayService todayService;
	
	@RequestMapping("/today/{user_id}") // 오늘 페이지로 이동
	public String today(int user_id,Model model) {
		try {
			todayService.listTodayStudiesService(user_id, model);
			//현재 진행중인 스터디 목록 "studies" 목록 반환
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "/today/today"; // today폴더아래 today.jsp
	}
}//class end
