<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- ### CSS ### -->
<link rel="stylesheet" type="text/css" href="/resources/plugins/jquery.mCustomScrollbar/jquery.mCustomScrollbar.css">
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">

<!-- ### JS ### -->
<script type="text/javascript" src="/resources/js/db.js"></script>
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- ### wisenut search JavaScript ### -->
<script src="/resources/js/wisenut/search.js"></script>

<div id="contents">
    <div class="breadcrumb">
        <ul>
            <li class="ico-home"><a href="#">홈</a></li>
            <li><a href="#">DB</a></li>
            <li class="located"><a href="#">통합검색</a></li>
        </ul>
    </div>
    <div class="container">
        <div class="top-area">
            <div class="prev-page"><a href="#"><i class="ico-prev"></i><span>이전</span></a></div>
            <div class="submenu-depth3">
                <h3 class="submenu-depth3-title"><a href="#"><span>통합검색</span><i class="ico-updown ico-down"></i></a></h3>
                <div class="submenu-depth-list submenu-depth3-list">
                    <ul>
                        <li class="selected"><a href="#">한국영화걸작선</a></li>
                        <li><a href="#">독립극영화</a></li>
                        <li><a href="#">다큐멘터리</a></li>
                        <li><a href="#">애니메이션</a></li>
                        <li><a href="#">종료연재</a></li>
                        <li><a href="#">실험영화</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <section id="fieldset">
            <form id="searchForm" name="searchForm" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                query||<input type="text" id="query" name="query" value="<c:out value='${query}'/>"/>
                tabName||<input type="text" id="tabName" name="tabName" value="<c:out value='${tabName}'/>"/>
                startCount||<input type="text" id="startCount" name="startCount" value="<c:out value='${startCount}'/>"/>
                collection||<input type="text" id="collection" name="collection" value="<c:out value='${collection}'/>"/>

            </form>
            <!-- tab -->
            <div class="mTab1">
                <span id="movieTab" name="movieTab" class="ls selected"><a href="javascript:doCollectionSearch('ALL', 'movieTab');">영화정보</a></span>
                <span id="sojangTab" name="sojangTab" class="ls"><a href="javascript:doCollectionSearch('ALL', 'sojangTab');">소장정보</a></span>
            </div>

            <!-- //tab -->

            <!-- slide tab -->
            <div class="mCarousel1">
                <div class="owl-carousel owl-theme total-search-slidemenu" id="db-tab-menu1">
                    <div class="item"><a href="javascript:doCollectionSearch('ALL', 'movieTab');" class="selected">전체(${totalCount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmKORMOVIE', 'movieTab');">한국영화(${resultData.kmKORMOVIECount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmFORMOVIE', 'movieTab');">국외영화(${resultData.kmFORMOVIECount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmMOVIEIN', 'movieTab');">영화인(${resultData.kmMOVIEINCount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmMOVIE', 'movieTab');">동영상(${resultData.kmMOVIECount})</a></div>
                    <c:set var= "kmIMAGECount" value="${resultData.kmSTILLFILECount + resultData.kmPOSTERFILECount + resultData.kmSTILLPRINTCount + resultData.kmPOSTERPRINTCount}"/>
                    <div class="item"><a href="javascript:doCollectionSearch('kmIMAGE', 'movieTab');">이미지(${kmIMAGECount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmSALYO', 'movieTab');">사료관(${resultData.kmSALYOCount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmMSTORY', 'movieTab');">영화글(${resultData.kmMSTORYCount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmMOVIEJE', 'movieTab');">영화제(${resultData.kmMOVIEJECount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmPLACE', 'movieTab');">장소(${resultData.kmPLACECount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmEVENT', 'movieTab');">행사/사건(${resultData.kmEVENTCount})</a></div>
                </div>
            </div>
            <!-- //slide tab -->

            <!-- search -->
            <div class="dbinfo-search">
                <input type="text" placeholder="리스트내 검색">
                <button class="ico-search"></button>
            </div>
            <!-- //search -->
            <c:if test="${collection eq 'ALL' || collection eq 'kmKORMOVIE'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/korMovie.jsp"%>  <!-- ### 국내영화 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmFORMOVIE'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/forMovie.jsp"%>  <!-- ### 국외영화 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmMOVIEIN'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/movieIn.jsp"%>   <!-- ### 영화인 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmMOVIE'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/movie.jsp"%>     <!-- ### 동영상 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmIMAGE' || collection eq 'kmPOSTERFILE' || collection eq 'kmPOSTERPRINT'
                          || collection eq 'kmSTILLFILE' || collection eq 'kmSTILLPRINT'}">
            <div class="result-block">
                <div class="result-block-tt mb1">
                    <h4>이미지 (<span class="em weighty">${kmIMAGECount}</span>)</h4>
                </div>
            </div>
                <c:if test="${collection eq 'ALL' || collection eq 'kmPOSTERFILE'}">
                    <%@ include file="/WEB-INF/jsp/wisenut/result/posterFile.jsp"%>  <!-- ### 포스터 파일 ### -->
                </c:if>
                <c:if test="${collection eq 'ALL' || collection eq 'kmPOSTERPRINT'}">
                    <%@ include file="/WEB-INF/jsp/wisenut/result/posterPrint.jsp"%> <!--  ### 포스터 인쇄물 ### -->
                </c:if>
                <c:if test="${collection eq 'ALL' || collection eq 'kmSTILLFILE'}">
                    <%@ include file="/WEB-INF/jsp/wisenut/result/stillFile.jsp"%>   <!--  ### 스틸 파일 ### -->
                </c:if>
                <c:if test="${collection eq 'ALL' || collection eq 'kmSTILLPRINT'}">
                    <%@ include file="/WEB-INF/jsp/wisenut/result/stillPrint.jsp"%>  <!--  ### 스틸 인쇄물 ### -->
                </c:if>

            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmSALYO'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/salyo.jsp"%>     <!-- ### 사료관 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmMSTORY'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/mStory.jsp"%>    <!-- ### 영화글 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmMOVIEJE'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/movieJe.jsp"%>    <!-- ### 영화제 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmPLACE'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/place.jsp"%>    <!-- ### 장소 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmEVENT'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/event.jsp"%>    <!-- ### 행사/사건 ### -->
            </c:if>
        </section>
    </div>
</div>




<script type="text/javascript">


</script>