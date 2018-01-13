<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">


<div id="contents">
    <div class="breadcrumb">
        <%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
    </div>
    <div class="container">
        <div class="top-area pb1">
            <%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
        </div>

        <form id="form1" name="form1" method="post">
        <sec:csrfInput/>
        <input type="hidden" id="tabIndex" name="tabIndex" value="<c:out value="${paramMap.tabIndex }"/>">
        <section id="fieldset">

        <div id="divFestival"></div>

        <%@ include file="/WEB-INF/jsp/db/personProfile.jsp"%>

        <%--
        <!-- slide tab -->
        <div class="mMenu1 type2">
            <!-- depth1 -->
            <div class="owl-carousel dep1 jsTab1" id="db-tab-menu3">
                <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>">기본정보</a>
                <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>/filmo">필모그라피</a>
                <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>/festival" class="selected">수상정보</a>
                <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>/story">관련글</a>
            </div>
            <!-- //depth1 -->
        </div>
        <!-- //slide tab -->
        --%>

        <c:if test="${not empty festivalAwardsList }">
	        <!-- 수상정보 -->
	        <div class="result-block pt0">
	            <div class="result-block-tt type2">
	                <h4>수상정보</h4>
	            </div>
	            <!-- list -->
	            <div class="mList10">
	                <ul>
	                <c:forEach var="item" items="${festivalAwardsList }">
	                    <li>
	                        <span class="tit"><c:out value="${item.fedYear }"/>년 <a href="<c:url value="/db/festival/"/><c:out value="${item.feNo }"/>/<c:out value="${item.fedNo }"/>" class="txtBlue">제 <c:out value="${item.fedTime }"/>회 <c:out value="${item.nameKor }"/></a> <span>:</span></span>
	                        <span class="txt"><c:out value="${item.feaAword }"/>(<a href="javascript:fcnMovieDetail('<c:out value="${item.movieId }"/>', '<c:out value="${item.movieSeq }"/>');" class="txtBlue"><c:out value="${item.feaMovie }"/></a>)</span>
	                    </li>
	                </c:forEach>
	                </ul>
	            </div>
	            <!--//list -->
	        </div>
	        <!-- //수상정보 -->
        </c:if>

        <c:if test="${not empty personInfo.awardMoviesList || not empty personInfo.awardEtcList}">
	        <!-- 기타정보 -->
	        <div class="result-block mt1">
	            <div class="result-block-tt type2">
	                <h4>수상내역</h4>
	            </div>
	            <!-- list -->
	            <div class="mList11">
	                <dl>
	                    <c:if test="${not empty personInfo.awardMoviesList }">
		                    <dt>영화</dt>
		                    <c:forEach var="item" items="${personInfo.awardMoviesList }">
		                        <dd><c:out value="${item }"/></dd>
		                    </c:forEach>
	                    </c:if>

	                    <c:if test="${not empty personInfo.awardEtcList }">
		                    <dt>기타</dt>
		                    <c:forEach var="item" items="${personInfo.awardEtcList }">
		                        <dd><c:out value="${item }"/></dd>
		                    </c:forEach>
	                    </c:if>
	                </dl>
	            </div>
	            <!--//list -->
	        </div>
	        <!-- //기타정보 -->
        </c:if>

        </section>
        </form>
    </div>
</div>


<script type="text/javascript" src="/resources/js/db.js"></script>

<script type="text/javascript">

	$(document).ready(function() {

	});
</script>