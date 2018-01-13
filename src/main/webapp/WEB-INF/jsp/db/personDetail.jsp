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

        <c:if test="${not empty imageList}">
	        <!-- 이미지 -->
	        <div class="result-block">
	            <div class="result-block-tt type2">
	                <h4>이미지 (<span class="em weighty"><fmt:formatNumber groupingUsed="true"><c:out value="${fn:length(imageList) }"/></fmt:formatNumber></span>)</h4>
	                <a href="#none;" class="iMore1">더보기</a><%-- TODO - 소장정보 이미지로 이동 --%>
	            </div>
	            <!-- list -->
	            <div class="mList8">
	                <ul>
	                <c:forEach var="item" items="${imageList }" begin="0" end="3" varStatus="status">
	                    <c:choose>
	                        <c:when test="${status.count <= 2 }">
	                            <li>
	                        </c:when>
	                        <c:otherwise>
	                            <li class="forPc"> <!-- pc용 리스트입니다. -->
	                        </c:otherwise>
	                    </c:choose>

	                        <a href="#none;"><%-- TODO - 갤러리 이동 --%>
	                            <span class="mImg1"><span style="background-image: url('<c:out value="${item.imgPath }"/>')"></span></span>
	                            <span class="text"><%--<em class="tit">영화제</em>--%><span class="txt"><c:out value="${item.stillNm }"/></span></span>
	                        </a>
	                    </li>
	                </c:forEach>
	                </ul>
	            </div>
	            <!--//list -->
	        </div>
	        <!-- //이미지 -->
        </c:if>


        <c:if test="${not empty mulList}">
	        <!-- 동영상 -->
	        <div class="result-block mt1">
	            <div class="result-block-tt type2">
	                <h4>동영상 (<span class="em weighty"><fmt:formatNumber groupingUsed="true"><c:out value="${fn:length(mulList) }"/></fmt:formatNumber></span>)</h4>
	                <a href="###" class="iMore1">더보기</a><%-- TODO - 소장정보 동영상으로 이동 --%>
	            </div>
	            <!-- list -->
	            <div class="mImage7 type2">
	                <ul>
	                <c:forEach var="item" items="${mulList }" begin="0" end="3" varStatus="status">
	                    <li class="pt0">
							<a href="javascript:fcnMoviePlayer('${item.multorNm}');" ><%-- TODO - 동영상 플레이어 --%>
	                            <span class="timeline-box">
	                                <span class="mImg1"><span style="background-image: url('<c:out value="${item.mulImgPath }"/>')"></span></span>
	                                <span class="timeline">
	                                    <span class="timeline-musicvideo"><c:out value="${item.classname }"/></span>
	                                    <span><c:out value="${item.playTime }"/></span>
	                                </span>
	                                <span class="play"><i class="ico-play"></i></span>
	                            </span>
	                            <span class="text">
	                                <span class="title"><c:out value="${item.mulTitle }"/> : <c:out value="${item.titleEtc }"/> : <c:out value="${item.mulYear }"/></span>
	                            </span>
	                        </a>
	                    </li>
	                </c:forEach>
	                </ul>
	            </div>
	            <!--//list -->
	        </div>
	        <!-- //동영상 -->
        </c:if>

        <c:if test="${not empty filmoList}">
	        <!-- 필모그래피 -->
	        <div class="result-block mt1">
	            <div class="result-block-tt type2">
	                <h4>필모그래피 (<span class="em weighty"><fmt:formatNumber groupingUsed="true"><c:out value="${fn:length(filmoList) }"/></fmt:formatNumber></span>)</h4>
	                <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>/filmo#divFilmo" class="iMore1">더보기</a>
	            </div>
	            <!-- list -->
	            <div class="mList9">
	                <dl>
	                <c:forEach var="item" items="${filmoList }" varStatus="status">
	                    <c:if test="${status.first }">
	                        <c:set var="firstCreditNm" value="${item.creditNm }"/>

	                        <dt class="mTitle2 type2"><c:out value="${item.creditNm }"/> <span>:</span></dt>
	                        <dd>
	                    </c:if>

	                    <c:if test="${firstCreditNm ne item.creditNm}">
	                        <c:set var="endLoop" value="true"/>
	                        </dd>
	                    </c:if>

	                    <c:if test="${not endLoop}">
	                        <a href="javascript:fcnMovieDetail('<c:out value="${item.movieId }"/>', '<c:out value="${item.movieSeq }"/>');" class="txtBlue"><c:out value="${item.title }"/></a> (<c:out value="${item.director }"/>, <c:out value="${item.prodYear }"/>) <span class="name"><c:out value="${item.staff }"/></span><br>
	                    </c:if>
	                </c:forEach>
	                </dl>
	            </div>
	            <!--//list -->
	        </div>
	        <!-- //필모그래피 -->
        </c:if>

        <c:if test="${not empty festivalAwardsList}">
	        <!-- 수상정보 -->
	        <div class="result-block mt1">
	            <div class="result-block-tt type2">
	                <h4>수상정보</h4>
	                <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>/festival#divFestival" class="iMore1">더보기</a>
	            </div>
	            <!-- list -->
	            <div class="mList10">
	                <ul>
	                <c:forEach var="item" items="${festivalAwardsList }" begin="0" end="2">
	                    <li>
	                        <span class="tit"><a href="<c:url value="/db/festival/"/><c:out value="${item.feNo }"/>/<c:out value="${item.fedNo }"/>" class="txtBlue">제 <c:out value="${item.fedTime }"/>회 <c:out value="${item.nameKor }"/>(<c:out value="${item.fedYear }"/>)</a> <span>:</span></span>
	                        <span class="txt"><c:out value="${item.feaAword }"/>(<a href="javascript:fcnMovieDetail('<c:out value="${item.movieId }"/>', '<c:out value="${item.movieSeq }"/>');" class="txtBlue"><c:out value="${item.feaMovie }"/></a>)</span>
	                    </li>
	                </c:forEach>
	                </ul>
	            </div>
	            <!--//list -->
	        </div>
	        <!-- //수상정보 -->
        </c:if>

        <c:if test="${not empty personInfo.career }">
	        <!-- 주요경력 -->
	        <div class="result-block mt1">
	            <div class="result-block-tt type2">
	                <h4>주요경력</h4>
	            </div>
	            <div class="mTxt2">
	            <c:forEach var="item" items="${personInfo.careerList }" varStatus="status">
	                <c:if test="${status.count == 6 }">
	                    <c:set var="hidFlag" value="true"/>
	                    <div id="jsCareer" class="moreHidden">
	                </c:if>
                    <c:out value="${item }"/><br/>

                    <c:if test="${status.last && hidFlag}">
                        </div>
                    </c:if>
	            </c:forEach>
	            </div>
                <c:if test="${hidFlag }">
	                <div class="mButton1 mt15">
	                    <span class="gRight"><a href="#jsCareer" class="iOpen1">펼쳐보기</a></span>
	                </div>
                </c:if>
	        </div>
	        <!-- //주요경력 -->
        </c:if>

        <c:if test="${not empty personInfo.personEtcList }">
	        <!-- 기타정보 -->
	        <div class="result-block mt1">
	            <div class="result-block-tt type2">
	                <h4>기타정보</h4>
	            </div>

	            <!-- list -->
	            <c:set var="etcCnt" value="0"/>
	            <div class="mList11">
	                <dl>
	                    <c:forEach var="item" items="${personInfo.personEtcList }" begin="0" end="1">
	                        <dt><c:out value="${item.title }"/></dt>
	                        <dd>
	                        <c:forEach var="subItem" items="${item.contentList }">
	                            <c:out value="${subItem }"/><br>
	                        </c:forEach>
	                        </dd>
	                    </c:forEach>
	                </dl>
	                <div id="jsEtcInformation" class="moreHidden">
		                <dl>
		                    <c:forEach var="item" items="${personInfo.personEtcList }" begin="2">
		                        <dt><c:out value="${item.title }"/></dt>
		                        <dd>
		                        <c:forEach var="subItem" items="${item.contentList }">
		                            <c:out value="${subItem }"/><br>
		                        </c:forEach>
		                        </dd>
		                    </c:forEach>
		                </dl>
	                </div>
	            </div>
	            <!--//list -->
                <c:if test="${fn:length(personInfo.personEtcList) > 2 }">
	                <div class="mButton1 mt15">
	                    <span class="gRight"><a href="#jsEtcInformation" class="iOpen1">펼쳐보기</a></span>
	                </div>
                </c:if>

	        </div>
	        <!-- //기타정보 -->
        </c:if>

        <c:if test="${not empty pageListVo.resultList }">
	        <!-- 관련글 -->
	        <div class="result-block mt1">
	            <div class="result-block-tt type2">
	                <h4>관련글</h4>
	                <a href="<c:url value="/db/per/"/><c:out value="${personInfo.personId }"/>/story#divStory" class="iMore1">더보기</a>
	            </div>
	            <!-- list -->
	            <div class="mImage1">
	                <ul>
	                    <c:forEach var="item" items="${pageListVo.resultList  }" begin="0" end="2">
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
	        </div>
	        <!-- //관련글 -->
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