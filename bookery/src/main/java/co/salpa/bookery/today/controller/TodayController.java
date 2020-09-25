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
	
	@RequestMapping("/today") // 오늘 페이지로 이동
	public String today(int idx,Model model) {
		try {
			todayService.listTodayStudiesService(idx, model);
			//idx : user_id 받아야함.
			//현재 진행중인 스터디 목록 "studies" 목록 반환
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/today/today"; // today폴더아래 today.jsp
	}
}//class end
