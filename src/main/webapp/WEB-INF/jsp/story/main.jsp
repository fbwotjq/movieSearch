<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var = "movieTextMenuId" value="${menuList[paramMap.menuIndex].cPmenuId}"/>
<c:set var = "movieTextMenuIdCnt" value="0"/>
<c:set var = "movieTextSubMenuId" value=""/>

<script type="text/javascript" src="/resources/js/movie.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/movie.css">
<form id="form1" name="form1" method="post">

<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
<div class="gMovie1">
	<!-- tab -->
	<div class="mMTab1">
		<div class="tab1bg">
			<div class="list type2">
				<div class="lst">
					<div class="sel">
						<a href="###">
						<span id="list1_title">
							<c:forEach var="mainVar1" items="${menuList}" varStatus="mainStatus1" >
								<c:if test="${mainVar1.cParentId eq movieTextMenuId}">
									<c:if test="${movieTextMenuIdCnt eq '0'}">
										<c:out value="${mainVar1.cPmenuTitle}"/>
										<c:set var = "movieTextSubMenuId" value="${mainVar1.cPmenuId}"/>
										<c:set var = "movieTextMenuIdCnt" value="1"/>
									</c:if>
								</c:if>
							</c:forEach>
						</span>
						</a>
					</div>
					<div class="ls">
						<ul>
						<c:forEach var="mainVar2" items="${menuList}" varStatus="mainStatus2" >
							<c:if test="${mainVar2.cParentId eq movieTextMenuId}">
								<c:if test="${mainVar2.leafYn eq 'Y' }">
								<li><a href="javascript:fnSubList('<c:out value="${mainVar2.cPmenuId}"/>','${mainVar2.cPmenuTitle}')">${mainVar2.cPmenuTitle}</a></li>
								</c:if>
								<c:if test="${mainVar2.leafYn ne 'Y' }">
								<li><a href="javascript:menuMove('<c:url value="${mainVar2.cPagePath}"/>','${mainStatus2.index}');">${mainVar2.cPmenuTitle}</a></li>
								</c:if>
							</c:if>
						</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<div class="list">
				<div class="lst">
					<div class="sel">
						<a href="###">
							<span id="subSelectListTitle">
								<c:forEach var="mainSubVar1" items="${menuList}" varStatus="mainSubStatus1" >
									<c:if test="${mainSubVar1.cParentId eq movieTextSubMenuId}">
										<c:if test="${movieTextMenuIdCnt eq '0' || movieTextMenuIdCnt eq '1'}">
											<c:out value="${mainSubVar1.cPmenuTitle}"/>
											<c:set var = "movieTextMenuIdCnt" value="2"/>
										</c:if>
									</c:if>
								</c:forEach>
							</span>
						</a>
					</div>
					<div class="ls">
						<ul id="subSelectList">
						<c:forEach var="mainSubVar2" items="${menuList}" varStatus="mainSubStatus2" >
							<li class="subSelectList_${mainSubVar2.cParentId}" <c:if test="${mainSubVar2.cParentId ne movieTextSubMenuId}">style="display:none"</c:if>>
							<a href="javascript:menuMove('<c:url value="${mainSubVar2.cPagePath}"/>','${mainSubStatus2.index}');">${mainSubVar2.cPmenuTitle}</a>
							</li>
						</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- //tab -->

	<!-- movie-visual -->
	<div class="mMovieVisual">
		<a href="javascript:location.href='/story/<c:out value="${movieStroyHeadInfo.storyDivSeq}"/>/<c:out value="${movieStroyHeadInfo.storySeq}"/>'">
			<span class="img" style="background-image: url(<c:out value="${MAIN_CONTENT_IMG_PATH}"/><c:out value="${movieStroyHeadInfo.fileName}"/>);">
				<img src="/resources/images/movie/img_movie_frame2.png" alt="">
			</span>
			<span class="text">
				<em class="tis">${movieStroyHeadInfo.storyDivTitle}</em>
				<strong class="tit"><span>${movieStroyHeadInfo.title}</span></strong>
				<span class="nam"><span>by.</span>${movieStroyHeadInfo.writerName}</span>
				<span class="txt">
					<c:out value="${movieStroyHeadInfo.contentDesc }" escapeXml="false"/>
				</span>
				<fmt:parseDate value="${movieStroyHeadInfo.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
				<span class="dat"><fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/></span>
			</span>
		</a>
	</div>
	<!-- movie-visual -->

	<!-- 영화글 -->
	<div class="mImage4">
		<h4>영화글</h4>
		<!-- forPc -->
		<div class="forPc">
					<ul>

					<c:forEach var="item" items="${movieStoryList}"  varStatus="status">
						<c:if test="${status.index < 8}">
						<li>
							<div class="item">
								<a href='/story/<c:out value="${item.storyDivSeq}"/>/<c:out value="${item.storySeq}"/>'>
									<span class="text">
										<c:if test="${item.regGap le 2}">
											<em class="iNew">새글</em>
										</c:if>
										<span class="tis">${item.storyDivTitle}</span>
										<strong class="tit">${item.title}</strong>
										<fmt:parseDate value="${item.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
										<span class="dat"><fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/></span>
									</span>
									<span class="mImg1"><span style="background-image: url('${MOVIE_STORY_IMG_PATH}<c:out value="${item.fileName }"/>')"></span></span>
									<span class="line"></span>
								</a>
								<span class="nam"><span>by.</span>${item.writerName}</span>
							</div>
						</li>
						</c:if>
					</c:forEach>

					</ul>
				</div>
		<!-- //forPc -->

		<!-- forMobile -->
		<div class="forMobile">
			<div class="owl-carousel owl-theme" id="movie-image4-carousel">
			<c:forEach var="item" items="${movieStoryList}" varStatus="status" >
				<c:if test="${status.index < 8}">
				<div class="item" >
					<a href="javascript:location.href='/story/<c:out value="${item.storyDivSeq}"/>/<c:out value="${item.storySeq}"/>'">
						<span class="text">
							<c:if test="${item.regGap le 2}">
								<em class="iNew">새글</em>
							</c:if>
							<span class="tis">${item.storyDivTitle}</span>
							<strong class="tit">${item.title}</strong>
							<fmt:parseDate value="${item.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
							<span class="dat"><fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/></span>
						</span>
						<span class="img" style="background-image: url('${MOVIE_STORY_IMG_PATH}<c:out value="${item.fileName }"/>')"></span>
						<span class="line"></span>
					</a>
					<span class="nam"><span>by.</span>${item.writerName}</span>
				</div>
				</c:if>
			</c:forEach>
			</div>
		</div>
		<!-- //forMobile -->
	</div>
	<!-- //영화글 -->
