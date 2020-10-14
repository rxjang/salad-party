package co.salpa.bookery.find.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.salpa.bookery.find.service.FindService;
import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.StudyVo;
import co.salpa.bookery.model.entity.UserVo;

@Controller
@RequestMapping("/find")
public class FindAddController {

	@Autowired
	FindService findService;
	ObjectMapper mapper = new ObjectMapper();

	/***************************
	 * 검색된 책 상세보기에서 내서재 담기 눌렀을 때.
	 **********************************/
	@RequestMapping(value = "/put", method = RequestMethod.POST) // 내 서재 담기 기능 Book, Toc, Study 테이블에 책 입력
	@ResponseBody
	public String insertChapters(@RequestBody Map<String, Object> param, HttpServletRequest request) throws Exception {
		// System.out.println("find add controller");
		// @RequestBody BookVo book,@RequestBody String chapters,

		// System.out.println("chapters "+(String)param.get("chapters"));
		String chapters = (String) param.get("chapters");
		BookVo book = mapper.convertValue(param.get("book"), BookVo.class);
		// System.out.println(book);

		HttpSession session = request.getSession();
		UserVo user = (UserVo) session.getAttribute("user");
		StudyVo study = new StudyVo();
		study.setUser_id(user.getId());
		study.setBook_bid(book.getBid());
		findService.insertStudyService(book, study, chapters);// book테이블 toc테이블 study테이블 insert
		return "{\"success\":\"success\"}";
	}// insertChapters

	/*
	 * 직접입력 책커버 이미지 서버에 업로드 후, 이미지 주소 반환
	 */
	@RequestMapping(value = "/cover", method = RequestMethod.POST, consumes = "multipart/form-data", produces = "application/json;charset=utf-8")
	@ResponseBody
	public Object coverImgUpload(MultipartFile coverimg, HttpServletRequest req, HttpServletResponse resp) {
		UUID uuid = UUID.randomUUID();
		String context_path = req.getRealPath("/");
		String cover_folder = context_path + "resources\\cover";
		String cover_name = uuid + coverimg.getOriginalFilename();
		System.out.println(cover_folder + "\\" + cover_name);
		File file = new File(cover_folder, cover_name);
		if (!file.exists()) {
			file.mkdirs();
		}
		try {
			coverimg.transferTo(file);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		/*
		 * try { resp.getWriter().print("{\"coverurl\":\"" + cover_folder +
		 * "\\" + cover_name + "\"}"); } catch (IOException e) { // TODO Auto-generated
		 * catch block e.printStackTrace(); }
		 */
		// String jsonURL = null;
		String url = req.getContextPath()+"/resources/cover/" + cover_name;
		// ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map = new HashMap<String, String>();

		map.put("url", url);
		return map;
	}
//C:\Users\jhj71\Desktop\eGovFrameDev-3.9.0-64bit\sts-bundle\sts-3.9.13.RELEASE\stsworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\bookery\resources
	// \cover\367b208c-d996-4ced-aba8-56f655975a22old-unfolded-book-lying-on-the-table-yellow-paper-pages-plenty-of-space-for-text-or-photo.jpg

	@RequestMapping(value = "direct", method = RequestMethod.POST)
	public String insertDirect(@ModelAttribute BookVo book, HttpSession session) {
		
		int bid = -Integer.parseInt((System.currentTimeMillis()+"").substring(2,11));
		book.setBid(bid);
		UserVo user = (UserVo) session.getAttribute("user");
		StudyVo study = new StudyVo();
		study.setUser_id(user.getId());
		study.setBook_bid(book.getBid());
		String chapters = "이 책은 목차가 없습니다.\n";
		findService.insertStudyService(book, study, chapters);
		return "redirect:../../mylib";
	}

}// classEnd