package egovframework.ag.common.security;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import egovframework.ag.common.util.DateUtils;
import egovframework.ag.common.util.StringUtils;
import egovframework.ag.homepage.member.service.MemberService;

public class CustomSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	private RequestCache requestCache = new HttpSessionRequestCache();
	private String defaultUrl = "/main";
	private String returnUrl = null;
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Autowired
	private MemberService memberService;

	public String getReturnUrl() {
		return returnUrl;
	}

	public void setReturnUrl(String returnUrl) {
		this.returnUrl = returnUrl;
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws ServletException, IOException {
		MemberDetails memberDetail = null;

		String nowDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		String renewalDate = null;
		String passwordDate = null;
		Integer cntDiffDate = 0;

		String returnUrl = StringUtils.getStripTag(request.getParameter("returnUrl"));

		try {

			if (response.isCommitted()) {
				logger.debug("Can't redirect");
				return;
			}

			memberDetail = (MemberDetails) authentication.getPrincipal();


			if (memberDetail != null) {
				renewalDate = memberDetail.getRenewalDate();
				passwordDate = memberDetail.getPasswordDate();
			}

			if (renewalDate != null && renewalDate.length() > 0) {
				cntDiffDate = DateUtils.getDiffDays(renewalDate, nowDate);
			}

			logger.debug("cntDiffDate1 == " + cntDiffDate);

			if (cntDiffDate > 700 && cntDiffDate < 730) { // 회원 갱신
				returnUrl = "/member/renew?active=N";
			} else if (cntDiffDate >= 730 && cntDiffDate < 1825) { // 휴면 계정 활성화
				returnUrl = "/member/renew?active=Y";
				//returnUrl = "/member/active";
			} else if (cntDiffDate >= 1825) { // 탈퇴 처리
				returnUrl = "/member/autoout";
				//returnUrl = "/member/reset?keyParam=memberInfoDelete";
			} else { // 비밀번호 재설정
				if (passwordDate != null && passwordDate.length() > 0) {
					cntDiffDate = DateUtils.getDiffDays(passwordDate, nowDate);
				}

				logger.debug("cntDiffDate2 == " + cntDiffDate);

				if (cntDiffDate > 180) {
					returnUrl = "/member/repass";
				}
			}

			// 기존 데이터 외국일일 경우만 Y
			if (memberDetail.getForeign().equals("N")) {
				boolean cellPhone = getIsCellPhone(memberDetail.getCellno());
				if (!cellPhone) {
					returnUrl = "/mypage/check?returnCode=WRONG_CELLPHONE";
				}
			}

			this.setReturnUrl(returnUrl);

			memberService.updateLoginDate(memberDetail.getUserid());
		} catch (Exception e) {
			e.printStackTrace();
		}


		int intRedirectStrategy = decideRedirectStrategy(request, response);

		logger.debug("intRedirectStrategy : " + intRedirectStrategy);

		switch (intRedirectStrategy) {
		case 1:
			useTargetUrl(request, response);
			break;
		case 2:
			useSessionUrl(request, response);
			break;
		case 3:
			useRefererUrl(request, response);
			break;
		default:
			useDefaultUrl(request, response);
		}

	}

	private boolean getIsCellPhone(String sessionPhone) {
		boolean cellPhone = true;
		if(sessionPhone==null){
			cellPhone = false;
		}else{
			int count = sessionPhone.split("-").length;

			if(count==3){
				String regex = "^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$";
				if (!Pattern.matches(regex, sessionPhone)){
					cellPhone = false;
				}

			}else{
				cellPhone = false;
			}
		}
		return cellPhone;
	}

	private void useTargetUrl(HttpServletRequest request, HttpServletResponse response) throws IOException{
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		if(savedRequest != null){
			requestCache.removeRequest(request, response);
		}
		String targetUrl = this.getReturnUrl();
		String movieReservationHost = "http://m.koreafilm.tmsp.co.kr";
		if(targetUrl.indexOf(movieReservationHost)!=-1){
			String scheme = request.getScheme();
			String serverName = request.getServerName();
			int serverPort = request.getServerPort();
			targetUrl = scheme+"://"+serverName+":"+serverPort+"/cinematheque/schedule";
		}

		logger.debug("useTargetUrl >> targetUrl : " + targetUrl);

		redirectStrategy.sendRedirect(request, response, targetUrl);
	}

	private void useSessionUrl(HttpServletRequest request, HttpServletResponse response) throws IOException{
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String targetUrl = savedRequest.getRedirectUrl();

		logger.debug("useSessionUrl >> targetUrl : " + targetUrl);

		redirectStrategy.sendRedirect(request, response, targetUrl);
	}

	private void useRefererUrl(HttpServletRequest request, HttpServletResponse response) throws IOException{
		String targetUrl = request.getHeader("REFERER");

		logger.debug("useRefererUrl >> targetUrl : " + targetUrl);

		redirectStrategy.sendRedirect(request, response, targetUrl);
	}

	private void useDefaultUrl(HttpServletRequest request, HttpServletResponse response) throws IOException{
		logger.debug("useDefaultUrl >> targetUrl : " + defaultUrl);

		redirectStrategy.sendRedirect(request, response, defaultUrl);
	}

	/*
     * 인증 성공후 어떤 URL로 redirect 할지를 결정한다
     * 판단 기준은 targetUrlParameter 값을 읽은 URL이 존재할 경우 그것을 1순위
     * 1순위 URL이 없을 경우 Spring Security가 세션에 저장한 URL을 2순위
     * 2순위 URL이 없을 경우 Request의 REFERER를 사용하고 그 REFERER URL이 존재할 경우 그 URL을 3순위
     * 3순위 URL이 없을 경우 Default URL을 4순위로 한다
     * @param request
     * @param response
     * @return    1 : targetUrlParameter 값을 읽은 URL
     *            2 : Session에 저장되어 있는 URL
     *            3 : referer 헤더에 있는 url - referer 가 로그인 실패일경우 무한 로그아웃현상
     *            0 : default url
	 */
	private int decideRedirectStrategy(HttpServletRequest request, HttpServletResponse response){
		int result = 0;
		SavedRequest savedRequest = requestCache.getRequest(request, response);

		String targetUrl = this.getReturnUrl();
		if(targetUrl!=null&&targetUrl.length()>1){
			result = 1;
		}else if(savedRequest != null){
			result = 2;
		}else{
			String refererUrl = request.getHeader("REFERER");
			if(refererUrl!=null && refererUrl.length()>0){
				if(refererUrl.indexOf("/login") != -1){
					result = 0;
				}else{
					result = 3;
				}
			}else{
				result = 0;
			}
		}
		return result;
	}

}
