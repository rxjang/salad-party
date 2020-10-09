package co.salpa.bookery.account.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import co.salpa.bookery.account.service.NotificationService;

@Controller
@RequestMapping("/account")
public class NotificationController {

	@Autowired
	NotificationService notificationService;
	
	@RequestMapping("/noti")
	public String notification(Model model, HttpSession session) {
		notificationService.listReplyMyPostService(model, session);
		//model.addAttribute("notiSize", notificationService.getReplyMyPostListSizeService(session));
		return "account/notification";
	}
	
	@RequestMapping(value="/noti/check",method = RequestMethod.POST)
	@ResponseBody
	public void notiCheck(int id) {
		notificationService.checkedNotiService(id);
		System.out.println("댓글확인");
		
		
	}
	@RequestMapping(value="/noti/size",method = RequestMethod.GET,produces = "application/json;charset=utf-8")
	@ResponseBody
	public String notiSize(HttpSession session) {
		int notiSize = notificationService.getReplyMyPostListSize(session);
		return "{\"notisize\":"+notiSize+"}";
	}
	
	
}//class
