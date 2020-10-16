package co.salpa.bookery.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import co.salpa.bookery.main.service.MainService;

@Controller
public class MainController {
	
	@Autowired
	MainService mainService;
	
	@RequestMapping(value = "/")
	public String main(Model model) {
		mainService.bookCoverService(model);
		return "main";
	}
	
	@RequestMapping("/error")
	public void error() {
		//에러 페이지
	}

}
