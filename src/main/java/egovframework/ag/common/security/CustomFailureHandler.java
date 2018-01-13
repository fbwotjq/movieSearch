package egovframework.ag.common.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import egovframework.ag.common.util.ReferenceUtils;
import egovframework.ag.common.util.StringUtils;

public class CustomFailureHandler implements AuthenticationFailureHandler {
	private final static Logger logger = LogManager.getLogger();

	private RequestCache requestCache = new HttpSessionRequestCache();

	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
		String managerIp = ReferenceUtils.getRealClientIp(request);
		String username = StringUtils.getStripTag(request.getParameter("username"));
		String returnUrl = StringUtils.getStripTag((String)request.getParameter("returnUrl"));
		String scheme = request.getScheme();
		String serverName = request.getServerName();
		int serverPort = request.getServerPort();
		SavedRequest savedRequest = requestCache.getRequest(request, response);

		if(savedRequest!=null){
			returnUrl =  savedRequest.getRedirectUrl();
		}

		if(returnUrl == null || returnUrl.indexOf(serverName)==-1){
			returnUrl = scheme+"://"+serverName+":"+serverPort+"/main";
		}

        try{
            logger.debug("onAuthenticationFailure managerIp == " + managerIp);
            logger.debug("onAuthenticationFailure managerId == " + username);

			// 로그아웃 처리
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();

			new SecurityContextLogoutHandler().logout(request, response, auth);
        } catch (Exception e) {
			e.printStackTrace();
		}

        response.sendRedirect(request.getContextPath() + "/login?returnCode=ERROR_INFO&returnUrl="+returnUrl);
	}

}