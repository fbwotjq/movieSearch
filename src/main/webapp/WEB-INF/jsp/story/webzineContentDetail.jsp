<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

            <section id="fieldset">

                <!-- module -->
                <div class="mView1">
                    <div class="title">
                        <h2><c:out value="${detailInfo.subject }"/> <span class="ts"><c:out value="${detailInfo.subTitle }"/></span></h2>
                        <div class="sub-tt">
                            <span class="nam"><span>by.</span><c:out value="${detailInfo.writerName }"/></span>
                        </div>
                        <div class="bc">
                            <c:out value="${detailInfo.upSectionSubject }"/>
                            <c:if test="${not empty detailInfo.downCate }">
                                <strong class="cur"><c:out value="${detailInfo.downSectionSubject }"/></strong>
                            </c:if>
                        </div>
                    </div>
                    <div class="article">
                        <div class="img"><img src="<c:out value="${KF_FILM_UPLOAD_PATH}${detailInfo.contentImgPath }"/>" alt=""></div>

                        <c:out value="${detailInfo.content }" escapeXml="false" />


                        <c:if test="${not empty detailInfo.searchKeywordList }">
	                        <div class="mKeyword">
	                            <c:forEach var="item" items="${detailInfo.searchKeywordList }">
	                                <a href="javascript:fcnGoKeywordList('<c:out value="${item }"/>');"><span>#<c:out value="${item }"/></span></a>
	                            </c:forEach>
	                        </div>
                        </c:if>

                        <%-- <div class="type"><img src="/resources/images/movie/img_open.png" width="64" alt="공공누리 공공저작물"></div> --%>
                        <%-- <div class="alert">※ 본 게시물에는 작성자(필자)의 요청에 의해 복사, 마우스 드래그, 오른쪽 버튼 클릭 등 일부 기능 사용이 제한됩니다.</div> --%>
                    </div>
                    <div class="btn-group large btnlist">
                        <a class="btn large slightly" href="javascript:fcnGoList();"><i class="ico-btnlist"></i><span>목록</span></a>
                    </div>
                </div>
                <!-- //module -->
            </section>
        </form>
    </div>
</div>


<c:set var="lenSum" value="0"/>
<c:set var="lenSum" value="${lenSum + fn:length(relMovieList) }"/>
<c:set var="lenSum" value="${lenSum + fn:length(relPersonList) }"/>

<c:if test="${lenSum >0 }">
	<div class="gGrid1">
	    <div class="gridBg">
            <c:if test="${not empty relMovieList}">
	            <!-- 연관영화 -->
	            <div class="mList2">
	                <h4>연관영화</h4>
	                <ul>
	                    <c:forEach var="item" items="${relMovieList }">
	                        <li>
	                            <a href="###">
		                            <c:out value="${item.title }"/>
		                            <c:if test="${not empty item.orgTitle }">
		                                &nbsp;<c:out value="${item.orgTitle }"/>
		                            </c:if>
                                    <c:choose>
                                        <c:when test="${empty item.director && not empty item.prodYear}">
                                            &nbsp;(<c:out value="${item.prodYear }"/>)
                                        </c:when>
                                        <c:when test="${not empty item.director && empty item.prodYear}">
                                            &nbsp;(<c:out value="${item.director }"/>)
                                        </c:when>
                                        <c:when test="${not empty item.director && not empty item.prodYear}">
                                            &nbsp;(<c:out value="${item.director }"/> , <c:out value="${item.prodYear }"/>)
                                        </c:when>
                                        <c:otherwise></c:otherwise>
                                    </c:choose>
	                            </a>
	                        </li>
	                    </c:forEach>
	                </ul>
	            </div>
	            <!-- //연관영화 -->
            </c:if>

            <c:if test="${not empty relPersonList}">
		        <!-- 연관영화인 -->
		        <div class="mList2">
		            <h4>연관영화인</h4>
		            <ul>
		                <c:forEach var="item" items="${relPersonList }">
		                    <li>
		                        <a href="###">
		                            <c:out value="${item.name }"/>
		                            <c:out value="${item.personfield }"/>
		                            <c:if test="${not empty item.birthYear }">
		                                <c:out value="${item.birthYear }"/> ~ <c:out value="${item.deathYear }"/>
		                            </c:if>
		                        </a>
		                    </li>
		                </c:forEach>
		            </ul>
		        </div>
		        <!-- //연관영화인 -->
	        </c:if>

	    </div>
	</div>
	<!-- //grid1 -->
</c:if>


<script type="text/javascript">
$(document).ready(function(){
});

function fcnGoList () {
    formSubmit("form1", "<c:url value="/story/webzine/"/><c:out value="${detailInfo.webzineSeq}"/>");
}

function fcnGoKeywordList(pKeyword) {
    $("#_page").val("");
    $("#_pageSize").val("");
    formSubmit("form1", "<c:url value="/story/webzine/keyword/list"/>?keyword=" + pKeyword);
}
</script>