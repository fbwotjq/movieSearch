package egovframework.ag.common.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;
import org.springframework.stereotype.Component;

@Component
public class CustomLogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler {
	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws ServletException, IOException {
		//로그인 쿠키 제거
		Cookie cookie = new Cookie("userId", "");
		cookie.setDomain("localhost");
		cookie.setPath("/");
		cookie.setMaxAge(0);
		cookie.setVersion(0);
		cookie.setSecure(false);
		response.addCookie(cookie);

		setDefaultTargetUrl("/");

		super.onLogoutSuccess(request, response, authentication);
	}

}
