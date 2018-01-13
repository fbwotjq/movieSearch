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
        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
        <section id="fieldset">

        <div id="divStory"></div>

        <%@ include file="/WEB-INF/jsp/db/personProfile.jsp"%>
        <%--
		<!-- slide tab -->
		<div class="mMenu1 type2">
		    <!-- depth1 -->
		    <div class="owl-carousel dep1 jsTab1" id="db-tab-menu3">
		        <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>" class="selected">기본정보</a>
		        <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>/filmo">필모그라피</a>
		        <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>/festival">수상정보</a>
		        <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>/story">관련글</a>
		    </div>
		    <!-- //depth1 -->
		</div>
		<!-- //slide tab -->
		--%>

        <!-- 관련글 -->
        <div class="result-block pt0">
            <div class="result-block-tt type2">
                <h4>관련글 (<span class="em weighty"><fmt:formatNumber value="${pageListVo.totalCount}" groupingUsed="true"/></span>)</h4>
                <div class="rt">
                    <div class="dbinfo-table-sort">
	                    <div class="area">
	                        <label for="searchOrderType" class="blind">내림차순</label>
	                        <select id="searchOrderType" name="searchOrderType" class="select-tric">
	                            <option value="DESC" <c:if test="${empty paramMap.searchOrderType || paramMap.searchOrderType == 'DESC' }">selected="selected"</c:if>>내림차순</option>
	                            <option value="ASC"  <c:if test="${paramMap.searchOrderType == 'ASC' }">selected="selected"</c:if>>오름차순</option>
	                        </select>
	                    </div>
	                    <div class="area">
	                        <label for="_pageSize" class="blind">한페이지 출력물수</label>
	                        <select id="_pageSize" name="_pageSize" class="select-tric">
	                            <option value="10" <c:if test="${empty paramMap._pageSize || paramMap._pageSize == '10' }">selected="selected"</c:if>>10개 출력</option>
	                            <option value="20" <c:if test="${paramMap._pageSize == '20' }">selected="selected"</c:if>>20개 출력</option>
	                        </select>
	                    </div>
                    </div>
                </div>
            </div>
            <!-- list -->
            <div class="mImage1">
                <ul>
                    <c:forEach var="item" items="${pageListVo.resultList }">
	                    <li>
	                        <span class="mImg1"><span style="background-image: url('${MOVIE_STORY_IMG_PATH}<c:out value="${item.fileName }"/>')"></span></span>
	                        <span class="text">
	                            <a href="<c:url value="/story/"/><c:out value="${item.storyDivSeq }"/>/<c:out value="${item.storySeq }"/>" class="tit"><c:out value="${item.title }"/></a>
	                            <span class="des"><c:out value="${item.shortNonTagContentDesc }" escapeXml="false"/></span>
                                <span class="nam"><span>by.</span><c:out value="${item.writerName }"/></span>
                                <fmt:parseDate value="${item.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
                                <span class="dat"><fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/></span>
	                        </span>
	                    </li>
                    </c:forEach>
                </ul>
            </div>
            <!--//list -->

            <div class="paging-area">
                <!-- pagination -->
                <div class="pagination medium">${paging}</div>
                <!-- //pagination -->
            </div>
        </div>
        <!-- //관련글 -->

        </section>
        </form>
    </div>
</div>


<script type="text/javascript" src="/resources/js/db.js"></script>

<script type="text/javascript">

$(document).ready(function() {
    $("#_pageSize, #searchOrderType").bind("change", function() {
        fcnSearch();
    });
});

function fcnSearch() {
    $("#_page").val("1");
    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
}

function fncGoPage(nPage){
    $("#_page").val(nPage);
    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
}

</script>