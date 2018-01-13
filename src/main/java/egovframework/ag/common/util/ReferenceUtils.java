package egovframework.ag.common.util;


import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class ReferenceUtils {
	private final static Logger logger = LogManager.getLogger();
	public static final int INDEX_NOT_FOUND = -1;

	public static String getNavigationByPath(String contextPath, HashMap<String,Object> map) {

		String navigation = "<img src=\"" + contextPath + "/static/images/icon/iconPath.gif\" border=\"0\" /> ";
		navigation += "<a href=\"" + contextPath + "\" target=_top>HOME</a>";
		if(map!=null){
			navigation += " > " + map.get("NM1");
			navigation += " > " + map.get("NM2");
			navigation += " > " + map.get("NM3");
		}
		return navigation;
	}

	public static String getNavigationByPath2(String contextPath, HashMap<String,Object> map) {

		String navigation = "<img src=\"" + contextPath + "/static/images/icon/iconPath.gif\" border=\"0\" /> ";
		navigation += "<a href=\"/common/frameIndex\" target=_top>HOME</a>";
		if(map!=null){
			navigation += " > " + map.get("NM1");
			navigation += " > " + map.get("NM2");
			navigation += " > " + map.get("NM3");
		}
		return navigation;
	}

	public static String getMenuNameBy3Depth(String contextPath, HashMap<String,Object> map) {

		String menuName3Depth = "";
		if(map!=null){
			menuName3Depth += map.get("NM3");
		}
		return menuName3Depth;
	}
	public static String getNavigationByPage(String contextPath, int totalCount, int pageNum, int pageSize, int blockSize, String fncGubun) {
		StringBuffer navigation = new StringBuffer();

		String fncGubunName = "fncGoPage";
		if(fncGubun != null && !"".equals(fncGubun)){
			fncGubunName = fncGubunName + "_" + fncGubun;
		}
		Integer totalPage = 0;
		Integer totalBlock = 0;
		//Integer blockSize = 10;
		Integer nBlock = 1;
		Integer pageFirst = 1;
		Integer pageLast = 1;

		totalPage	= (int)Math.ceil((double)totalCount / pageSize);
		totalBlock	= (int)Math.ceil((double)totalPage / blockSize);
		nBlock		= (int)Math.ceil((double)pageNum / blockSize);
		pageFirst	= (nBlock-1)*blockSize;
		pageLast	= nBlock*blockSize;
		if(totalBlock <= nBlock)
			pageLast	= totalPage;

		navigation.append("<span class=\"left-box\">");
		if(nBlock > 1){
			navigation.append("<a class=\"btn first\" href=\"javascript:"+fncGubunName+"('" + pageFirst + "');\" >처음</a>");
		}
		if(pageNum > pageFirst+1 || nBlock > 1){
			navigation.append("<a class=\"btn prev\" href=\"javascript:"+fncGubunName+"('" + (pageNum-1)  + "');\" >이전</a>");
		}
		navigation.append("</span>");

		for(Integer i=pageFirst+1; i<=pageLast; i++){
			if(i==pageNum){
				navigation.append("<strong title=\"현재위치\"><span>"+i+"</span></strong>");
			}else{
				navigation.append("<a href=javascript:"+fncGubunName+"('" + i + "');><span>" + i + "</span></a>");
			}
		}

		navigation.append("<span class=\"right-box\">");
		if(pageNum < pageLast || nBlock < totalBlock){
			navigation.append("<a class=\"btn next\" href=\"javascript:"+fncGubunName+"('" + (pageNum+1)  + "');\" >다음</a>");
		}
		if(nBlock < totalBlock){
			navigation.append("<a class=\"btn last\" href=\"javascript:"+fncGubunName+"('" + (pageLast+1)  + "');\" >끝</a>");
		}
		navigation.append("</span>");

		logger.debug("pageNum : " + pageNum);
		return navigation.toString();
	}
	public static String getNavigationByPage(String contextPath, int totalCount, int pageNum, int pageSize, int blockSize) {

		return getNavigationByPage(contextPath, totalCount, pageNum, pageSize, blockSize, "");
	}

	//request 객체 모두 출력하기
	public static void getRequestNames(HttpServletRequest request){
		@SuppressWarnings("rawtypes")
		Enumeration enumer = request.getParameterNames();
		while(enumer.hasMoreElements()){
			String name = (String)enumer.nextElement();
			String values[] = request.getParameterValues(name);

			if(values != null){
				for(int i=0; i<values.length; i++){
					logger.debug(name + "( " + i + " )" + values[i]);
				}
			}
		}
	}

	public static String getRealClientIp(HttpServletRequest request){
		String userIp = null;

		userIp = request.getHeader("True-Client-IP");

		if( userIp == null || userIp.length() < 1){
            userIp = request.getHeader("X-Forwarded-For");
		}
		if( userIp == null || userIp.length() < 1){
 			userIp = request.getRemoteAddr();
 		}
		//개발시 로컬 체크 후 로컬 아이피 가져옴
		if(userIp.equals("0:0:0:0:0:0:0:1")||userIp.equals("127.0.0.1"))
		{
			InetAddress inetAddress = null;
			try
			{
				inetAddress = InetAddress.getLocalHost();
			}
			catch (UnknownHostException e)
			{
				logger.error("get Real Client Ip error "+ e);
			}
			userIp=inetAddress.getHostAddress();

		}

 		return userIp;
	}

	public static String getBrowser(HttpServletRequest request){
		String header = request.getHeader("User-Agent");
		if(header.indexOf("MSIE") > -1){
			return "MSIE";
		} else if(header.indexOf("Trident") > -1){
			return "Trident";
		} else if(header.indexOf("Chrome") > -1){
			return "Chrome";
		} else if(header.indexOf("Opera") > -1){
			return "Opera";
		}

		return "Firefox";
	}

	public static String getDisposition (String filename, String browser) {
		String encodedFilename = null;

		try{
			if(browser!=null){
				if(browser.equals("MSIE")) {
					encodedFilename = URLEncoder.encode(filename, "UTF-8")
						.replaceAll("\\+", "%20");
				} else if(browser.equals("Trident")) {
					encodedFilename = URLEncoder.encode(filename, "UTF-8")
							.replaceAll("\\+", "%20");
				} else if(browser.equals("Firefox")) {
					encodedFilename = new String(filename.getBytes("UTF-8"), "8859_1");
				} else if(browser.equals("Opera")) {
					encodedFilename = new String(filename.getBytes("UTF-8"), "8859_1");
				} else if(browser.equals("Chrome")) {
					StringBuffer sb = new StringBuffer();
					for(int i = 0; i < filename.length(); i++){
						char c = filename.charAt(i);
						if(c > '~'){
							sb.append(URLEncoder.encode("" + c, "UTF-8"));
						}else{
							sb.append(c);
						}
					}
					encodedFilename = sb.toString();
				}
			}
		}catch(Exception e){
			logger.debug("Exception getDisposition === " + e);

		}

		return encodedFilename;
	}

}
