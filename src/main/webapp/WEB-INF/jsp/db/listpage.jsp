<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="result-block-tt"><h4>
<c:choose>
 	<c:when test ="${paramMap.searchType == 'K' }">
  	한국영화
 	</c:when>
	<c:otherwise>
  	국외영화
	</c:otherwise>
</c:choose> (<span class="em weighty">${pageListVo.totalCount }</span>)</h4>
</div>
<c:if test="${pageListVo.totalCount == 0}">
<div class="no-data-area">
	<div class="ico-nodata"></div>
	<p>정보가 없습니다.</p>
</div>
</c:if>
<!-- list -->

<c:if test="${pageListVo.totalCount > 0}">
<div class="result-block-detail">
	<ul>
		<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
		<li class="detail-box">
			<div class="details">
				<div class="movie-tt">
					<a href="javascript:fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>');" class="ftc-blue">
						<i class="agelimit ageall">
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
						</i>
						<c:out value='${item.title}'/>
						<c:if test="${item.cnt > 0}">
						<div class="vod forPc"><span onclick="fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>');">VOD</span></div> <!-- forPc -->
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
					<a href="#url" onclick="javascript:fncPersonDetailGo('${item2.personId}');" class="ftc-blue"><c:out value='${item2.personNm}'/></a><c:if test="${!status2.last}">,</c:if>
					</c:forEach>
					</div>
				</div>
				<div class="actor">
					<span>출연</span>
					<div>
					<c:forEach var="item3" items="${item.actorList}" varStatus="status3">
					<a href="javascript:fncPersonDetailGo('${item3.personId}')" class="ftc-blue"><c:out value='${item3.personNm}'/></a><c:if test="${!status3.last}">,</c:if>
					</c:forEach>
					</div>
				</div>
				<c:if test="${item.cnt > 0}">
				<div class="vod forMobile"><span onclick="fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>');">VOD</span></div> <!-- forMobile -->
				</c:if>
			</div>
			<div class="poster">
				<a href="javascript:fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>');"  class="ftc-blue">
				<c:choose>
				 	<c:when test ="${item.imageInfo != null }">
				  	<img src="<c:out value='${KF_FILM_IMAGE_PATH}'/>/thm/02/<c:out value='${item.imageInfo.imgPath}'/>/tn_<c:out value='${item.imageInfo.filename}'/>" alt="영화 포스터">
				 	</c:when>
					<c:otherwise>
				  	<img src="/resources/images/common/noimage.gif" alt="영화 포스터">
					</c:otherwise>
				</c:choose>
				</a>
			</div>
			<div class="mKeyword2">
				<span class="txt"><input type="text" id="${paramMap.searchType}_${status.index}" placeholder="키워드에 등록되는 이유를 적어주세요." value=""></span>
				<a href="#reg" onclick="fncProc('${paramMap.searchType}_${status.index}','${item.movieId}', '${item.movieSeq}', '${item.nationalClss}');" class="btn">등록</a>
			</div>
		</li>
		</c:forEach>
	</ul>
</div>
<div class="paging-area">
	<!-- pagination -->
	<div class="pagination medium">
		${paging}
	</div>
	<!-- //pagination -->
</div>
</c:if>