       package co.salpa.bookery.account.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import co.salpa.bookery.account.service.AccountService;
import co.salpa.bookery.account.service.NotificationService;
import co.salpa.bookery.model.entity.UserVo;

@Controller
@RequestMapping("/account")
public class LoginController {
	Logger log = Logger.getGlobal();
	
	@Autowired
	AccountService accountService;
	@Autowired
	NotificationService notificationService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpSession session) {
		// 페이지 매핑
		if(session.getAttribute("user") == null)
			return "account/login";
		
		else 
			return "redirect:../";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(HttpSession session, HttpServletResponse resp, @ModelAttribute UserVo bean) 
			throws SQLException {

		UserVo userBean = null;
		userBean = accountService.login(bean.getEmail(), bean.getPassword());
		
		if(userBean != null) {
			int notiSize = -1; 
			session.setAttribute("user", userBean);
			notiSize = notificationService.getReplyMyPostListSize(session);
			session.setAttribute("notiSize", notiSize); //확인 안한 댓글 목록 size() 
			try {
				resp.getWriter().write("{\"result\":\"success\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		else {
			try{
				resp.getWriter().write("{\"result\":\"fail\"}");
			} catch (IOException e) {
                e.printStackTrace();
            }
		}
		return null;
	}
	
	@RequestMapping(value = "/navercallback", method = RequestMethod.GET)
	public String naverCallBackGet() {
		return "account/navercallback";
	}
	
	@RequestMapping(value = "/navercallback", method = RequestMethod.POST)
	public String naverCallBackPost() {
		// 비동기 
		return null;
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:./login";
	}
}
