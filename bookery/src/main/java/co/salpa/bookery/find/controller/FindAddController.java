package co.salpa.bookery.find.controller;

import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import co.salpa.bookery.model.BookDao;
import co.salpa.bookery.model.StudyDao;
import co.salpa.bookery.model.TocDao;
import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.StudyVo;
import co.salpa.bookery.model.entity.TocVo;

@Controller
@RequestMapping("/find")
public class FindAddController {
	Logger log = Logger.getGlobal();
	@Autowired
	private TocDao tocDao;
	@Autowired
	private BookDao bookDao;
	@Autowired
	private StudyDao studyDao;
	
/***************************검색된 책 상세보기에서 내서재 담기 눌렀을 때.**********************************/
	@RequestMapping("/put") //내 서재 담기 기능 Book, Toc, Study 테이블에 책 입력
	public ModelAndView insertChapters(@ModelAttribute BookVo book, @ModelAttribute StudyVo study, String chapters)
			throws Exception {
		// Book talble에 책 정보입력
		bookDao.insertOne(book);


		// Toc목차 테이블에 입력
		if (tocDao.selectOne(book.getBid()).size() != 0) {
			log.info("목차 입력 : fail ");
			//toc에 같은책의 목차가 있으면 insert하지않음
		} else {
			//**************나중에 TocDaoImpl로 처리를 옮겨 꼭 트랜잭션 처리 하기***********************
			String[] tmp = chapters.split("\n");
			System.out.println(tmp.toString());
			for (String chapter : tmp) {
				if (chapter.trim().equals("")) { // 빈줄제거
					continue;
				} else {
					tocDao.insertOne(new TocVo(book.getBid(), chapter.trim()));//목차와 해당목차의 책번호
				} // if
			} // for
			
			log.info("목차 입력 !! success");
			// test용 user_id
		}//out if
		
//추후 추가예정 
//		study.setUser_id(uesr_test_cnt);
//		study.setBook_bid(book.getBid());
//		studyDao.insertOne(study);
//		uesr_test_cnt++;

		return null;
	}// insertChapters
	

}//classEnd