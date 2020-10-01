package co.salpa.bookery.news.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
