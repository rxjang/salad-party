package co.salpa.bookery.account.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
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
	public String login(HttpSession session, HttpServletRequest request, HttpServletResponse resp, @ModelAttribute UserVo bean) 
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
	public String naverCallBackPost(HttpSession session, HttpServletRequest request, HttpServletResponse resp, @ModelAttribute UserVo bean) 
			throws SQLException {
		
		UserVo userBean = null;
		
		triming(bean);
		// 북커리로 가입된 회원 인지 확인
		int cntMember =  accountService.chkEmail(bean.getEmail());
		
		if(cntMember != 0) {
			// 네이버 회원으로 가입된 계정인지 확인.
			String lvl = accountService.chkBySns(bean.getEmail());
			System.out.println(lvl);
			if(!lvl.equals("naver")) {
				// 북커리로 가입된 이메일 계정. 북커리로 로그인 요청
				try {
					resp.getWriter().write("{\"result\":\"bookerylogin\"}");
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				// 네이버 로그인 처리
				userBean = accountService.login(bean.getEmail(), bean.getPassword());
				
				if(userBean != null) {
					int notiSize = -1; 
					session.setAttribute("user", userBean);
					notiSize = notificationService.getReplyMyPostListSize(session);
					session.setAttribute("notiSize", notiSize); //확인 안한 댓글 목록 size() 
					try {
						resp.getWriter().write("{\"result\":\"login\"}");
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
			}
		} else {
			// 회원 등록
			int cntChkNickName = accountService.chkNickName(bean.getNickname());
			
			if(cntChkNickName >= 1) {
				// 이미 존재하는 닉네임을 가진 계정인 경우, 닉네임을 이메일로 변경.
				bean.setNickname(bean.getEmail());
			}
			// 네이버 계정 정보로 회원 등록
			accountService.register(bean);
			
			//로그인
			userBean = accountService.login(bean.getEmail(), bean.getPassword());
		
			if(userBean != null) {
				int notiSize = -1; 
				session.setAttribute("user", userBean);
				
				notiSize = notificationService.getReplyMyPostListSize(session);
				session.setAttribute("notiSize", notiSize); //확인 안한 댓글 목록 size() 
				try {
					resp.getWriter().write("{\"result\":\"login\"}");
				} catch (IOException e) {
					e.printStackTrace();
					System.out.println("통신에러");
				}
			}
			else {
				try{
					resp.getWriter().write("{\"result\":\"fail\"}");
				} catch (IOException e) {
	                e.printStackTrace();
	            }
			}
		}

		return null;
	}
	
	@RequestMapping(value="/kakaocallback", method=RequestMethod.POST)
	public String kakaoCallBack(HttpSession session, HttpServletRequest request, HttpServletResponse resp, @ModelAttribute UserVo bean) throws SQLException {
		
		UserVo userBean = null;
		System.out.println("before triming :" + bean.getEmail() + ", "+bean.getName());
		
		triming(bean);
		System.out.println("after triming :" + bean.getEmail() + ", "+bean.getName());
		// 북커리로 가입된 회원 인지 확인
		int cntMember =  accountService.chkEmail(bean.getEmail());
		
		if(cntMember != 0) {
			// 네이버 회원으로 가입된 계정인지 확인.
			String lvl = accountService.chkBySns(bean.getEmail());
			if(!lvl.equals("kakao")) {
				// 북커리로 가입된 이메일 계정. 북커리로 로그인 요청
				try {
					resp.getWriter().write("{\"result\":\"bookerylogin\"}");
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {
				// 카카오 로그인 처리
				userBean = accountService.login(bean.getEmail(), bean.getPassword());
				
				if(userBean != null) {
					int notiSize = -1; 
					session.setAttribute("user", userBean);
					notiSize = notificationService.getReplyMyPostListSize(session);
					session.setAttribute("notiSize", notiSize); //확인 안한 댓글 목록 size() 
					try {
						resp.getWriter().write("{\"result\":\"login\"}");
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
			}
		} else {
			// 회원 등록
			int cntChkNickName = accountService.chkNickName(bean.getNickname());
			
			if(cntChkNickName >= 1) {
				// 이미 존재하는 닉네임을 가진 계정인 경우, 
				if(bean.getEmail().contains("@")) {
					//이메일이 이메일일 경우 닉네임을 이메일로 변경.
					bean.setNickname(bean.getEmail());
				} else {
					bean.setNickname("게스트" + (accountService.maxId() + 1));
				}
			}
			// 네이버 계정 정보로 회원 등록
			accountService.register(bean);
			
			//로그인
			userBean = accountService.login(bean.getEmail(), bean.getPassword());
		
			if(userBean != null) {
				int notiSize = -1; 
				session.setAttribute("user", userBean);
				
				notiSize = notificationService.getReplyMyPostListSize(session);
				session.setAttribute("notiSize", notiSize); //확인 안한 댓글 목록 size() 
				try {
					resp.getWriter().write("{\"result\":\"login\"}");
				} catch (IOException e) {
					e.printStackTrace();
					System.out.println("통신에러");
				}
			}
			else {
				try{
					resp.getWriter().write("{\"result\":\"fail\"}");
				} catch (IOException e) {
	                e.printStackTrace();
	            }
			}
		}

		return null;
	}
	
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, HttpSession session) {
		session.invalidate();
		return "redirect:./login";
	}
	
	public void triming(UserVo bean) {
		
		bean.setEmail(bean.getEmail().trim());
		bean.setPassword(bean.getPassword().trim());
		bean.setName(bean.getName().trim());
		bean.setNickname(bean.getNickname().trim());
		
	}//triming
}