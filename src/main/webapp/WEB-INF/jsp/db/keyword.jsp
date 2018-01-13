<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="<c:url value='/resources/js/db.js'/>"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">

<div id="contents">
			<div class="breadcrumb">
				<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
			</div>
			<div class="container">
				<div class="top-area">
					<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
					<%@ include file="/WEB-INF/jsp/common/include/common/common02.jsp"%>
				</div>
				<div class="dbinfo">
					<form id="form1" name="form1" method="post">
						<sec:csrfInput/>
				        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
						<section id="fieldset">

							<!-- keyword -->
							<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
							<c:if test="${status.first}">

							<div class="mImage8">
								<div class="gImg1">
									<div class="mImg1"><span style="background-image: url('<c:out value="${THEME_KEYWORD_IMG_PATH}${item.filenm}"/>')"></span></div>
									<div class="txt">
										<strong class="ti">Keyword</strong>
										<span class="mTxt1">
											<em class="ellipsis" onclick="fncDetail('${item.mainIdx}');">#<c:out value="${item.keywordname}"/></em>
											<span class="cnt">(<c:out value="${item.moviecnt}"/>)</span>
											<c:if test="${item.newYn eq 'Y'}">
											<span class="iNew2">새글</span>
											</c:if>
										</span>
									</div>
								</div>
								<div class="text">
									<ul>
									<c:forEach var="item_sub" items="${item.keyWordSubList}">
									<li><a href="javascript:fcnMovieDetail('<c:out value="${item_sub.movieId}"/>','<c:out value="${item_sub.movieSeq}"/>');"><c:out value="${item_sub.title2}"/></a></li>
									</c:forEach>
									</ul>
									<a href="###" onclick="fncDetail('${item.mainIdx}');" class="more">더보기</a>
								</div>
							</div>

							</c:if>
							</c:forEach>
							<!-- //keyword -->

							<!-- module -->
							<div class="mImage9">
								<ul>
								<c:forEach var="item2" items="${pageListVo.resultList}" varStatus="status2">
								<c:if test="${!status2.first}">
								<li>
									<a href="###">
										<span class="img">
											<span class="mImg1"><span style="background-image: url('<c:out value="${THEME_KEYWORD_IMG_PATH}${item2.filenm}"/>')"></span></span>
											<span class="hover">
												<span class="hoverBg">
													<span class="hoverTxt">
													<c:forEach var="item2_sub" items="${item2.keyWordSubList}" varStatus="status2sub">
													<c:if test="${status2sub.index<6}">
													<span onclick="javascript:fcnMovieDetail('<c:out value="${item2_sub.movieId}"/>','<c:out value="${item2_sub.movieSeq}"/>');"><c:out value="${item2_sub.title2}"/></span>
								          			<c:if test="${!status2sub.last and status2sub.index < 5}"><br></c:if>
								          			</c:if>
													</c:forEach>
													</span>
													<span class="more" onclick="fncDetail('${item2.mainIdx}');">더보기</span>
												</span>
											</span>
										</span>
										<span class="text" onclick="fncDetail('${item2.mainIdx}');"><c:out value="${item2.keywordname}"/> <em>(<c:out value="${item2.moviecnt}"/>)</em></span>
									</a>
								</li>
								</c:if>
								</c:forEach>
								</ul>
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

function fncDetail(idx){
    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>"+"/"+idx;
    frm.submit();
}

</script>