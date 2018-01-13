package egovframework.ag.homepage.eng.web;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/eng/main")
public class EngMainController {

	@RequestMapping("")
	public String engMainView(Model model, HttpServletResponse res) throws Exception {

		return "/eng/main";
	}

}