</div>
<div id="contents">
	<!-- list -->
	<div class="mList4">
		<div class="cont">
			<ul>

			<c:forEach var="item" items="${movieStoryList}" varStatus="status" >
			<c:if test="${status.index > 7 and status.index < 15}">
			<li <c:if test="${status.index == 8}"> class="type2" </c:if> >
				<a href="javascript:location.href='/story/<c:out value="${item.storyDivSeq}"/>/<c:out value="${item.storySeq}"/>'">
					<em class="tis">${item.storyDivTitle}</em>
					<span class="tit">${item.title}<c:if test="${item.regGap le 2}"><em class="iNew">새글</em></c:if></span>
					<span class="nam"><span>by.</span>${item.writerName}${item.newDate}</span>
					<fmt:parseDate value="${item.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
					<span class="dat"><fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/></span>
				</a>
			</li>
			</c:if>
			</c:forEach>
			</ul>
		</div>
	</div>
	<!-- //list -->

</div>
</form>

<script type="text/javascript">
$(document).ready(function() {
	//design
	$("#body").addClass("login");
});

function fcnDetail(divSeq,pStorySeq) {
	formSubmit("form1", "<c:url value="/story/"/>" + pStoryDivSeq + "/" + pStorySeq);
}

function fnSubList(cPmenuId, title){

	$("#list1_title").text(title);
	$("#subSelectList").children("li").hide();
	$(".subSelectList_"+cPmenuId).show();
	$("#subSelectListTitle").text($(".subSelectList_"+cPmenuId).first().find("a").text());

	$('#subSelectListTitle').trigger('click');
}
</script>

