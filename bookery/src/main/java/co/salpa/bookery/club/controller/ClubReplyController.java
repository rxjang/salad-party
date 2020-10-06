package co.salpa.bookery.club.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import co.salpa.bookery.club.service.ClubService;
import co.salpa.bookery.find.service.FindService;
import co.salpa.bookery.model.entity.ClubVo;

@Controller
@RequestMapping("/club")
public class ClubReplyController {


	@Autowired
	ClubService clubService;
	@Autowired
	FindService findService;
	
	
	//게시글 댓글달기
	@RequestMapping(value = "/reply",method = RequestMethod.POST)
	@ResponseBody
	public String reply(@ModelAttribute ClubVo club,HttpSession session) {
		return 	clubService.addReplyService(club,session);
	}
	
	
}
