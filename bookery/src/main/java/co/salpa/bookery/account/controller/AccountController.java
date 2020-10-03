package co.salpa.bookery.account.controller;

import java.io.IOException;
import java.sql.SQLException;
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
import org.springframework.web.bind.annotation.ModelAttribute;
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

//	@Value("#{naver['email.adminAccount']}")
//	private String adminAccount;
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join() {
		// 페이지 맵핑
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
				sendEmail(newUser.getEmail().trim());
				resp.getWriter().write("{\"result\":\"ok\"}");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		else if(cntChkNickName != 0) {
			try {
				resp.getWriter().write("{\"result\":\"nickname\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		else if(cntChkTel != 0) {
			try {
				resp.getWriter().write("{\"result\":\"tel\"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return null;
	}
	
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String update() {
		// 페이지 맵핑
		return "account/update";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateFinished(HttpSession session, UserVo bean) throws SQLException {
		
		triming(bean);
		
		int cnt = accountService.updateInfo(bean);
		// 정보수정 완료시,
		
		if(cnt == 1) {
		}
		// 정보수정 실패시, 
		else {
		}
		return null;
	}
	
	@RequestMapping("/findid")
	public String findid(String name, String tel) throws SQLException {
		// 이메일 계정 리턴 (비동기)
		name = name.trim();
		tel = tel.trim();
		
		String email = accountService.findId(name, tel);
		return "account/findid";
	}
	
	@RequestMapping("/findpw")
	public String findpw(String email, String name, String tel) throws SQLException {
		
		email = email.trim();
		name = name.trim();
		tel = tel.trim();
		
		accountService.findPw(email, name, tel);
		
		return "account/findpw";
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
	
	@RequestMapping("/getAccountEmail")
	public String getAccountEmail() {
		// 비동기 방식
		// 이메일 계정 리턴
		String email = "";
		// "ziw*****@naver.com " 이렇게 처리해서 return;
		return email;
	}
	
	@RequestMapping("/newPw")
	public void newPw() {
		// 비동기 방식 
		// 비밀번호 랜덤생성, 이메일 발송.
		String newPassword = getRandomPassword(8);
		
		// 이메일 발송
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
	public void sendEmail(String email) {
		
		email = email.trim();
		sender = sender.trim();
		
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
					toAddr[1] = new InternetAddress ("saladparty2020@gmail.com");
					
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
			
	}//sendPW
	
	public void triming(UserVo bean) {
		
		bean.setEmail(bean.getEmail());
		bean.setPassword(bean.getPassword());
		bean.setName(bean.getName());
		bean.setNickname(bean.getNickname());
		bean.setTel(bean.getTel());
	}

	

}