package co.salpa.bookery.find.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import co.salpa.bookery.find.service.FindService;

@Controller
@RequestMapping("/find")
public class FindBookController {

	@Autowired
	FindService findService;

	/***************************
	 * 검색목록에서 책 눌렀을 때 책 상세보기 페이지로 이동
	 **********************************/

	@RequestMapping("/book/{bid}")
	public ModelAndView findBook(@PathVariable int bid) {
		return new ModelAndView("/find/findBook", "bid", bid);
	}

	/***************************
	
	 **********************************/
	@RequestMapping("/mylib")
	public String showBooks(Model model) throws Exception {
		findService.listBookService(model);
		return "find/mybooks";
	}// showBooks

	@RequestMapping("/chapters")
	public String showChapters(@RequestParam int bid, Model model) throws Exception {
		findService.listTocService(model, bid);
		return "find/mybookchapters";
	}
}// ClassEnd
