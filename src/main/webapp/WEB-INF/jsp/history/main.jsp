<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/archives.css">

    <c:if test="${not empty talkList }">
	    <!-- 구술채록문 -->
	    <div class="mMArchives1">
	        <div class="archives1bg">
	            <div class="mTitle6">
	                <h3>구술채록문</h3>
	                <a href="<c:url value="/history/talk"/>" class="more">더보기</a>
	            </div>
	            <!-- list -->
	            <div class="owl-carousel owl-theme" id="archives-main-list1">
	                <c:forEach var="item" items="${talkList }">
	                    <div class="item">
	                        <a href="<c:url value="/history/talk/"/><c:out value="${item.archivesSeq }"/>">
	                            <span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></span>
	                            <span class="txt"><em><c:out value="${item.targetName }"/></em> <span><c:out value="${item.birthYear }"/></span></span>
	                        </a>
	                    </div>
	                </c:forEach>
	            </div>
	            <!-- //list -->
	            <p class="info"><span class="br">인터뷰를 통해 재현한 생생한</span> 그 시대로 여행을 떠나보세요</p>
	        </div>
	    </div>
	    <!-- //구술채록문 -->
    </c:if>


    <div id="contents">
        <c:if test="${not empty mainArchivesContentList }">
	        <!-- 사료 콘텐츠 -->
	        <div class="mMArchives2">
	            <div class="mTitle6">
	                <h3>사료 콘텐츠</h3>
	                <a href="<c:url value="/history/contents"/>" class="more">더보기</a>
	            </div>
	            <ul>
	            <c:if test="${not empty mainArchivesContentList[0] }">
	                <li class="type1">
	                    <span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${mainArchivesContentList[0].fileName }"/>')"></span></span>
	                    <span class="text">
	                        <span class="textBg">
	                            <span class="tit"><a href="<c:url value="/history/contents/"/><c:out value="${mainArchivesContentList[0].archivesSeq }"/>"><span><c:out value="${mainArchivesContentList[0].subject }"/></span></a></span>
	                            <span class="nam"><span>by.</span><c:out value="${mainArchivesContentList[0].targetName }"/></span>
	                            <span class="des"><c:out value="${mainArchivesContentList[0].nonTagContents }" escapeXml="false"/></span>
	                        </span>
	                    </span>
	                    <span class="line"></span>
	                </li>
	            </c:if>
	            <c:if test="${not empty mainArchivesContentList[1] }">
	                <li class="type2">
	                    <div class="gLeft">
	                        <div class="leftBg">
	                            <span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${mainArchivesContentList[1].fileName }"/>')"></span></span>
	                            <span class="text">
	                                <span class="tit"><a href="<c:url value="/history/contents/"/><c:out value="${mainArchivesContentList[1].archivesSeq }"/>"><span><c:out value="${mainArchivesContentList[1].subject }"/></span></a></span>
	                                <span class="nam"><span>by.</span><c:out value="${mainArchivesContentList[1].targetName }"/></span>
	                            </span>
	                        </div>
	                    </div>
	                    <div class="gRight">
	                        <span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${mainArchivesContentList[1].gallaryFileName }"/>')"></span></span>
	                    </div>
	                </li>
	            </c:if>
	            </ul>
	        </div>
	        <!-- //사료 콘텐츠 -->
        </c:if>


        <!-- 한국영화사료관 콘텐츠 -->
        <div class="mMArchives3">
            <strong class="title">한국영화사료관 콘텐츠 <span>1950s movie out story</span></strong>

            <c:if test="${not empty magazineList }">
	            <!-- 영화잡지 -->
	            <div class="list1">
	                <div class="mTitle6">
	                    <h3>영화잡지</h3>
	                    <a href="<c:url value="/history/magazine"/>" class="more">더보기</a>
	                </div>
	                <ul>
	                    <c:forEach var="item" items="${magazineList }" varStatus="status">
	                        <c:choose>
	                            <c:when test="${status.count <= 3 }">
                                    <li><a href="<c:url value="/history/magazine/"/><c:out value="${item.archivesSeq }"/>"><span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></span></a></li>
	                            </c:when>
	                            <c:otherwise>
                                    <li class="forPc"><a href="<c:url value="/history/magazine/"/><c:out value="${item.archivesSeq }"/>"><span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></span></a></li>
	                            </c:otherwise>
	                        </c:choose>
	                    </c:forEach>
	                </ul>
	            </div>
	            <!-- //영화잡지 -->
            </c:if>

            <c:if test="${not empty documentList }">
	            <!-- 공문서 -->
	            <div class="list2">
	                <div class="mTitle6">
	                    <h3>공문서</h3>
	                    <a href="<c:url value="/history/document"/>" class="more">더보기</a>
	                </div>
	                <ul>
                        <c:forEach var="item" items="${documentList }" varStatus="status">
                            <c:choose>
                                <c:when test="${status.count <= 3 }">
                                    <li><a href="<c:url value="/history/document"/>"><span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></span></a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="forPc"><span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></span></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
	                </ul>
	            </div>
	            <!-- //공문서 -->
            </c:if>


            <c:if test="${not empty bookList }">
	            <!-- 발간도서 -->
	            <div class="list3">
	                <div class="mTitle6">
	                    <h3>발간도서</h3>
	                    <a href="<c:url value="/history/book"/>" class="more">더보기</a>
	                </div>
	                <ul>
                        <c:forEach var="item" items="${bookList }" varStatus="status">
                            <c:choose>
                                <c:when test="${status.count <= 3 }">
                                    <li><a href="<c:url value="/history/book/"/><c:out value="${item.archivesSeq }"/>"><span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></span></a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="forPc"><a href="<c:url value="/history/book/"/><c:out value="${item.archivesSeq }"/>"><span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></span></a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
	                </ul>
	            </div>
	            <!-- //발간도서 -->
            </c:if>
        </div>
        <!-- //한국영화사료관 콘텐츠 -->


        <!-- 검색 -->
        <div class="vod-search">
            <div class="search">
                <input type="text" placeholder="사료관 자료를 검색해보세요">
                <button class="ico-search">검색</button>
            </div>
            <div class="go">
                <a href="<c:url value="/history/talk/intro"/>">구술 사업소개</a>
                <a href="<c:url value="/history/yearbook/intro"/>">연감/총서 소개</a>
                <a href="<c:url value="/history/document/intro"/>">공문서 소개</a>
            </div>
        </div>
        <!-- //검색 -->

    </div>

    <c:if test="${not empty theaterList }">
	    <!-- 서울의 극장 -->
	    <div class="mMArchives4">
	        <div class="archives4bg">
	            <h3>서울의 극장</h3>
	            <div class="tit">
	                <img src="/resources/images/archives/txt_archives3_1.png" alt="누구나 마음 속에 간직하고 있는 추억의 영화가 있습니다." class="forPc">
	                <img src="/resources/images/archives/txt_archives3_1_m.png" alt="누구나 마음 속에 간직하고 있는 추억의 영화가 있습니다." class="forMobile">
	            </div>
	            <p class="info">1955~1956년 서울의 극장에서 상영된 영화 정보와 신문광고 이미지를 보실 수 있습니다</p>
	        </div>
	        <!-- list -->
	        <div class="owl-carousel owl-theme" id="archives-main-list2">
	            <c:forEach var="item" items="${theaterList }">
	                <div class="item">
	                    <a href="###">
	                        <span class="mImg1"><span style="background-image: url('${MAIN_CONTENT_IMG_PATH}<c:out value="${item.fileName }"/>')"></span></span>
	                        <span class="txt"><c:out value="${item.title }"/></span>
	                    </a>
	                </div>
	            </c:forEach>
	        </div>
	        <!-- //list -->
	    </div>
	    <!-- //서울의 극장 -->
    </c:if>

<script type="text/javascript" src="/resources/js/archives.js"></script> <!-- js for archives page -->

<script type="text/javascript">
$(document).ready(function(){

});

</script>