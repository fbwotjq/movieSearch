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

        <div id="divFilmo"></div>

        <%@ include file="/WEB-INF/jsp/db/personProfile.jsp"%>

        <%--
        <!-- slide tab -->
        <div class="mMenu1 type2">
            <!-- depth1 -->
            <div class="owl-carousel dep1 jsTab1" id="db-tab-menu3">
                <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>">기본정보</a>
                <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>/filmo" class="selected">필모그라피</a>
                <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>/festival">수상정보</a>
                <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>/story">관련글</a>
            </div>
            <!-- //depth1 -->
        </div>
        <!-- //slide tab -->
        --%>

        <!-- 필모그래피-->
        <div class="result-block pt0">
            <div class="result-block-tt type2 noline">
                <h4>필모그래피 (<span class="em weighty"><c:out value="${fn:length(filmoList) }"/></span>)</h4>
            </div>
            <!-- list -->
            <table border="1" class="data-table medium transform-m">
                <caption>필모그래피 테이블</caption>
                <colgroup>
                    <col style="width:11.5%">
                    <col style="*">
                    <col style="width:11.5%">
                    <col style="width:11.5%">
                    <col style="width:35%">
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">역할</th>
                    <th scope="col">영화명</th>
                    <th scope="col">역할명</th>
                    <th scope="col">장르명</th>
                    <th scope="col">소장자료</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="tempCreditId" value=""/>
                <c:forEach var="item" items="${filmoList }">
	                <tr>
	                    <c:if test="${item.creditId ne tempCreditId}">
	                        <c:set var="tempCreditId" value="${item.creditId}"/>
	                           <th class="bg1" rowspan="<c:out value="${item.creditGroupCnt }"/>"><c:out value="${item.creditNm }"/></th>
	                    </c:if>

	                    <td class="align-left20 fs18 blockForMobile"><a href="javascript:fcnMovieDetail('<c:out value="${item.movieId }"/>', '<c:out value="${item.movieSeq }"/>');" class="txtBlue"><c:out value="${item.title }"/></a>(<c:out value="${item.director }"/>, <c:out value="${item.prodYear }"/>)</td>
	                    <td class="dir"><span class="txtPurple"><c:out value="${item.staff }"/></span></td>
	                    <td><c:out value="${item.typeClss }"/></td>
	                    <td class="des align-left20">
	                        <c:set var="contentFlg" value="false"/>
	                        <c:if test="${item.filmCnt > 0 }">
	                            &nbsp;필름(<fmt:formatNumber value="${item.filmCnt }" groupingUsed="true"/>)
	                        </c:if>
	                        <c:if test="${item.cineCnt > 0 }">
	                            &nbsp;D시네마(<fmt:formatNumber value="${item.cineCnt }" groupingUsed="true"/>)
	                        </c:if>
                            <c:if test="${item.diskCnt > 0 }">
                                &nbsp;디스크(<fmt:formatNumber value="${item.diskCnt }" groupingUsed="true"/>)
                            </c:if>
	                        <c:if test="${item.tapeCnt > 0 }">
	                            &nbsp;테이프(<fmt:formatNumber value="${item.tapeCnt }" groupingUsed="true"/>)
	                        </c:if>
	                        <c:if test="${item.vodCnt > 0 }">
	                            &nbsp;VOD(<fmt:formatNumber value="${item.vodCnt }" groupingUsed="true"/>)
	                        </c:if>
	                        <c:if test="${item.snariCnt > 0 }">
	                            &nbsp;시나리오(<fmt:formatNumber value="${item.snariCnt }" groupingUsed="true"/>)
	                        </c:if>
	                    </td>
	                </tr>
                </c:forEach>
                </tbody>
            </table>
            <!--//list -->
        </div>
        <!-- //필모그래피 -->

        </section>
        </form>
    </div>
</div>


<script type="text/javascript" src="/resources/js/db.js"></script>

<script type="text/javascript">

	$(document).ready(function() {

	});
</script>