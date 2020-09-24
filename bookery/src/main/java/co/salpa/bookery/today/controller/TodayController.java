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
	public String today(Model model) {
		try {
//			todayService.listTodayStudiesService(user_id, model);
			todayService.listTodayStudiesService(2, model);//로그인 구현까지 임시로 번호 입력해
			//user_id에 해당하는 active "studies" 목록 넘겨줌
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/today/today"; // today폴더아래 today.jsp
	}
}//class end
