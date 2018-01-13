<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">

<c:if test="${not empty keywordList }">
<!-- 키워드 -->
<div class="mMDb1">
    <!-- list -->
    <div class="list">
        <div class="owl-carousel owl-theme" id="db-main-cate1">
            <c:forEach var="item" items="${keywordList }">
	            <!-- item -->
	            <div class="item" style="background-image: url('${MAIN_CONTENT_IMG_PATH}<c:out value="${item.fileName }"/>');">
	                <div class="back"></div>
	                <div class="db1bg">
	                    <h3><a href="<c:out value="${item.url }"/>"><span><c:out value="${item.title }"/></span></a></h3>
	                    <div class="mTag1">
	                        <c:forEach var="subItem" items="${item.tagList }">
                                <a href="<c:out value="${subItem.url }"/>">#<c:out value="${subItem.title }"/></a>
	                        </c:forEach>
	                    </div>
	                    <div class="button">
	                        <span class="ls">
	                            <a href="<c:url value="/db/kor"/>">
	                                <span class="mImg1"><span style="background-image: url('/resources/images/@temp/dbmain01-02.jpg')"></span></span>
	                                <span class="arr">영화 상세검색</span>
	                            </a>
	                        </span>
	                        <span class="ls">
	                            <a href="<c:url value="/db/per"/>">
	                                <span class="mImg1"><span style="background-image: url('/resources/images/@temp/dbmain01-03.jpg')"></span></span>
	                                <span class="arr">영화인 상세검색</span>
	                            </a>
	                        </span>
	                    </div>
	                </div>
	            </div>
	            <!-- //item -->
            </c:forEach>
        </div>
    </div>
    <!-- //list -->
</div>
<!-- //키워드 -->
</c:if>

<!-- 소장자료 검색 TODO - 소장자료 카운트-->
<div class="mMDb2">
    <div class="db2bg">
        <h3><span>소장자료 검색</span> <em>CATEGORY</em></h3>
        <!-- list -->
        <div class="list">
            <div class="owl-carousel owl-theme" id="db-main-cate2">
                <div class="item">
                    <a href="###" class="ico1">필름/D시네마 <strong>(1,758)</strong></a>
                </div>
                <div class="item">
                    <a href="###" class="ico2">비디오 <strong>(9998)</strong></a>
                </div>
                <div class="item">
                    <a href="###" class="ico3">동영상 <strong>(9998)</strong></a>
                </div>
                <div class="item">
                    <a href="###" class="ico4">이미지 <strong>(9998)</strong></a>
                </div>
                <div class="item">
                    <a href="###" class="ico5">시나리오/콘티 <strong>(9998)</strong></a>
                </div>
                <div class="item">
                    <a href="###" class="ico6">도서/논문 <strong>(9998)</strong></a>
                </div>
                <div class="item">
                    <a href="###" class="ico6">OST <strong>(9998)</strong></a>
                </div>
                <div class="item">
                    <a href="###" class="ico7">심의서류 <strong>(9998)</strong></a>
                </div>
                <div class="item">
                    <a href="###" class="ico8">박물류 <strong>(9998)</strong></a>
                </div>
            </div>
        </div>
        <!-- //list -->
    </div>
</div>
<!-- //소장자료 검색 -->

<c:if test="${not empty festivalList }">
<!-- 영화제 -->
<div class="mMDb3">
    <div class="mTitle6">
        <h3>영화제</h3>
        <a href="<c:url value="/db/festival/"/>" class="more">더보기</a>
    </div>
    <!-- list -->
    <div class="list">
        <div class="owl-carousel owl-theme" id="db-main-cate3">
            <c:forEach var="item" items="${festivalList }">
	            <div class="item">
	                <div class="con">
	                    <div class="mImg1"><span style="background-image: url('${MAIN_CONTENT_IMG_PATH}<c:out value="${item.fileName }"/>');"></span></div>
	                    <div class="text">
	                        <strong class="tit"><a href="<c:url value="/db/festival/"/><c:out value="${item.feNo }"/>/<c:out value="${item.fedNo }"/>"><c:out value="${item.festivalName }"/></a></strong>
	                        <em class="tis"><c:out value="${item.fedYear }"/> 수상작</em>
	                        <ul>
	                        <c:forEach var="subItem" items="${item.awordList }">
                                <li><em><c:out value="${subItem.feaAword }"/></em> <span><c:out value="${subItem.feaMovie }"/></span></li>
	                        </c:forEach>
	                        </ul>
	                    </div>
	                </div>
	            </div>
            </c:forEach>
        </div>
    </div>
    <!-- //list -->
