<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/resources/js/movie.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/movie.css">

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
        <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>
        <input type="hidden" id="searchType" name="searchType" value="<c:out value='${paramMap.searchType}'/>"/>
        <input type="hidden" id="searchText" name="searchText" value="<c:out value='${paramMap.searchText}'/>"/>
			<section id="fieldset">

				<!-- module -->
				<div class="mView1">
					<div class="title">
						<h2>${detailInfo.subject}</h2>
						<div class="sub-tt2">
							${detailInfo.createName}
							<span class="dots">${detailInfo.createDate}</span>
						</div>
						<div class="sub-tt3">작품 : ${detailInfo.movieTitle} (${detailInfo.director}, ${detailInfo.prodYear})</div>
					</div>
					<div class="article">
						<c:out value="${detailInfo.contentDesc }" escapeXml="false"/>
					</div>
					<div class="btn-group large btnlist"><a class="btn large slightly" href="#" onclick="fncGoList();"><i class="ico-btnlist"></i><span>목록</span></a></div>
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