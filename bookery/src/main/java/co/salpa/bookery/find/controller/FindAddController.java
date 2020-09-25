package co.salpa.bookery.find.controller;

import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import co.salpa.bookery.find.service.FindService;
import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.StudyVo;

@Controller
@RequestMapping("/find")
public class FindAddController {
	Logger log = Logger.getGlobal();
	@Autowired
	FindService findService;
	
/***************************검색된 책 상세보기에서 내서재 담기 눌렀을 때.**********************************/
	@RequestMapping(value = "/put",method = RequestMethod.POST) //내 서재 담기 기능 Book, Toc, Study 테이블에 책 입력
	public ModelAndView insertChapters(@ModelAttribute BookVo book, @ModelAttribute StudyVo study, String chapters)
			throws Exception {
		findService.insertStudyService(book, study, chapters);
		
//추후 추가예정 
//		study.setUser_id(uesr_test_cnt);
//		study.setBook_bid(book.getBid());
//		studyDao.insertOne(study);
//		uesr_test_cnt++;

		return null;
	}// insertChapters
	

}//classEnd