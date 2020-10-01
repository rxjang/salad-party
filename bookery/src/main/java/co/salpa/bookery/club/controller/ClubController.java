package co.salpa.bookery.club.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import co.salpa.bookery.club.service.ClubService;
import co.salpa.bookery.find.service.FindService;

@Controller
@RequestMapping("/club")
public class ClubController {

	@Autowired
	ClubService clubService;
	@Autowired
	FindService findService;
	
	@RequestMapping("")
	public String bookClub(Model model) {
		clubService.listBookClub(model);
		findService.listBookService(model);
		return "club/bookClub";
	}//bookClub
	
	
}//classEnd
