package egovframework.ag.common.interceptor;


import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.ag.common.web.MenuMap;
import egovframework.ag.homepage.common.service.CommonService;

public class GlobalInterceptor extends HandlerInterceptorAdapter {

	private final static Logger logger = LogManager.getLogger();

	@Autowired
	private CommonService commonService;

	@Value(value="${active.type}")
	private String activeType;

	@Override
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception {

		logger.debug("===========================          START         ===========================");
		logger.debug(" Request URI \t:  " + request.getRequestURI());

	    Enumeration<String> paramNames = request.getParameterNames();
	    while (paramNames.hasMoreElements()) {
	      String key = (String) paramNames.nextElement();
	      String value = request.getParameter(key);
	      logger.debug(" RequestParameter Data ==>  " + key + " : " + value + "");
	    }

        return true;

    }

    @Override
    public void postHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler, ModelAndView model) throws Exception {

    	String url_ = request.getServletPath();
    	if(url_ != null && url_.length() > 1){ // 경로가 '/' 일때는 체크 안함. '/' => '/main' 을 호출하기 때문
    		if(model != null){
        		Map<String, Object> m = model.getModel();
        		Object o = m.get("menuList");
        		if(o == null){
            		//model.addObject("menuList", commonService.selectMenuList());
        			model.addObject("menuList", MenuMap.getMenuList());
        		}
        	}else{
        		model = new ModelAndView();
        		//model.addObject("menuList", commonService.selectMenuList());
        		model.addObject("menuList", MenuMap.getMenuList());
        	}

    		String menuIndex = request.getParameter("menuIndex");
    		if(menuIndex != null && !"".equals(menuIndex)){
        		model.addObject("menuIndex", menuIndex);
    		}else{
    	        model.addObject("menuIndex", MenuMap.getMenuNumForURL(request.getServletPath()));
    		}
		}

    }

    @Override
    public void afterCompletion(HttpServletRequest request,
            HttpServletResponse response, Object handler, Exception ex) throws Exception {
    }

}