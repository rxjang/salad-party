package co.salpa.bookery.club.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/club")
public class ClubController {

	@RequestMapping("/")
	public String bookClub() {
		
		return "club/bookClub";
	}
}
