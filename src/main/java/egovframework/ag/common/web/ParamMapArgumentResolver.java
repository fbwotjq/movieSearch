package egovframework.ag.common.web;

import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.MethodParameter;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import egovframework.ag.common.Constant;
import egovframework.ag.common.util.StringUtils;

public class ParamMapArgumentResolver implements HandlerMethodArgumentResolver {

	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		return ParamMap.class.isAssignableFrom(parameter.getParameterType());
	}

	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		ParamMap paramMap = new ParamMap();

		for (Iterator<String> iterator = webRequest.getParameterNames(); iterator.hasNext();) {
			String key = iterator.next();
			paramMap.put(key, webRequest.getParameter(key));
		}

		String pageInitParam = paramMap.getString(Constant.PAGE_INIT);
		String pageParam = paramMap.getString(Constant.PAGE);
		String pageSizeParam = paramMap.getString(Constant.PAGE_SIZE);
		String pageGetParam = paramMap.getString(Constant.PAGE_PARAM);

		if (pageParam == null || pageParam.equals("") || Integer.parseInt(pageParam) <= 0) {
			paramMap.put(Constant.PAGE, "1");
		}

		if (pageSizeParam == null || pageSizeParam.equals("")) {
			paramMap.put(Constant.PAGE_SIZE, "10");
		}

		if (pageInitParam != null && pageInitParam.equals("T")) {
			paramMap.put(Constant.PAGE, "1");
		}

		if (pageGetParam != null && StringUtils.isEmpty(pageGetParam) == false) {
			paramMap.putBase64ParamString(StringUtils.getString(paramMap.get(Constant.PAGE_PARAM)));
		}

		Device device = DeviceUtils.getCurrentDevice(webRequest);
		//모바일이나 태블릿은 페이지를 5개만 노출
        if (device != null && (device.isMobile() || device.isTablet())) {
        	paramMap.put(Constant.PAGE_BLOCK, "5");
        }else{
        	paramMap.put(Constant.PAGE_BLOCK, "10");
        }

		String viewPath = ((HttpServletRequest)webRequest.getNativeRequest()).getRequestURI();

		//common param put
		paramMap.put(Constant.FULL_PATH, ((HttpServletRequest)webRequest.getNativeRequest()).getRequestURL());
		paramMap.put(Constant.CONTEXT_PATH, webRequest.getContextPath());
		paramMap.put(Constant.VIEW_PATH, webRequest.getContextPath() + viewPath);
		paramMap.put(Constant.LIST_PATH, webRequest.getContextPath() + viewPath.substring(0, viewPath.lastIndexOf("/")));

		System.out.println("paramMap ######################################################################################################");
		System.out.println(paramMap.toString());
		System.out.println("paramMap ######################################################################################################");


		return paramMap;
	}
}
