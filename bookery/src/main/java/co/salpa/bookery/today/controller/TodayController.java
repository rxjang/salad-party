package co.salpa.bookery.today.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;

import co.salpa.bookery.model.entity.UserVo;
import co.salpa.bookery.today.service.TodayService;

@Controller
public class TodayController {

	@Autowired
	TodayService todayService;
	
	@RequestMapping("/today") // 오늘 페이지로 이동
	public String today(Model model, HttpSession session) throws JsonProcessingException {
		UserVo user=(UserVo) session.getAttribute("user");
		int user_id=user.getId();
		try {
			todayService.todayService(user_id, model);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "/today/today"; // today폴더아래 today.jsp
	}// today
	
	// 미완독 책 표지 눌렀을 때 해당 차트 자료 전달
	@RequestMapping(value="/today/chart", method = RequestMethod.GET)
	@ResponseBody // study_id 별 검색결과 전달
	public Object todayChart(int study_id) throws JsonProcessingException {
		return todayService.todayChartService(study_id); // ajax 통신이라 view가 없음
	}// todayChart
	
}// class end