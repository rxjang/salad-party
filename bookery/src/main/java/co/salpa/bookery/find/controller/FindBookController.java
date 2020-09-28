package co.salpa.bookery.find.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import co.salpa.bookery.find.service.FindService;
import co.salpa.bookery.model.entity.UserVo;

@Controller
@RequestMapping("/find")
public class FindBookController {

	@Autowired
	FindService findService;

	/***************************
	 * 검색목록에서 책 눌렀을 때 책 상세보기 페이지로 이동
	 **********************************/

	@RequestMapping("/book/{bid}")
	public String findBook(@PathVariable int bid, HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		UserVo user = (UserVo) session.getAttribute("user");
		
		findService.crawlingService(bid);
		if(user!=null) {
			findService.getStudyOverlapChk(user.getId(), bid, model);
		}
		return "/find/findBook";
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
