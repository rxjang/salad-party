package co.salpa.bookery;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	

	@RequestMapping(value = "/")
	public String home() {
		
		return "home";
	}

	@RequestMapping(value = "/main")
	public String main() {
		return "main";
	}
	
}