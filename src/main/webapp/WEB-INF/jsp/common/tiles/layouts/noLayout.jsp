<%@page import="egovframework.ag.common.util.StringUtils"%>
<%@page import="egovframework.ag.common.util.SessionUtil"%>
<%@ page import="egovframework.ag.common.Constant" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="UPLOAD_WEB_PATH" value="<%=Constant.UPLOAD_WEB_PATH%>" scope="request"/>
<c:set var="VOD_PLAN_IMG_PATH" value="<%=Constant.UPLOAD_WEB_PATH+Constant.VOD_PLAN_IMG_PATH%>" scope="request"/>
<c:set var="FAQ_ATTCH_PATH" value="<%=Constant.UPLOAD_WEB_PATH+Constant.FAQ_ATTCH_PATH%>" scope="request"/>
<c:set var="MAIN_CONTENT_IMG_PATH" value="<%=Constant.UPLOAD_WEB_PATH+Constant.MAIN_CONTENT_IMG_PATH%>" scope="request"/>
<c:set var="THEME_KEYWORD_IMG_PATH" value="<%=Constant.UPLOAD_WEB_PATH+Constant.THEME_KEYWORD_IMG_PATH%>" scope="request"/>
<c:set var="MOVIE_STORY_IMG_PATH" value="<%=Constant.UPLOAD_WEB_PATH+Constant.MOVIE_STORY_IMG_PATH%>" scope="request"/>
<c:set var="ONLINE_ARCHIVES_PATH" value="<%=Constant.UPLOAD_WEB_PATH+Constant.ONLINE_ARCHIVES_PATH%>" scope="request"/>
<c:set var="KF_FILM_UPLOAD_PATH" value="<%=Constant.KF_FILM_UPLOAD_PATH%>" scope="request"/>
<c:set var="KF_FILM_IMAGE_PATH" value="<%=Constant.KF_FILM_IMAGE_PATH%>" scope="request"/>
<c:set var="MOVIE_POSTER_PATH" value="<%=Constant.MOVIE_POSTER_PATH%>" scope="request"/>
<c:set var="PERSON_IMG_PATH2" value="<%=Constant.PERSON_IMG_PATH2%>" scope="request"/>
<c:set var="EQUIP_IMG_PATH" value="<%=Constant.EQUIP_IMG_PATH%>" scope="request"/>
<tiles:insertAttribute name="contents"/>

