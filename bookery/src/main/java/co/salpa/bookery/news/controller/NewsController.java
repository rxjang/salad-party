package co.salpa.bookery.news.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import co.salpa.bookery.model.entity.ClubVo;
import co.salpa.bookery.news.service.NewsService;

@Controller
@RequestMapping("/news")
public class NewsController {
	
	@Autowired
	NewsService newsService;

	@RequestMapping
	public String news(Model model) {
		newsService.noticeService(model);
		
		return "news/news";
	}
	
	@RequestMapping("/notice")
	public String notice(Model model) {
		newsService.noticeService(model);
		return "news/notice";
	}
	
	@RequestMapping("/notice/write")
	public String insertNotice() {
	return "news/noticewrite";
	}
	
	@RequestMapping(value="/notice",method=RequestMethod.POST)
	public String insert(@ModelAttribute ClubVo bean) {
		try {
			newsService.insertQuestion(bean);
		} catch (DataAccessException e) {
			return "news/noticewrite";
		}
		return "redirect:./";
	}
}
