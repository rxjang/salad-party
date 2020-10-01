package co.salpa.bookery.find.controller;

import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import co.salpa.bookery.find.service.FindService;

@Controller
public class FindController {

	@Autowired
	FindService findService;

	@RequestMapping("/find") // 검색페이지로 이동
	public String find(Model model) {
		try {
			findService.listMostBookService(model);
		} catch (DataAccessException e) {
			return "redirect:/";
		}
		return "/find/find"; // find폴더아래 find.jsp
	}

	// 검색페이지에 검색결과 전달
	@RequestMapping(value = "/find/result", method = RequestMethod.GET, produces = "application/xml;charset=utf-8")
	@ResponseBody// select = {제목,저자,출판사} 상세검색 요청변수 생성
	public String searchBooks(int start, String search, String select) throws Exception {
		return findService.searchService(start, search, select);// ajax통신이라 view가 없음
	}// searchBooks


}// classEnd