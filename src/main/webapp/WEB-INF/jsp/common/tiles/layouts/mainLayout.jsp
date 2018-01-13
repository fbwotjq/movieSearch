<%@page import="egovframework.ag.common.util.StringUtils"%>
<%@page import="egovframework.ag.common.util.SessionUtil"%>
<%@ page import="egovframework.ag.common.Constant" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko" xml:lang="ko">
<head>
<sec:csrfMetaTags/>
<meta name="generator" content="ONEWARE">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, width=device-width">
<meta name="format-detection" content="telephone=no">
<meta name="robots" content="noindex, nofollow" />

<tiles:importAttribute name="commonStyle" />
<tiles:importAttribute name="commonScript" />

<title><c:choose>
		<c:when test="${_title eq null or _title eq '' }">
			<tiles:getAsString name="title" />
		</c:when>
		<c:otherwise>
            ${_title }
        </c:otherwise>
	</c:choose></title>

<c:forEach var="item" items="${commonStyle}">
	<link rel="stylesheet" type="text/css" href="<c:url value="${item}"/>">
</c:forEach>

<script type="text/javascript" src="<c:url value='/resources/js/lib/jquery-3.2.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/kmdb.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/kmdbAjax.js'/>"></script>

<%
    String errorMessage = SessionUtil.getErrorMsg(request);

    if (StringUtils.isEmpty(errorMessage) == false) {
%>
    <script type="text/javascript">
    	showAlert("<%= errorMessage%>");
    </script>
<%
    }
%>

<script type="text/javascript">
	var UPLOAD_WEB_PATH = "<%=Constant.UPLOAD_WEB_PATH%>";
	var VOD_PLAN_IMG_PATH = UPLOAD_WEB_PATH+"<%=Constant.VOD_PLAN_IMG_PATH%>";
    var FAQ_ATTCH_PATH = UPLOAD_WEB_PATH+"<%=Constant.FAQ_ATTCH_PATH%>";
    var MAIN_CONTENT_IMG_PATH = UPLOAD_WEB_PATH+"<%=Constant.MAIN_CONTENT_IMG_PATH%>";
    var THEME_KEYWORD_IMG_PATH = UPLOAD_WEB_PATH+"<%=Constant.THEME_KEYWORD_IMG_PATH%>";
    var MOVIE_STORY_IMG_PATH = UPLOAD_WEB_PATH+"<%=Constant.MOVIE_STORY_IMG_PATH%>";
	var KF_FILM_UPLOAD_PATH = "<%= Constant.KF_FILM_UPLOAD_PATH%>";
	var KF_FILM_IMAGE_PATH = "<%= Constant.KF_FILM_IMAGE_PATH%>";
	var EQUIP_IMG_PATH = "<%= Constant.EQUIP_IMG_PATH%>";
</script>
<c:set var="UPLOAD_WEB_PATH" value="<%=Constant.UPLOAD_WEB_PATH%>" scope="request"/>
<c:set var="VOD_PLAN_IMG_PATH" value="<%=Constant.UPLOAD_WEB_PATH+Constant.VOD_PLAN_IMG_PATH%>" scope="request"/>
<c:set var="FAQ_ATTCH_PATH" value="<%=Constant.UPLOAD_WEB_PATH+Constant.FAQ_ATTCH_PATH%>" scope="request"/>
<c:set var="MAIN_CONTENT_IMG_PATH" value="<%=Constant.UPLOAD_WEB_PATH+Constant.MAIN_CONTENT_IMG_PATH%>" scope="request"/>
<c:set var="THEME_KEYWORD_IMG_PATH" value="<%=Constant.UPLOAD_WEB_PATH+Constant.THEME_KEYWORD_IMG_PATH%>" scope="request"/>
<c:set var="MOVIE_STORY_IMG_PATH" value="<%=Constant.UPLOAD_WEB_PATH+Constant.MOVIE_STORY_IMG_PATH%>" scope="request"/>
<c:set var="KF_FILM_UPLOAD_PATH" value="<%=Constant.KF_FILM_UPLOAD_PATH%>" scope="request"/>
<c:set var="KF_FILM_IMAGE_PATH" value="<%=Constant.KF_FILM_IMAGE_PATH%>" scope="request"/>
<c:set var="EQUIP_IMG_PATH" value="<%=Constant.EQUIP_IMG_PATH%>" scope="request"/>

</head>
<body class="main">
	<!-- 스킵 네비게이션(s) -->
	<div id="skipNavigation">
		<ul>
			<li><a href="#contents">본문 바로가기</a></li>
			<li><a href="#headerGnb">전체메뉴 바로가기</a></li>
			<li><a href="#footer">하단 바로가기</a></li>
		</ul>
	</div>
	<!--// 스킵 네비게이션(e) -->

	<div id="wrap">
	    <tiles:insertAttribute name="header" />

		<tiles:insertAttribute name="contents" />

		<tiles:insertAttribute name="footer" />
	</div>

<c:forEach var="item" items="${commonScript}">
    <script type="text/javascript" src="<c:url value='${item}'/>"></script>
</c:forEach>
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
</body>
</html>
