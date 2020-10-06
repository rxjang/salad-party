package co.salpa.bookery.news.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import co.salpa.bookery.model.entity.ClubVo;
import co.salpa.bookery.news.service.NewsService;

@Controller
@RequestMapping("/news")
public class NewsController {
	
	@Autowired
	NewsService newsService;

	@RequestMapping
	public String news(Model model) {
		newsService.listMostBookService(model);
		return "news/news";
	}
	
	/*********************************** rank **************************************/
	
	@RequestMapping("/rank")
	public String rank(Model model) {
		return "news/rank";
	}
	
	/********************************** notice **************************************/
	
	@RequestMapping("/notice")
	public String notice(Model model) {
		newsService.noticeService(model);
		return "news/notice";
	}
	
	@RequestMapping("/notice/write/{num}")
	public String insertNotice(@PathVariable int num) {
	return "news/noticewrite";
	}
	
	@RequestMapping(value="/notice/write/{num}",method=RequestMethod.POST)
	public String insert(@PathVariable int num, @ModelAttribute ClubVo bean) {
		try {
			newsService.insertQuestion(bean);
		} catch (DataAccessException e) {
			return "news/noticewrite";
		}
		return "redirect:../";
	}
	
	@RequestMapping("/notice/answer/{id}")
	public String selectQuestion(@PathVariable int id,Model model) {
		newsService.detailNoticeService(id, model);
		return "news/noticeanswer";
	}
	
	@RequestMapping(value="/notice/answer/{id}",method=RequestMethod.POST)
	public String insertAnswer(@PathVariable int id,@ModelAttribute ClubVo bean) {
		try {
			newsService.writeAnswer(id, bean);
		} catch (DataAccessException e) {
			return "news/noticeanswer";
		}
		return "redirect:../";
	}
	
	@RequestMapping(value="/notice/detail/{id}")
	public String noticeDetail(@PathVariable int id,Model model) {
		newsService.detailNoticeService(id, model);
		return "news/noticedetail";
	}
	
	@RequestMapping(value="/notice/detail/{id}",method=RequestMethod.PUT)
	public ModelAndView updateNotice(@PathVariable int id,ClubVo bean) {
		System.out.println("newsController depth:"+bean.getDepth());
		System.out.println("newsController content:"+bean.getContent());
		newsService.updateNotice(bean);
		return new ModelAndView("redirect:./"+id);
	}
	
	@RequestMapping(value = "/notice/detail/{id}",method = RequestMethod.DELETE)
	public String delete(@PathVariable int id){
		newsService.deleteNotice(id);
		return "redirect:../";
	}
}
