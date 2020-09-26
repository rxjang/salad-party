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

import co.salpa.bookery.account.AccountService;
import co.salpa.bookery.model.entity.UserVo;

@Controller
@RequestMapping("/account")
public class LoginController {
	Logger log = Logger.getGlobal();
	
	@Autowired
	AccountService accountService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpSession session) {
		if(session.getAttribute("user") == null)
			return "account/login";
		
		else 
			return "redirect:../";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
//	public String login(HttpSession session, HttpServletResponse resp, @RequestParam("email") String email, @RequestParam("password") String password) throws SQLException {
	public String login(HttpSession session, HttpServletResponse resp, @ModelAttribute UserVo bean) 
			throws SQLException {

		UserVo userBean = null;
		userBean = accountService.login(bean.getEmail(), bean.getPassword());
		System.out.println(userBean);
		
		if(userBean != null) {
			session.setAttribute("user", userBean);
			try {
				resp.getWriter().write("{\"result\":\"success\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		else {
			try{
//				resp.setContentType("application / json; charset = utf-8");
				resp.getWriter().write("{\"result\":\"fail\"}");
			} catch (IOException e) {
                e.printStackTrace();
            }
		}
		return null;
	}
	
	@RequestMapping("/navercallback")
	public String naverCallBack() {
		return "account/navercallback";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:./login";
	}
}
