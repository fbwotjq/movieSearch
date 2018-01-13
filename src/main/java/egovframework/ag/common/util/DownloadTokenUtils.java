package egovframework.ag.common.util;

import java.security.MessageDigest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/***********************************************************************************
 * PROJECT		: NIBE_HKB
 * PROGRAM ID	: DownloadTokenUtils.java
 * PROGRAM NAME	: 프로그램 이름
 * DESCRIPTION	: 프로그램 설명
 * AUTHOR		: admin(admin@asianaidt.com)
 * CREATED DATE	: 2014. 6. 12.
 * VERSION		: v1.0
 * HISTORY
 * =================================================================================
 *   DATE      NAME            DESCRIPTION
 * ---------------------------------------------------------------------------------
 * 2014. 6. 12.     admin       First  Generated
 ***********************************************************************************/
public class DownloadTokenUtils {
	//로거 선언
	private final static Logger logger = LogManager.getLogger();

	public static String setToken(){

		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = sra.getRequest();

		HttpSession sessionDown = (request).getSession(false);
		if( sessionDown == null ){
			sessionDown = (request).getSession(true);
		}
		long systime = System.currentTimeMillis();
		byte[] time = new Long(systime).toString().getBytes();
		byte[] id = sessionDown.getId().getBytes();
		String token = "";

		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			md5.update(id);
			md5.update(time);

			token = toHex(md5.digest());

			sessionDown.setAttribute("TOKEN",token);

		} catch( Exception e){
			logger.debug("Unable to calculate MD5 Diguests");
		}
		return token;
	}

	public static boolean isValid(HttpServletRequest request){
		HttpSession sessionDown = (request).getSession(false);
		String sessionToken = null;
		if(sessionDown!=null && sessionDown.getAttribute("TOKEN") != null){
			sessionToken = (String)sessionDown.getAttribute("TOKEN");
		}

		String requestToken = null;
		if(request.getParameter("TOKEN")!=null && request.getParameter("TOKEN").length()>0){
			requestToken = StringUtils.getStripTag((String)request.getParameter("TOKEN"));
		}

		if(requestToken == null || sessionToken == null){
			return false;
		}
		else{
			return requestToken.equals(sessionToken);
		}
	}

	public static void delToken(HttpServletRequest request){
		HttpSession sessionDown = (request).getSession(false);
		if(sessionDown!=null){
			sessionDown.setAttribute("TOKEN", null);
		}
	}

	private static String toHex(byte[] digest){
		StringBuffer buf = new StringBuffer();

		for(int i=0;i< digest.length;i++)
			buf.append(Integer.toHexString((int)digest[i] & 0x00ff));
		return buf.toString();
	}

}
