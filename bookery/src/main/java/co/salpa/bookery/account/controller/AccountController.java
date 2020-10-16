package co.salpa.bookery.account.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import co.salpa.bookery.account.service.AccountService;
import co.salpa.bookery.model.entity.UserVo;

@Controller
@RequestMapping("/account")
public class AccountController {
	Logger log = Logger.getGlobal();
	
	@Autowired
	AccountService accountService;
	
	@Value("#{naver['email.sender']}")
	private String sender;
	
	@Value("#{naver['email.password']}")
	private String password;

	@Value("#{naver['email.adminAccount']}")
	private String adminAccount;
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join() {
		// 페이지 매핑
		return "account/join";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinFinished(HttpSession session, HttpServletResponse resp, @ModelAttribute UserVo newUser) throws SQLException {
		
		triming(newUser);
		
		int cntChkNickName = accountService.chkNickName(newUser.getNickname());
		
		int cntChkTel = accountService.chkTel(newUser.getTel());
		
		if(cntChkNickName == 0 && cntChkTel == 0) {
			accountService.register(newUser);
			// 가입 완료시,
			try {
				sendWelcomeEmail(newUser.getEmail());
				resp.getWriter().write("{\"result\":\"ok\"}");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(cntChkNickName != 0) {
			try {
				resp.getWriter().write("{\"result\":\"nickname\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else if(cntChkTel != 0) {
			try {
				resp.getWriter().write("{\"result\":\"tel\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return null;
	}
	
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String update(HttpSession session, Model model) throws SQLException {
		// 페이지 매핑
		UserVo user = (UserVo) session.getAttribute("user");
		triming(user);
		
		if(user == null) System.out.println("session is null");
//		System.out.println(user.getId());
		
		accountService.getUserInfo(user.getId(), model);
		
		return "account/update";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateFinished(HttpSession session, HttpServletResponse resp, @ModelAttribute UserVo bean) throws SQLException {
		
		triming(bean);
		
		int cntChkNickName = accountService.chkUpdateNickName(bean.getEmail(), bean.getNickname());
		
		int cntChkTel = accountService.chkUpdateTel(bean.getEmail(), bean.getTel());
		
		if(cntChkNickName == 0 && cntChkTel == 0) {
			int cnt = accountService.updateInfo(bean);
			System.out.println("updateResult: " + cnt);
			// 정보수정 완료시,
			if(cnt == 1) {
				try {
					UserVo user = (UserVo) session.getAttribute("user");
					user.setPassword(bean.getPassword());
					user.setName(bean.getName());
					user.setNickname(bean.getNickname());
					user.setTel(bean.getTel());
					resp.getWriter().write("{\"result\":\"ok\"}");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			// 정보수정 실패시, 
			else {
				try {
					resp.getWriter().write("{\"result\":\"fail\"}");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} else if(cntChkNickName != 0) {
			try {
				resp.getWriter().write("{\"result\":\"nickname\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else if(cntChkTel != 0) {
			try {
				resp.getWriter().write("{\"result\":\"tel\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return null;
	}
	
	@RequestMapping("/delete/{id}")
	public String delete(HttpSession session, @PathVariable int id) throws SQLException {
		
		accountService.withdraw(id);
		session.invalidate();
		
		return "account/delete";
	}
	
	@RequestMapping("/find")
	public String find(HttpSession session) {
		// 페이지 매핑
		if(session.getAttribute("user") == null)
			return "account/find";
		
		else 
			return "redirect:../";
	}
	
	@RequestMapping(value = "/findid", method = RequestMethod.GET)
	public String findIdGet(HttpSession session) throws SQLException {
		// 페이지 매핑
		if(session.getAttribute("user") == null)
			return "account/findid";
		else  
			return "redirect:../";
	}
	
	@RequestMapping(value = "/findid", method = RequestMethod.POST)
	public String findIdPost(HttpServletResponse resp, String name, String tel) throws SQLException {
		// 이메일 계정 리턴 (비동기)
		name = name.trim();
		tel = tel.trim();
		
		String email = accountService.findId(name, tel);
		
		if(email != null) {
			// 존재하는 계정일 경우, 
			String lvl = accountService.chkBySns(email);
			
			String[] filter = email.split("@");
			String temp = "";
			if(filter[0].length() >= 4) {
				char[] filter2 = filter[0].toCharArray();
				for(int i=0; i<filter2.length; i++) {
					if(i>2) {
						temp += "*";
					} else {
						temp += filter2[i];
					}
				}
			}
			
			String parsingEmail = temp + "@" + filter[1];
//			System.out.println(parsingEmail);
			try {
				resp.getWriter().write("{\"result\":\"" + parsingEmail +"\", \"lvl\":\""+ lvl +"\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			// 존재하지 않는 계정일 경우,
			try {
				resp.getWriter().write("{\"result\":\"fail\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		return null;
	}
	
	@RequestMapping(value = "/findpw", method = RequestMethod.GET)
	public String findPwGet(HttpSession session) throws SQLException {
		// 페이지 매핑
		if(session.getAttribute("user") == null)
			return "account/findpw";
		
		else 
			return "redirect:../";
	}
	
	@RequestMapping(value = "/findpw", method = RequestMethod.POST)
	public String findPwPost(HttpServletResponse resp, String email, String name, String tel) throws SQLException {
		
		email = email.trim();
		name = name.trim();
		tel = tel.trim();
		
		String lvl = accountService.chkBySns(email);
		if(lvl != null) lvl = lvl.trim();
		if(lvl.equals("naver") || lvl == "naver") {
			
			try {
				resp.getWriter().write("{\"result\":\"naver\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else if(lvl.equals("kakao") || lvl == "kakao") {
			try {
				resp.getWriter().write("{\"result\":\"kakao\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else if(lvl.equals("") || lvl == null || lvl.equals(null)){
			int cnt = -1;
			cnt = accountService.findPw(email, name, tel);
			if(cnt == 1) {
				try {
					newPw(email);
					resp.getWriter().write("{\"result\":\"ok\"}");
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				try {
					resp.getWriter().write("{\"result\":\"fail\"}");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		return null;
	}
	
	
	@RequestMapping("/chkEmail")
	public void chkId(HttpServletResponse resp, String email) throws SQLException {
		// 이메일 중복 체크
		email = email.trim();
		
		int cnt = -1;
		
		cnt = accountService.chkEmail(email.trim());
		if(cnt == 0) {
			try {
				resp.getWriter().write("{\"result\":\"ok\"}");
			} catch (IOException e) {
				
				e.printStackTrace();
			}
		} else if(cnt > 0) {
			try {
				resp.getWriter().write("{\"result\":\"fail\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping("/chkInfo")
	public void chkInfo() {
		// 닉네임, 연락처 중복 체크
	}
	
	public void newPw(String email) throws SQLException {
		// 임시 비밀번호 생성
		String newPassword = getRandomPassword(8);
		int result = -1;
		// 비밀번호 변경
		result = accountService.newPw(email, newPassword);
		// 이메일 발송
		if(result > 0) {
			sendNewPasswordEmail(email, newPassword);
		} else {
			System.out.println("비밀번호 변경 실패");
		}
	}
	
	// 비밀번호 랜덤 생성 메소드
	public static String getRandomPassword(int length){
        char[] charaters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9'};
        StringBuilder sb = new StringBuilder("");
        Random rn = new Random();
        for( int i = 0 ; i < length ; i++ ){
            sb.append( charaters[ rn.nextInt( charaters.length ) ] );
        }
        return sb.toString();
    }
	
	// 가입 완료 이메일 발송 메소드
	public void sendWelcomeEmail(String email) {
		
		email = email.trim();
		sender = sender.trim();
		adminAccount = adminAccount.trim();
		
		String subject = "bookery.live의 가족이 되신 것을 환영합니다";
		String msg = "안녕하세요. Bookery에 오신 것을 환영합니다. \n"
				+ " Bookery 는 회원님이 계획한 스터디를 끝까지 성공적으로 마칠 수 있도록 지원합니다. \n"
				+ "회원님의 성공을 기원합니다.\n\n" 
				+ "Bookery Admin 일동 드림";
		
			Properties prop = new Properties();
			prop.put("mail.smtp.host", "smtpout.secureserver.net");
			prop.put("mail.smtp.port", 465);
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.smtp.ssl.enable", "true");
			prop.put("mail.smtp.timeout", 60000);
			prop.put("mail.smtp.ssl.trust", "*");
			Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(sender, password);
				}
			});// session
			
				MimeMessage message = new MimeMessage(session);
				try {
					message.setFrom(new InternetAddress(sender));
//					 수신자메일주소
					InternetAddress[] toAddr = new InternetAddress[2]; 
					toAddr[0] = new InternetAddress(email); 
					toAddr[1] = new InternetAddress (adminAccount);
					
//					message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
					message.addRecipients(Message.RecipientType.TO, toAddr);
					// Subject
					message.setSubject(subject); // 메일 제목을 입력
					// Text
					message.setText(msg); // 메일 내용을 입력
					// send the message
					Transport.send(message); //// 전송
					
					
				} catch (AddressException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
	}//sendWelcomeEmail
	
	// 가입 완료 이메일 발송 메소드
		public void sendNewPasswordEmail(String email, String newPassword) {
			
			email = email.trim();
			sender = sender.trim();
			adminAccount = adminAccount.trim();
			newPassword = newPassword.trim();
			
			String subject = "Bookery 임시 비밀번호 알림";
			String msg = " 임시 비밀번호 알림\n"
					+ " 회원님의 임시 비밀번호는 '" + newPassword + "' 입니다.\n"
					+ " 비밀번호 변경 후 이용해주세요." 
					+ "Bookery Admin 드림";
			
				Properties prop = new Properties();
				prop.put("mail.smtp.host", "smtpout.secureserver.net");
				prop.put("mail.smtp.port", 465);
				prop.put("mail.smtp.auth", "true");
				prop.put("mail.smtp.ssl.enable", "true");
				prop.put("mail.smtp.timeout", 60000);
				prop.put("mail.smtp.ssl.trust", "*");
				Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(sender, password);
					}
				});// session
				
					MimeMessage message = new MimeMessage(session);
					try {
						message.setFrom(new InternetAddress(sender));
//						 수신자메일주소
						InternetAddress[] toAddr = new InternetAddress[2]; 
						toAddr[0] = new InternetAddress(email); 
						toAddr[1] = new InternetAddress (adminAccount);
						
//						message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
						message.addRecipients(Message.RecipientType.TO, toAddr);
						// Subject
						message.setSubject(subject); // 메일 제목을 입력
						// Text
						message.setText(msg); // 메일 내용을 입력
						// send the message
						Transport.send(message); //// 전송
						
						
					} catch (AddressException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (MessagingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				
		}//sendWelcomeEmail
	
	public void triming(UserVo bean) {
		
		bean.setEmail(bean.getEmail().trim());
		bean.setPassword(bean.getPassword().trim());
		bean.setName(bean.getName().trim());
		bean.setNickname(bean.getNickname().trim());
		if(bean.getTel() != null) bean.setTel(bean.getTel().trim());
		if(bean.getLvl() != null) bean.setLvl(bean.getLvl().trim());
		
	}//triming

	

}