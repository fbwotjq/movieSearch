<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/main.css">

<div class="main-primary">
	<div class="main-top-screen owl-carousel owl-theme">

		<c:forEach var="mainListVar1" items="${mainList}" >
		<div class="item item-<c:out value="${mainListVar1.orderSeq}"/>">
			<div class="box">
				<span class="control">
					<strong class="title">
					<c:if test="${mainListVar1.title eq 'VOD'}"><b><c:out value='${mainListVar1.title}'/></b></c:if>
					<c:if test="${mainListVar1.title ne 'VOD'}"><c:out value='${mainListVar1.title}'/></c:if>
					</strong>
					<span class="text"><c:out value='${mainListVar1.subTitle}'/></span>
				</span>
				<div class="link-wrap">
					<!-- <a href="javascript:location.href='/vod/pop/player?nation=K&p_dataid=01647';" class="btn">이동</a> -->
					<a href="javascript:location.href='<c:out value="${mainListVar1.url}"/>';" class="btn">이동</a>
				</div>
			</div>
		</div>
		</c:forEach>

	</div>

	<div class="main-top-cover">
		<c:forEach var="mainListVar2" items="${mainList}" >
		<div class="cover" style="background-image:url('<c:out value="${MAIN_CONTENT_IMG_PATH}"/><c:out value="${mainListVar2.fileName}"/>')"></div>
		</c:forEach>
	</div>
	<div class="main-center-search">
		<form>
		<div class="search-area">
			<select name="" id="s1" title="검색옵션" class="select-tric search-range-select">
				<option value="">통합</option>
				<option value="">영화</option>
				<option value="">인물</option>
			</select>
			<label for="s2" class="blind">검색어</label>
			<input type="search" name="" id="s2" class="search-keyword" value="">
			<button type="submit" class="btn search-btn">검색</button>
		</div>

		</form>
		<div class="btn-group large">
			<a href="/db/main" class="btn dblink-btn">DB바로가기 &gt;</a>
			<a href="javascript:void(0);" class="btn dblink-btn">상세검색 &gt;</a>
		</div>
	</div>
	<div class="down-wheel">
		<span class="icon"></span>
	</div>
</div>
<div class="main-secondary">
	<div class="movies-contents-scroll-wrap">
		<div class="movies-contents-scroll-header">
			<h2><b><c:out value="${detailInfo.title}"/></b></h2>
			<span><c:out value="${detailInfo.subTitle}"/></span>
		</div>
		<div class="movies-contents-scroll-body">
			<div class="movies-contents-scroll-carousel owl-carousel">

				<c:forEach var="mainListVar3" items="${contentList}" >
				<div class="item">
					<div class="wrapper">
						<div class="data">
							<strong class="title"><c:out value="${mainListVar3.title}"/></strong>
							<span class="str"><c:out value="${mainListVar3.movieDirector}"/></span>
						</div>
						<c:choose>
							 <c:when test ="${mainListVar3.contentTypeCd eq 'MOVIE'}">
								<div class="thumb">
									<a href="javascript:fcnMovieDetail('<c:out value="${mainListVar3.key1}"/>','<c:out value="${mainListVar3.key2}"/>');">
									<span class="pic" style="background-image: url('<c:out value="${MAIN_CONTENT_IMG_PATH}"/><c:out value="${mainListVar3.fileName}"/>')"></span>
									<i class="ico vod">vod</i>
									</a>
								</div>
							 </c:when>
							 <c:when test ="${mainListVar3.contentTypeCd eq 'STORY'}">
							  	<div class="thumb">
									<a href="<c:out value="${mainListVar3.url}"/>">
									<span class="pic" style="background-image: url('<c:out value="${MAIN_CONTENT_IMG_PATH}"/><c:out value="${mainListVar3.fileName}"/>')"></span>
									<i class="ico write">write</i>
									</a>
								</div>
							 </c:when>
							 <c:otherwise>
							 </c:otherwise>
						</c:choose>

						<p class="text">
							<c:out value="${mainListVar3.contentDesc }" escapeXml="false"/>
						</p>
					</div>
					<span class="cover"></span>
				</div>
				</c:forEach>

				<!-- 더미데이터 -->
				<div class="item dummy-wrap">
					<div class="dummy" style="background-image: url('/resources/images/icon/ico-left-arrow1.png'); background-size: auto; background-position: 20px 65%; background-repeat: no-repeat;"></div>
				</div>
				<div class="item dummy-wrap">
					<div class="dummy" style="background-color: #fff"></div>
				</div>
				<div class="item dummy-wrap">
					<div class="dummy" style="background-color: #fff"></div>
				</div>
				<!-- // 더미데이터 -->

			</div>
		</div>
	</div>
</div>
