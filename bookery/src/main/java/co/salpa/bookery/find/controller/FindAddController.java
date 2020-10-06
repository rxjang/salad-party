package co.salpa.bookery.find.controller;

import java.sql.Date;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import co.salpa.bookery.find.service.FindService;
import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.StudyVo;
import co.salpa.bookery.model.entity.UserVo;

@Controller
@RequestMapping("/find")
public class FindAddController {

	@Autowired
	FindService findService;
	 ObjectMapper mapper = new ObjectMapper();
	/***************************
	 * 검색된 책 상세보기에서 내서재 담기 눌렀을 때.
	 **********************************/
	@RequestMapping(value = "/put", method = RequestMethod.POST) // 내 서재 담기 기능 Book, Toc, Study 테이블에 책 입력
	@ResponseBody
	public String insertChapters(@RequestBody Map<String, Object> param, HttpServletRequest request)
			throws Exception {
		//System.out.println("find add controller");
		//@RequestBody BookVo book,@RequestBody String chapters,
		
		//System.out.println("chapters "+(String)param.get("chapters"));
		String chapters = (String)param.get("chapters");
		BookVo book = mapper.convertValue(param.get("book"), BookVo.class);
		//System.out.println(book);
	
		HttpSession session = request.getSession();
		UserVo user = (UserVo) session.getAttribute("user");
		StudyVo study = new StudyVo();
		study.setUser_id(user.getId());
		study.setBook_bid(book.getBid());
		findService.insertStudyService(book, study, chapters);//book테이블 toc테이블 study테이블 insert
		return "{\"success\":\"success\"}";
	}// insertChapters

	
}// classEnd