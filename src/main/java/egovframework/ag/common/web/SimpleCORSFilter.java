package egovframework.ag.common.web;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

public class SimpleCORSFilter extends OncePerRequestFilter {
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

	    response.setHeader("Access-Control-Allow-Origin", "*");
	    //response.addHeader("Access-Control-Allow-Origin", "http://testf.koreafilm.or.kr");
	    //response.addHeader("Access-Control-Allow-Origin", "http://www.koreafilm.or.kr");

	    response.setHeader("Access-Control-Allow-Methods", "POST, GET, DELETE, PUT");
	    response.setHeader("Access-Control-Max-Age", "3600");
	    response.setHeader("Access-Control-Allow-Headers", "x-requested-with, origin, content-type, accept");

	    filterChain.doFilter(request, response);
	}
}
