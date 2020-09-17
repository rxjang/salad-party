package co.salpa.bookery.today.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/today")
public class TodayPageController {

	@RequestMapping("/page")
	public String pageInput() { // 오늘 공부한 페이지 입력하러가기
		return "/today/page";
	}// pageInput

	@RequestMapping("/page/result")
	public String pageResult() { // 오늘 공부한 페이지 수 입력 결과보기
		return "/today/pageResult";
	}// pageInput

}// ClassEnd
