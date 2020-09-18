package co.salpa.bookery.today;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TodayController {

	@RequestMapping("/today") // 오늘 페이지로 이동
	public String today() {
		return "/today/today"; // today폴더아래 today.jsp
	}
}//class end
