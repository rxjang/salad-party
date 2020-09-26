package co.salpa.bookery.account.controller;

import java.sql.SQLException;
import java.util.Random;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import co.salpa.bookery.account.AccountService;
import co.salpa.bookery.model.entity.UserVo;

@Controller
@RequestMapping("/account")
public class AccountController {
	Logger log = Logger.getGlobal();
	
	@Autowired
	AccountService accountService;
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join() {
		// 페이지 맵핑
		return "account/join";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinFinished(HttpSession session, String email, String password, String name, String nickname, String tel) throws SQLException {
		
		int cnt = accountService.register(email, password, name, nickname, tel);
		
		// 가입 완료시,
		if(cnt == 1) {
			return "redirect:./login";
		}
		// 가입 실패시, 
		else 
			return "redirect:./join"; 
	}
	
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String update() {
		// 페이지 맵핑
		return "account/update";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String updateFinished(HttpSession session, UserVo bean) throws SQLException {
		
		int cnt = accountService.updateInfo(bean);
		// 정보수정 완료시,
		
		if(cnt == 1) 
			return "redirect:./login";
		// 정보수정 실패시, 
		else 
			return "redirect:./update"; 
	}
	
	@RequestMapping("/findid")
	public String findid(String name, String tel) throws SQLException {
		// 이메일 계정 리턴 (비동기)
		String email = accountService.findId(name, tel);
		return "account/findid";
	}
	
	@RequestMapping("/findpw")
	public String findpw(String email, String name, String tel) throws SQLException {
		
		accountService.findPw(email, name, tel);
		
		return "account/findpw";
	}
	
	@RequestMapping("/chkId")
	public void chkId(String email) {
		// 이메일 중복 체크
		
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
	public static String getRandomPassword(int length ){
        char[] charaters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9'};
        StringBuilder sb = new StringBuilder("");
        Random rn = new Random();
        for( int i = 0 ; i < length ; i++ ){
            sb.append( charaters[ rn.nextInt( charaters.length ) ] );
        }
        return sb.toString();
    }

	

}
