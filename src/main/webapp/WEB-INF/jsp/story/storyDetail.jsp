<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			<div class="submenu-depth3">
			<c:set var = "myMenuCnt" value="${menuIndex}"/>
			<c:set var = "myMenuId" value="${menuList[myMenuCnt].cPmenuId}"/>
			<c:set var = "myMenuTitle" value="${menuList[myMenuCnt].cPmenuTitle}"/>
			<c:set var = "myMenuLevel" value="${menuList[myMenuCnt].levelNum}"/>
			<c:set var = "parentMenuId" value="${menuList[myMenuCnt].cParentId}"/>
			<c:set var = "parentMenuCnt" value="0"/>
			<c:set var = "parentMenuTitle" value=""/>

			<c:forEach var="menuListVar" items="${menuList}" varStatus="i">
			<c:if test="${menuListVar.cPmenuId eq parentMenuId}">
				<c:set var = "parentMenuCnt" value="${i.index}"/>
				<c:set var = "parentMenuTitle" value="${menuListVar.cPmenuTitle}"/>
			</c:if>
			</c:forEach>
			<h3 class="submenu-depth3-title"><a href="#"><span>${myMenuTitle}</span><i class="ico-updown ico-down"></i></a></h3>

			<div class="submenu-depth-list submenu-depth3-list">
				<ul>
					<c:forEach var="menuListVar3" items="${menuList}" varStatus="k">
					<c:if test="${menuListVar3.cParentId eq parentMenuId}">
					<c:if test="${menuListVar3.cPmenuId eq  myMenuId}">
					<li class="selected"><a href="#">${menuListVar3.cPmenuTitle}</a></li>
					</c:if>
					<c:if test="${menuListVar3.cPmenuId ne  myMenuId}">
		                 <c:if test="${menuListVar3.leafYn ne 'Y' }">
		                	 <li><a href="javascript:menuMove('${menuListVar3.cPagePath}','${k.index}');">${menuListVar3.cPmenuTitle}</a></li>
		                 </c:if>
		                 <c:if test="${menuListVar3.leafYn eq 'Y' }">
		                     <li><a href="javascript:menuMove('${menuListVar3.cPagePath}','${k.index + 1}');">${menuListVar3.cPmenuTitle}</a></li>
		                 </c:if>
					</c:if>
					</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
        </div>
        <form id="form1" name="form1" method="post">
            <sec:csrfInput/>
            <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
            <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>
            <input type="hidden" id="searchType" name="searchType" value="<c:out value='${paramMap.searchType}'/>"/>
            <input type="hidden" id="searchText" name="searchText" value="<c:out value='${paramMap.searchText}'/>"/>
            <input type="hidden" id="searchOrderType" name="searchOrderType" value="<c:out value='${paramMap.searchOrderType}'/>"/>
            <input type="hidden" id="keyword" name="keyword" value=""/>

            <section id="fieldset">
                <!-- module -->
                <div class="mView1">
                    <div class="title">
                        <h2><c:if test="${detailInfo.subDiv2 != null}"><b>[<c:out value="${detailInfo.subDiv2 }"/>]</b>&nbsp; </c:if> <c:out value="${detailInfo.title }"/> <span class="ts"><c:out value="${detailInfo.subTitle }"/></span></h2>
                        <div class="sub-tt">
                            <span class="nam"><span>by.</span><c:out value="${detailInfo.writerName }"/> </span>
                            <fmt:parseDate value="${detailInfo.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
                            <span class="dat"><fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/></span>
                        </div>
                        <div class="sns">
                            <a href="#none" onclick="snsCon('fb', '<c:out value="${detailInfo.title}"/>', '<c:out value="${paramMap._full_path}"/>', '<c:out value="${detailInfo.creditsDesc}"/>', '<c:out value="${MOVIE_STORY_IMG_PATH}"/><c:out value="${detailInfo.fileName}"/>');" class="sns-facebook">facebook</a>
							<a href="#none" onclick="snsCon('tw', '<c:out value="${detailInfo.title}"/>#KMDb', '<c:out value="${paramMap._full_path}"/>');" class="sns-twitter">twitter</a>
                        </div>
                    </div>
                    <div class="article">
                        <c:choose>
                            <c:when test="${empty detailInfo.creditsDesc }">
                                <div class="img"><img src="${MOVIE_STORY_IMG_PATH}<c:out value="${detailInfo.fileName }"/>" alt="<c:out value="${detailInfo.fileAlt }"/>"></div>
                            </c:when>
                            <c:otherwise>
                                <!-- img -->
                                <div class="gImg">
                                	<span class="mImg1"><span style="background-image: url('${MOVIE_STORY_IMG_PATH}<c:out value="${detailInfo.fileName }"/>')"><img src="/resources/images/movie/img_movie_frame3.png" alt="${detailInfo.fileAlt }"></span></span>
                                    <%-- <div class="img"><img src="${MOVIE_STORY_IMG_PATH}<c:out value="${detailInfo.fileName }"/>" alt="<c:out value="${detailInfo.fileAlt }"/>"></div> --%>
                                    <div class="txt">
                                        <c:out value="${detailInfo.creditsDesc }" escapeXml="false"/>
                                    </div>
                                </div>
                                <!-- //img -->
                            </c:otherwise>
                        </c:choose>

                        <c:out value="${detailInfo.contentDesc }" escapeXml="false"/>


                        <c:if test="${not empty detailInfo.searchKeywordList }">
                            <div class="mKeyword">
                                <c:forEach var="item" items="${detailInfo.searchKeywordList }">
                                    <a href="javascript:fcnGoKeywordList('<c:out value="${item }"/>');"><span>#<c:out value="${item }"/></span></a>
                                </c:forEach>
                            </div>
                        </c:if>

                        <c:if test="${detailInfo.publicMark != 5}">
                            <div class="type"><img src="/resources/images/common/public_type<c:out value="${detailInfo.publicMark }"/>.jpg" width="64" alt="공공누리 공공저작물"></div>
                        </c:if>

                        <c:if test="${detailInfo.copyProtectionYn eq 'Y' }">
                            <div class="alert">※ 본 게시물에는 작성자(필자)의 요청에 의해 복사, 마우스 드래그, 오른쪽 버튼 클릭 등 일부 기능 사용이 제한됩니다.</div>
                        </c:if>
                    </div>
                    <div class="btn-group large btnlist"><a class="btn large slightly" href="javascript:fcnGoList();"><i class="ico-btnlist"></i><span>목록</span></a></div>

                    <c:if test="${not empty preDetailInfo }">
	                    <!-- 작가의 이전글 -->
	                    <div class="mWork">
	                        <a href="javascript:fcnDetail('<c:out value="${preDetailInfo.storyDivSeq}"/>', '<c:out value="${preDetailInfo.storySeq}"/>');">
	                            <!-- forMobile -->
	                            <span class="mImg1 forMobile"><span style="background-image: url('/resources/images/@temp/movie-view03.jpg')"></span></span>
	                            <!-- forPc -->
	                            <span class="mImg1 forPc"><span style="background-image: url('/resources/images/@temp/movie-view03-pc.jpg')"></span></span>
	                            <span class="text">
	                                <em class="tx1">작가의 이전글</em>
	                                <span class="tx2"><c:out value="${preDetailInfo.title }"/><span><c:out value="${preDetailInfo.subTitle }"/></span></span>
	                            </span>
	                        </a>
	                    </div>
	                    <!-- //작가의 이전글 -->
                    </c:if>

                    <c:if test="${not empty newMovieStoryList }">
	                    <!-- XXXX의 다른 글 -->
	                    <div class="mList2">
	                        <h4><c:out value="${detailInfo.storyDivTitle }"/>의 다른 글</h4>
	                        <ul>
	                            <c:forEach var="item" items="${newMovieStoryList }">
	                                <li>
	                                    <a href="javascript:fcnDetail('<c:out value="${item.storyDivSeq}"/>', '<c:out value="${item.storySeq}"/>');">
	                                        <span class="tit"><c:out value="${item.title }"/></span>
	                                        <span class="nam"><span>by.</span><c:out value="${item.writerName }"/></span>
                                            <fmt:parseDate value="${item.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
                                            <span class="dat"><fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/></span>
	                                    </a>
	                                </li>
	                            </c:forEach>
	                        </ul>
	                    </div>
	                    <!-- //한국영화 걸작선의 다른 글 -->
                    </c:if>

                </div>
                <!-- //module -->
            </section>
        </form>
    </div>
