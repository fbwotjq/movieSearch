<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">

<div id="contents">
			<div class="breadcrumb">
				<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
			</div>
			<div class="container">
				<div class="top-area">
					<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
				</div>
				<div class="dbinfo">
					<form id="form1" name="form1" method="post">
					<sec:csrfInput/>
			        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
			        <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>
						<section id="fieldset">

							<!-- prev/next -->
							<div class="mPNext">
								<c:if test="${preNextMap.prevIdx != -1}">
								<a href="<c:url value='${paramMap._list_path}'/>/<c:url value='${preNextMap.prevIdx}'/>" class="prev">Prev</a>
								</c:if>
								<span class="year"><em class="ellipsis">#<c:url value='${preNextMap.keywordname}'/></em><span class="cnt">(<c:url value='${preNextMap.moviecnt}'/>)</span></span>
								<c:if test="${preNextMap.nextIdx != -1}">
								<a href="<c:url value='${paramMap._list_path}'/>/<c:url value='${preNextMap.nextIdx}'/>" class="next">Next</a>
								</c:if>

							</div>
							<!-- //prev/next -->

							<!-- module -->
							<div class="total-search-cont">
								<div class="mSort2">
									<span class="gRight">
										<a href="<c:url value='${paramMap._list_path}'/>/<c:url value='${preNextMap.idx}'/>/form" class="iCheck">키워드에 대한 영화등록</a>
									</span>
								</div>
								<!-- list -->
								<div class="result-block-detail">
									<ul>
										<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
										<li class="detail-box">
											<div class="details">
												<div class="movie-tt">
													<a href="javascript:fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>');" class="ftc-blue">
														<c:choose>
														 	<c:when test ="${item.levelClss == 'E' }">
														  	<i class="agelimit age19">제</i>
														 	</c:when>
														 	<c:when test ="${item.levelClss == 'B' || item.levelClss == '3' || item.levelClss == '6'}">
														  	<i class="agelimit age12">12</i>
														 	</c:when>
														 	<c:when test ="${item.levelClss == 'C' || item.levelClss == '2' || item.levelClss == '7'}">
														  	<i class="agelimit age15">15</i>
														 	</c:when>
														 	<c:when test ="${item.levelClss == 'D' || item.levelClss == '1' || item.levelClss == '8'}">
														  	<i class="agelimit age19">19</i>
														 	</c:when>
														 	<c:when test ="${item.levelClss == 'A' || item.levelClss == '4' || item.levelClss == '5'}">
														  	<i class="agelimit ageall">전</i>
														 	</c:when>
															<c:otherwise>
														  	<i class="agelimit ageall">전</i>
															</c:otherwise>
														</c:choose>
														<div class="searching-word"></div><c:out value='${item.title}'/>
														<c:if test="${item.cnt > 0}">
														<div class="vod forPc"><span onclick="javascript:fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>')">VOD</span></div> <!-- forPc -->
														</c:if>
													</a>
												</div>
												<div class="movie-tt-eng"><c:out value='${item.titleEng}'/></div>
												<div class="national">
													<a href="#" class="ftc-blue"><span><c:out value='${item.typeClss}'/></span></a>,  <a href="#2" class="ftc-blue"><span><c:out value='${item.nationClss}'/></span></a>,
												</div>
												<div class="year">
													<span><c:out value='${item.prodYear}'/></span><span class="comma">,</span><span class="dots"><c:out value='${item.runtime}'/>분</span>
												</div>
												<div class="director">
													<span>감독</span>
													<div>
													<c:forEach var="item2" items="${item.directorList}" varStatus="status2">
													<a href="javascript:fncPersonDetailGo('<c:out value="${item2.personId}"/>');" class="ftc-blue"><c:out value='${item2.personNm}'/></a><c:if test="${!status2.last}">,</c:if>
													</c:forEach>
													</div>
												</div>
												<div class="actor">
													<span>출연</span>
													<div>
													<c:forEach var="item3" items="${item.actorList}" varStatus="status3">
													<a href="javascript:fncPersonDetailGo('<c:out value="${item3.personId}"/>');" class="ftc-blue"><c:out value='${item3.personNm}'/></a><c:if test="${!status3.last}">,</c:if>
													</c:forEach>
													</div>
												</div>
												<div class="iRe"><c:out value='${item.memo}'/></div>
												<c:if test="${item.cnt > 0}">
												<div class="vod forMobile"><span onclick="javascript:fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>')">VOD</span></div> <!-- forMobile -->
												</c:if>
											</div>
											<div class="poster"><a href="javascript:fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>');" class="ftc-blue">
											<c:choose>
											 	<c:when test ="${item.imageInfo != null }">
											  	<img src="<c:out value='${KF_FILM_IMAGE_PATH}'/>/thm/02/<c:out value='${item.imageInfo.imgPath}'/>/tn_<c:out value='${item.imageInfo.filename}'/>" alt="영화 포스터">
											 	</c:when>
												<c:otherwise>
											  	<img src="/resources/images/common/noimage.gif" alt="영화 포스터">
												</c:otherwise>
											</c:choose>
											</a></div>
										</li>
										</c:forEach>
									</ul>
								</div>
								<!--//list -->
								<div class="paging-area">
									<!-- pagination -->
									<div class="pagination medium">
										${paging}
									</div>
									<!-- //pagination -->
								</div>
							</div>
							<!-- //module -->
						</section>
					</form>
				</div>
			</div>
		</div>


<script type="text/javascript">
$(document).ready(function(){

});

function fncGoPage(nPage){
    $("#_page").val(nPage);

    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
}

function fncPersonDetailGo(personId){
	if(personId == "") return false;

	fcnPersonDetail(personId);
}


</script>