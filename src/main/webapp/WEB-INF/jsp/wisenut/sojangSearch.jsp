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
                <span id="movieTab" name="movieTab" class="ls"><a href="javascript:fnClickTab('movieTab');">영화정보</a></span>
                <span id="sojangTab" name="sojangTab" class="ls selected"><a href="javascript:fnClickTab('sojangTab');">소장정보</a></span>
            </div>

            <!-- //tab -->
            <!-- slide tab -->
            <div class="mCarousel1">
                <div class="owl-carousel owl-theme total-search-slidemenu" id="db-tab-menu1">
                    <div class="item"><a href="javascript:doCollectionSearch('ALL', 'sojangTab');" class="selected">전체(${totalCount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmDCFILM', 'sojangTab');">필름/D시네마(${resultData.kmDCFILMCount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmVIDEO', 'sojangTab');">비디오(${resultData.kmVIDEOCount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmSCENARIO', 'sojangTab');">시나리오(${resultData.kmSCENARIOCount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmBOOK', 'sojangTab');">도서/논문(${resultData.kmBOOKCount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmOST', 'sojangTab');">음반(${resultData.kmOSTCount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmCENSOR', 'sojangTab');">심의서류(${resultData.kmCENSORCount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmOST', 'sojangTab');">박물류(${resultData.kmEQUIPMENTCount})</a></div>
                    <div class="item"><a href="javascript:doCollectionSearch('kmFLYER', 'sojangTab');">전단/보도자료/기타자료(${resultData.kmFLYERCount})</a></div>
                </div>
            </div>
            <!-- //slide tab -->

            <!-- search -->
            <div class="dbinfo-search">
                <input type="text" placeholder="리스트내 검색">
                <button class="ico-search"></button>
            </div>
            <!-- //search -->

            <c:if test="${collection eq 'ALL' || collection eq 'kmDCFILM'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/DCFilm.jsp"%> <!--  ### 필름/D시네마 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmVIDEO'}">
            <%@ include file="/WEB-INF/jsp/wisenut/result/video.jsp"%> <!--  ### 비디오 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmSCENARIO'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/scenario.jsp"%> <!--  ### 시나리오/콘티 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmBOOK'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/book.jsp"%> <!--  ### 도서/논문 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmOST'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/ost.jsp"%> <!--  ### OST ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmCENSOR'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/censor.jsp"%> <!--  ### 심의서류 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmEQUIPMENT'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/equipment.jsp"%> <!--  ### 박물류 ### -->
            </c:if>
            <c:if test="${collection eq 'ALL' || collection eq 'kmFLYER'}">
                <%@ include file="/WEB-INF/jsp/wisenut/result/flyer.jsp"%> <!--  ### 전단/보도자료/기타자료 ### -->
            </c:if>
        </section>
    </div>
</div>




<script type="text/javascript">


</script>