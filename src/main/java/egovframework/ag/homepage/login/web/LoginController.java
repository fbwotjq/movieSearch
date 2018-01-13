package egovframework.ag.homepage.login.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.ag.common.Constant;
import egovframework.ag.common.web.ParamMap;

@Controller
@RequestMapping("/login")
public class LoginController {

	@Value("${user.id.url}")
	private String userIdUrl;

	@Value("${user.pw.url}")
	private String userPwUrl;

	@Value("${user.join.url}")
	private String userJoinUrl;

	/**
	 * 로그인 페이지
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "")
	public String loginView(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		String errorMessage = SessionUtil.getErrorMsg(request);

		// 로그아웃 처리
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null){
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		request.getSession().invalidate();

		SessionUtil.setErrorMsg(request, errorMessage);
		*/
		model.addAttribute("userIdUrl", userIdUrl);
		model.addAttribute("userPwUrl", userPwUrl);
		model.addAttribute("userJoinUrl", userJoinUrl);

		return "/login/login";
	}

	@RequestMapping("/pre/process")
	public String loginView(ParamMap paramMap, Model model) {
		String returnUrl = paramMap.getString("dReturnUrl");

		String param = paramMap.getBase64ParamString();

		returnUrl += "?" + Constant.PAGE_PARAM + "=" + param;

		return "redirect:/login?returnUrl=" + returnUrl;
	}
}
