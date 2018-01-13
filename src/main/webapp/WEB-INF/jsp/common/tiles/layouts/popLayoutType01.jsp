<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko" xml:lang="ko">
<head>
<sec:csrfMetaTags />
<meta name="generator" content="ONEWARE">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, width=device-width">
<meta name="format-detection" content="telephone=no">
<meta name="robots" content="noindex, nofollow" />


<title><c:choose>
		<c:when test="${_title eq null or _title eq '' }">
			<tiles:getAsString name="title" />
		</c:when>
		<c:otherwise>
            ${_title }
        </c:otherwise>
	</c:choose></title>


<script type="text/javascript" src="<c:url value='/resources/js/lib/jquery-3.2.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/kmdb.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/lib/spin.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/lib/jquery.spin.js'/>"></script>
</head>
<body>
	<div id="wrap">
    <tiles:insertAttribute name="contents"/>
    </div>
</body>
</html>
