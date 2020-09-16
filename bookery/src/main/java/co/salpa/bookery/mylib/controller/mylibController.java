package co.salpa.bookery.mylib.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/mylib/")
@Controller
public class mylibController {
	
	@RequestMapping("main")
	public String myLib() {
		return "mylib";
	}
}
