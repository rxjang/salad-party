package co.salpa.bookery.club.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import co.salpa.bookery.club.service.ClubService;
import co.salpa.bookery.find.service.FindService;
import co.salpa.bookery.model.entity.ClubVo;

@Controller
@RequestMapping("/club")
public class ClubController {

	@Autowired
	ClubService clubService;
	@Autowired
	FindService findService;

	// 북클럽 메인 화면
	@RequestMapping("")
	public String bookClub(Model model) {
		clubService.listBookClubService(model);
		findService.listBookService(model);
		clubService.listReadersService(model);
		return "club/bookClub";
	}// bookClub

	// 글 리스트보기
	@RequestMapping(value = "/list/{book_bid}", method = RequestMethod.GET)
	public String list(Model model, @PathVariable int book_bid, String search) {

		clubService.OneBooListService(book_bid, model, search);
		findService.getBookService(book_bid, model);
		
		return "club/list";
	}

	// 글 상세보기
	@RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
	public String detail(Model model, @PathVariable int id, HttpSession session) {
		clubService.getOneService(id, model);
		clubService.listReplyService(id, model);
		clubService.listRecommendByUserService(model,session);
		// ref = id이고 depth가 1인 row들을 조회.
		return "club/detail";
	}

	// 글쓰기 페이지 이동
	@RequestMapping(value = "/add/{book_bid}", method = RequestMethod.GET)
	public String add(Model model, @PathVariable int book_bid) {
		findService.getBookService(book_bid, model);
		// model.addAttribute("book_bid", book_bid);
		return "club/add";
	}

	// 글작성 후 리스트로 이동
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(Model model, @ModelAttribute ClubVo club, HttpSession session) {
		clubService.addPostService(club, session, model);
		return "redirect:list/" + club.getBook_bid();
	}

	// 리스트 더보기 버튼
	@RequestMapping(value = "/list/more", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String moreList(@ModelAttribute ClubVo club) {

		return clubService.listMoreService(club);
	}

	// 게시글 수정페이지로 club id를 가지고 넘거간다.
	@RequestMapping(value = "/edit/{id}/{book_bid}", method = RequestMethod.GET)
	public String edit(@PathVariable int id, @PathVariable int book_bid, Model model) {
		clubService.getOneService(id, model);
		findService.getBookService(book_bid, model);
		return "club/edit";
	}

	// 게시글 수정하고 디테일페이지로 이동
	@RequestMapping(value = "/update", method = RequestMethod.PUT)
	public String updatePost(@ModelAttribute ClubVo club) {

		clubService.updatePostSerivce(club);
		return "redirect:detail/" + club.getId();
	}

	// 게시글 삭제후 리스트로 이동
	@RequestMapping(value = "/delete", method = RequestMethod.DELETE)
	public String deletePost(@ModelAttribute ClubVo club) {
		clubService.deletePostService(club.getId());
		return "redirect:list/" + club.getBook_bid();
	}

	@RequestMapping(value = "/recommend",method = RequestMethod.GET)
	@ResponseBody
	public String recommendUp(int id, HttpSession session) {
		
		clubService.recommendUpService(id);
		clubService.recommendUpChkService(session, id);
		String responseData = "{\"success\":\"success\",\"num\":\"" + clubService.getOneService(id).getNum() + "\"}";
		return responseData;
	}
	@RequestMapping(value = "/recommenddown",method = RequestMethod.GET)
	@ResponseBody
	public String recommendDown(int id, HttpSession session) {
		clubService.recommendDownService(id);
		clubService.recommendDownChkService(session, id);
		String responseData = "{\"success\":\"success\",\"num\":\"" + clubService.getOneService(id).getNum() + "\"}";
		return responseData;
	}
	
	
}// classEnd
