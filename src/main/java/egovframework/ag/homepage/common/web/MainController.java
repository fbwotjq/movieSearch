package egovframework.ag.homepage.common.web;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.ag.common.util.StringUtils;
import egovframework.ag.homepage.common.service.CommonService;


@Controller
@RequestMapping("/main")
public class MainController {

	@Value("${user.join.url}")
	private String userJoinUrl;

	@Autowired
	private CommonService commonService;

	@RequestMapping("")
	public String mainView(Model model, @CookieValue(value = "myKMDbMainSetup",  defaultValue = "main") String myKMDbMainSetup, HttpServletResponse res) throws Exception {

		String returnUrl = "/main";
		if("main".equals(myKMDbMainSetup)){

			model.addAttribute("mainList", commonService.selectMainList());
			Map<String, Object> info = commonService.selectMainInfo("HOME_BOTM");
			model.addAttribute("detailInfo", info);
			model.addAttribute("contentList", commonService.selectMainSubList(StringUtils.getLong(info.get("mainContentId"))));
			model.addAttribute("userJoinUrl", userJoinUrl);
			returnUrl = "/"+myKMDbMainSetup+returnUrl;
		}else{
			//서브 메인으로 이동
			returnUrl = "redirect:/"+myKMDbMainSetup+returnUrl;
		}
		return returnUrl;
	}

}