</div>
<!-- //영화제 -->
</c:if>

<c:if test="${not empty themeKeywordInfo }">
	<!-- 테마키워드 -->
	<div class="mMDb4">
	    <div class="db4bg">
	        <div class="mTitle6">
	            <h3>테마키워드</h3>
	            <a href="<c:url value="/db/keyword"/>" class="more">더보기</a>
	        </div>
	        <div class="con">
	            <div class="gImg1">
	                <a href="<c:url value="/db/keyword/"/><c:out value="${themeKeywordInfo.idx }"/>">
		                <div class="mImg1"><span style="background-image: url('<c:out value="${THEME_KEYWORD_IMG_PATH}${themeKeywordInfo.filenm}"/>');"></span></div>
		                <div class="txt">
		                    <strong class="ti">Keyword</strong>
		                    <span class="tx"><span>#<c:out value="${themeKeywordInfo.keywordname }"/></span></span>
		                </div>
	                </a>
	            </div>
	            <!-- list -->
	            <div class="list">
	                <div class="owl-carousel owl-theme" id="db-main-cate4">
	                    <c:forEach var="item" items="${themeKeywordInfo.movieList }">
	                        <div class="item">
	                            <a href="<c:url value="/db/kor/detail/movie/"/><c:out value="${item.movieId }"/>/<c:out value="${item.movieSeq }"/>">
	                                <span class="mImg1"><span style="background-image: url('<c:out value="${item.posterPath }"/>');"></span></span>
	                                <span class="text"><strong><c:out value="${item.title }"/></strong> <em><c:out value="${item.director }"/></em></span>
	                            </a>
	                        </div>
	                    </c:forEach>
	                </div>
	            </div>
	            <script type="text/javascript">
	            $(window).on('ready load resize', function(){
	                if ( $("#wrap").width() > 924 )
	                    $(".mMDb4 .owl-carousel").css("min-height", $(".mMDb4 .gImg1").height() );
	                else
	                    $(".mMDb4 .owl-carousel").css("min-height", "auto" );
	            });
	            </script>
	            <!-- //list -->
	        </div>
	    </div>
	</div>
	<!-- //테마키워드 -->
</c:if>

<c:if test="${not empty movieList }">
	<!-- 리스트 -->
	<div class="mMDb5">
	    <div class="mTitle6">
	        <h3>리스트</h3>
	        <a href="<c:url value="/db/list"/>" class="more">더보기</a>
	    </div>
	    <div class="mTag1 gray">
	        <c:forEach var="item" items="${movieList }">
                <a href="<c:url value="/db/list/detail/"/><c:out value="${item.movielistId }"/>/<c:out value="${item.movielistNo }"/>">#<c:out value="${item.movielistName }"/></a>
	        </c:forEach>
	    </div>
	</div>
	<!-- //리스트 -->
</c:if>

<c:if test="${not empty bannerInfo }">
	<!-- banner -->
	<div class="mMDb6">
	    <a href="<c:out value="${bannerInfo.url }"/>">
		    <!-- forMobile -->
		    <div class="mImg1 forMobile">
		        <span style="background-image: url('${MAIN_CONTENT_IMG_PATH}<c:out value="${bannerInfo.fileName }"/>');"></span>
		        <img src="/resources/images/db/k-db6.png" alt="">
		    </div>
		    <!-- forPc -->
		    <div class="mImg1 forPc">
		        <span style="background-image: url('${MAIN_CONTENT_IMG_PATH}<c:out value="${bannerInfo.fileName }"/>');"></span>
		        <img src="/resources/images/db/k-db6-pc.png" alt="">
		    </div>
		    <div class="text">
		        <h3><c:out value="${bannerInfo.title }"/></h3>
		        <p class="txt"><span class="br">한 편의 영화는 그 영화가 만들어질 때의 시간과 공간을 스크린 속에 고스란히 담고 있다.</span> 그때 그 시절의 영화가 스크린 위에 펼쳐지는 순간</p>
		    </div>
        </a>
	</div>
	<!-- //banner -->
</c:if>


<script type="text/javascript" src="/resources/js/db.js"></script> <!-- js for db page -->

<script type="text/javascript">
$(document).ready(function(){
});
</script>