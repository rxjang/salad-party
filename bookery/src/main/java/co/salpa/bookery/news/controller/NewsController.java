package co.salpa.bookery.news.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/news")
public class NewsController {

	@RequestMapping
	public String news() {
		
		return "news/news";
	}
}
