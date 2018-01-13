<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/resources/js/mypage.js"></script> <!-- js for mypage page -->
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/mypage.css">

<div id="contents" class="topfix">
	<div class="breadcrumb">
		<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
	</div>
	<div class="container">
		<div class="top-area">
			<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
		</div>
		<form id="form1" name="form1" method="post">
		<sec:csrfInput/>
        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>

			<section id="fieldset">
				<!-- module -->
				<div class="mView1">
					<div class="title">
						<h2><c:out value='${detailInfo.subject}'/></h2>
						<div class="sub-tt2">
							<c:out value='${detailInfo.createName}'/>
							<span class="dots"><c:out value='${detailInfo.createDate}'/></span>
						</div>
						<div class="sub-tt3">작품: <c:out value='${detailInfo.movieTitle} (${detailInfo.director}, ${detailInfo.prodYear})'/></div>
					</div>
					<div class="article">
						<c:out value="${detailInfo.contentDesc }" escapeXml="false"/>
					</div>
					<div class="btn-group large btnlist">
						<button class="btn large slightly" onClick="fncGoList();"><i class="ico-btnlist"></i><span>목록</span></button>
					</div>
				</div>
				<!-- //module -->
			</section>
		</form>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){

});

function fncGoList() {
    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._list_path}'/>";
    frm.submit();
}
</script>