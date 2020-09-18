package co.salpa.bookery.find.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import co.salpa.bookery.model.BookDao;
import co.salpa.bookery.model.StudyDao;
import co.salpa.bookery.model.TocDao;
import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.StudyVo;
import co.salpa.bookery.model.entity.TocVo;


@Controller
@RequestMapping("/find")
public class FindBookController {
	
	static private int uesr_test_cnt = 1;//test용 userid
	@Autowired
	private TocDao tocDao;
	@Autowired
	private BookDao bookDao;
	@Autowired
	private StudyDao studyDao;
	
	
/***************************검색목록에서 책 눌렀을 때 책 상세보기 페이지로 이동**********************************/
	
	@RequestMapping("/book")
	public ModelAndView findBook(int bid) {
		return new ModelAndView("/find/findBook","bid",bid);
	}
	
	
/*************************** 임시 : book 테이블 조회 및 목차 조회 페이지**********************************/
	@RequestMapping("/mylib")
	public ModelAndView showBooks() throws Exception {
		return new ModelAndView("/find/mybooks", "books", bookDao.selectAll());//서비스호출
	}//showBooks
	
	@RequestMapping("/chapters")
	public ModelAndView showChapters(@RequestParam int bid, HttpServletRequest request) throws Exception {
	//	req.setAttribute("book", bookDao.selectOne(bid));
		request.setAttribute("book", bookDao.selectOne(bid));
	//	System.out.println(bookDao.selectOne(bid));
		return new ModelAndView("/find/mybookchapters", "bookChapters", tocDao.selectOne(bid));//서비스호출
	}//

}//ClassEnd
	
	