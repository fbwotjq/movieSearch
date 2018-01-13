<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/resources/js/vod.js"></script> <!-- js for vod page -->
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/vod.css">

<div id="contents" class="w100per"> <!-- 컨텐츠 중간에 백그라운드가 있을 경우  class="w100per" 추가합니다. -->
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
		        <input type="hidden" id="searchType" name="searchType" value="<c:out value='${paramMap.searchType}'/>"/>
		        <input type="hidden" id="searchText" name="searchText" value="<c:out value='${paramMap.searchText}'/>"/>

					<section id="fieldset">

						<!-- module -->
						<div class="gGrid2 mView1">
							<div class="title">
								<h2><c:out value="${detailInfo.title}"/></h2>
								<div class="sub-tt">
									<span class="dat2"><c:out value="${detailInfo.startDateFormat}"/> ~ <c:out value="${detailInfo.endDateFormat}"/></span>
								</div>
								<div class="sns">
							<a href="#none" onclick="snsCon('fb', '<c:out value="${detailInfo.title}"/>', '<c:out value="${paramMap._full_path}"/>', '<c:out value="${detailInfo.summaryDesc}"/>', '<c:out value="${VOD_PLAN_IMG_PATH}"/><c:out value="${detailInfo.fileName}"/>');" class="sns-facebook">facebook</a>
							<a href="#none" onclick="snsCon('tw', '<c:out value="${detailInfo.title}"/>#KMDb', '<c:out value="${paramMap._full_path}"/>');" class="sns-twitter">twitter</a>
						</div>
							</div>
							<div class="article">
								<div class="articleBg">
									<div class="img"><img src='<c:out value="${VOD_PLAN_IMG_PATH}"/><c:out value="${detailInfo.fileName}"/>' alt=""></div>
									<c:out value="${detailInfo.contentDesc}" escapeXml="false"/><br><br>
									<div class="tit">상영작품</div>
								</div>
								<div class="mImage6">

									<c:forEach var="item" items="${relMovieList}" varStatus="status">

	                                <c:set var="rtClass" value="" />
	                                <c:set var="listClass" value="list" />
									 <c:choose>
			                            <c:when test="${status.count%2 == 0 }">
			                                <c:set var="rtClass" value="rt" />
			                            </c:when>
			                            <c:when test="${status.count%3 == 0 }">
			                                <c:set var="listClass" value="listBg" />
			                            </c:when>
			                        </c:choose>

									<c:if test="${status.count%2 == 1 }">
			                        <div class="${listClass }">
										<ul>
			                        </c:if>

				                        	<li class="${rtClass }">
												<div class="timeline-box">
													<a href="javascript:goMovieDetail('<c:out value="${item.planSeq }"/>','<c:out value="${item.movieId }"/>','<c:out value="${item.movieSeq }"/>');">
														<div class="mImg1"><span style="background-image: url('<c:out value="${VOD_PLAN_IMG_PATH}"/><c:out value="${item.fileName}"/>')"></span></div>
														<span class="play"><i class="ico-play"></i></span>
													</a>
												</div>
												<div class="text">
													<div class="ti"><em><fmt:formatNumber value='${status.count}' pattern='00' />.</em> <span onclick="goMovieDetail('<c:out value="${item.planSeq}"/>','<c:out value="${item.movieId }"/>','<c:out value="${item.movieSeq }"/>')"><c:out value="${item.movieTitle}" /></span> <span class="ts"><c:out value="${item.director }"/>, <c:out value="${item.prodYear }"/></span></div>
													<c:out value="${item.contentDesc}" escapeXml="false"/>
												</div>
											</li>

			                        <c:if test="${status.count%2 == 0 || status.last }">
			                       		</ul>
									</div>
			                        </c:if>

									</c:forEach>

								</div>

							</div>
							<div class="btn-group large btnlist"><a class="btn large slightly" href="javascript:fncGoList();"><i class="ico-btnlist"></i><span>목록</span></a></div>

						</div>
						<!-- //module -->


					</section>
				</form>
			</div>
		</div>

<script type="text/javascript">
$(document).ready(function(){

});

function fncGoList() {
    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._list_path}'/>";
    frm.submit();
}

function goMovieDetail(pSeq, mId, mSeq){
	fcnMovieDetail(mId, mSeq);
}
</script>