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
	//게시글 댓글 수정
	@RequestMapping(value = "/reply/update",method = RequestMethod.PUT)
	public String replyUpdate(@ModelAttribute ClubVo club, int post_id) {
		clubService.updateReplyService(club);
		return "redirect:../detail/"+post_id;
	}
	
	//게시글 댓글 삭제
	@RequestMapping(value = "/reply/delete",method = RequestMethod.DELETE)
	public String replyDelete(@ModelAttribute ClubVo club, int post_id) {
			clubService.deletePostService(club.getId());
		return "redirect:../detail/"+post_id;
	}
	
}
