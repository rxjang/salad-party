package co.salpa.bookery.account.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/account")
public class ProfileController {
		
	@RequestMapping("/profile")
	public String profile() {
		
		return "account/profile";
	}
}//class
