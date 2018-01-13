package egovframework.ag.common.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import egovframework.ag.common.Constant;

public class SessionUtil {
	public static void setValue(HttpServletRequest request, String header, Object value) {
		HttpSession session = request.getSession();

		session.setAttribute(header, value);
	}

	public static Object getValue(HttpServletRequest request, String header) {
		HttpSession session = request.getSession();

		return session.getAttribute(header);
	}

	public static void clearValue(HttpServletRequest request, String header) {
		HttpSession session = request.getSession();

		session.setAttribute(header, null);
	}

	public static void setErrorMsg(HttpServletRequest request, String message) {
		HttpSession session = request.getSession();
		session.setAttribute(Constant.GLOBAL_ERROR_MESSAGE, message);
	}

	public static String getErrorMsg(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Object objErrorMsg = session.getAttribute(Constant.GLOBAL_ERROR_MESSAGE);

		String errorMsg = "";
		if (StringUtils.isEmpty((String)objErrorMsg) == true) {
			errorMsg = "";
		}else {
			errorMsg = (String)objErrorMsg;
		}

		clearValue(request, Constant.GLOBAL_ERROR_MESSAGE);

		return errorMsg;
	}
}