</div>


<c:set var="lenSum" value="0"/>
<c:set var="lenSum" value="${lenSum + fn:length(choiceMovieList) }"/>
<c:set var="lenSum" value="${lenSum + fn:length(relMovieList) }"/>
<c:set var="lenSum" value="${lenSum + fn:length(relPersonList) }"/>


<c:if test="${lenSum > 0 }">
<!-- grid1 -->
<div class="gGrid1">
    <div class="gridBg">
        <c:if test="${fn:length(choiceMovieList) > 0 }">
	        <!-- 추천 영화글 -->
	        <div class="mImage2">
	            <h4>추천 영화글</h4>
	            <div class="owl-carousel owl-theme" id="movie-recomd-carousel">
	                <c:forEach var="item" items="${choiceMovieList }">
	                    <div class="item">
	                        <a href="javascript:fcnDetail('<c:out value="${item.storyDivSeq}"/>', '<c:out value="${item.storySeq}"/>');">
	                            <span class="mImg1"><span style="background-image: url('${MOVIE_STORY_IMG_PATH}<c:out value="${item.fileName }"/>')"></span></span>
	                            <span class="hover">
	                                <span class="hoverBg">
	                                    <span class="tit"><c:out value="${item.title }"/></span>
	                                    <span class="nam"><span>by.</span><c:out value="${item.writerName }"/></span>
	                                    <fmt:parseDate value="${item.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
	                                    <span class="dat"><fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/></span>
	                                </span>
	                            </span>
	                        </a>
	                    </div>
	                </c:forEach>
	            </div>
	        </div>
	        <!-- //추천 영화글 -->
        </c:if>


        <c:forEach var="item" items="${relMovieList }">
        <!-- 연관영화 -->
        <div class="mList2">
             <h4>연관영화 : <span><c:out value="${item.title }"/> <c:out value="${item.orgTitle }"/> <c:out value="${item.director }"/> <c:out value="${item.prodYear }"/></span></h4>

             <c:if test="${fn:length(item.movieStoryList) > 0 }">
                 <ul>
                 <c:forEach var="subItem" items="${item.movieStoryList}">
	                 <li>
	                     <a href="javascript:fcnDetail('<c:out value="${subItem.storyDivSeq}"/>', '<c:out value="${subItem.storySeq}"/>');">
	                         <span class="tit"><c:out value="${subItem.title }"/></span>
	                         <span class="nam"><span>by.</span><c:out value="${subItem.writerName }"/></span>
	                         <fmt:parseDate value="${subItem.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
	                         <span class="dat"><fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/></span>
	                     </a>
	                 </li>
                 </c:forEach>
                 </ul>
            </c:if>
        </div>
        <!-- //연관영화 -->
        </c:forEach>

        <c:forEach var="item" items="${relPersonList }">
        <!-- 연관영화인 -->
        <div class="mList2">
            <h4>연관영화인 : <span><c:out value="${item.name }"/> <c:out value="${item.personfield }"/> <c:if test="${not empty item.birthYear }"><c:out value="${item.birthYear }"/> ~ <c:out value="${item.deathYear }"/></c:if></span></h4>

            <c:if test="${fn:length(item.movieStoryList) > 0 }">
                <ul>
                <c:forEach var="subItem" items="${item.movieStoryList}">
                     <li>
                         <a href="javascript:fcnDetail('<c:out value="${subItem.storyDivSeq}"/>','<c:out value="${subItem.storySeq}"/>');">
                             <span class="tit"><c:out value="${subItem.title }"/></span>
                             <span class="nam"><span>by.</span><c:out value="${subItem.writerName }"/></span>
                             <fmt:parseDate value="${subItem.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
                             <span class="dat"><fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/></span>
                         </a>
                     </li>
                </c:forEach>
                </ul>
            </c:if>
        </div>
        <!-- //연관영화인 -->
        </c:forEach>

    </div>
</div>
<!-- //grid1 -->

</c:if>

<script type="text/javascript">
$(document).ready(function(){
	setCopyProtection('<c:out value="${detailInfo.copyProtectionYn}"/>');
});

function fcnDetail(pStoryDivSeq, pStorySeq) {
	$("#_page").val("");
	$("#_pageSize").val("");
	$("#searchType").val("");
	$("#searchText").val("");
	$("#searchOrderType").val("");

	formSubmit("form1", "<c:url value="/story/"/>" + pStoryDivSeq + "/" + pStorySeq);
}


function fcnGoList() {
	formSubmit("form1", '<c:url value="/story/"/><c:out value="${detailInfo.storyDivSeq}"/>');
}

function fcnGoKeywordList(pKeyword) {
    $("#_page").val("");
    $("#_pageSize").val("");
    $("#searchType").val("");
    $("#searchText").val("");
    $("#searchOrderType").val("");
    $("#keyword").val(pKeyword);


    formSubmit("form1", '<c:url value="/story/keyword/list"/>');
}

</script>

<script type="text/javascript" src="/resources/js/vod.js"></script>
<script type="text/javascript" src="/resources/js/movie.js"></script>