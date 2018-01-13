<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="/resources/js/db.js"></script> <!-- js for db page -->
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
			        <input type="hidden" id="dReturnUrl" name="dReturnUrl" value="<c:url value='${paramMap._view_path}'/>">
						<section id="fieldset">

							<!-- prev/next -->
							<div class="mPNext">
								<c:if test="${preNextMap.prevIdx != -1}">
									<a href="<c:url value='/db/list/detail/'/><c:url value='${preNextMap.prevIdx}'/>/<c:url value='${preNextMap.prevNo}'/>" class="prev">Prev</a>
								</c:if>
								<span class="name">
									<strong class="ti"><c:url value='${detailInfo.viewInfo.div1MovielistName}'/></strong>
									<span class="na"><span>${detailInfo.viewInfo.movielistName}</span></span>
								</span>
								<c:if test="${preNextMap.nextIdx != -1}">
									<a href="<c:url value='/db/list/detail/'/><c:url value='${preNextMap.nextIdx}'/>/<c:url value='${preNextMap.nextNo}'/>" class="next">Next</a>
								</c:if>

							</div>
							<!-- //prev/next -->

							<!-- module -->
							<div class="mView1 type2">
								<div class="mButton1 type2">
									<span class="lt"><a href="<c:url value="/db/united/list"/>" class="mBtn1 gray"><span class="iList">통합리스트</span></a></span>
									<span class="rt"><a href="###" class="mBtn1"><span class="iFeel2">리스트 이용안내</span></a></span>
								</div>
								<div class="article">
									${detailInfo.viewInfo.explainContent}
									<c:if test="${fn:length(detailInfo.divList) > 0}">
									* 모든 선정위원의 리스트는 무순 혹은 가나다순입니다.<br><br>
									<div class="reviewer">
										<c:forEach var="item" items="${detailInfo.divList}" >
											${item.movielistName} ,
										</c:forEach>
									</div>
									</c:if>
								</div>
								<c:if test="${fn:length(detailInfo.divList) > 0}">
									<c:forEach var="item" items="${detailInfo.divList}" >
										<div class="mReviewer">
											<h3>${item.movielistName}</h3>
											<div class="mGraph1">
											<p class="txt1">${item.totcnt}편중  <em>${item.vcnt}</em>편 관람</p>
											<c:choose>
												<c:when test="${item.totcnt ne 0}">
													<fmt:parseNumber var="var4" value="${item.vcnt/item.totcnt}" pattern=".00" />
												</c:when>
												<c:otherwise >
													<c:set var="var4" value="0" />
												</c:otherwise>
											</c:choose>
											<div class="graph">
												<span class="cur" style="width:${var4}%;"><em></em></span>
											</div>
											<div class="percent">${var4}%</div>
										</div>
										<!-- //graph -->
										<!-- list -->
										<p class="mInfo1">* 위 목록에는 한국영화를 포함하지 않습니다.</p>
										<table border="1" class="data-table medium transform-m">
											<caption>통합리스트 테이블</caption>
											<colgroup>
												<col style="width:8.5%">
												<col style="*">
												<col style="width:20%">
												<col style="width:8.5%">
												<col style="width:13%">
												<col style="width:8.5%">
											</colgroup>
											<thead>
											<tr>
												<th scope="col">순위</th>
												<th scope="col">제목</th>
												<th scope="col">감독</th>
												<th scope="col">제작년도</th>
												<th scope="col">영상도서관<br> 열람자료</th>
												<th scope="col">내가 본<br> 영화</th>
											</tr>
											</thead>
											<tbody>
											<c:forEach var="item2" items="${detailInfo.movieList}"  varStatus="status">
												<c:if test="${item2.movielistId eq item.movielistId }">
												<tr>
													<td class="num">${item2.index}</td>
													<td class="title align-left30"><a href="javascript:void(0);">${item2.title} </a></td>
													<td>${item2.director}</td>
													<td>${item2.prodYear}</td>
													<td>
														<c:if test="${item2.rcount gt 0}">
															<span class="iB">B</span>
														</c:if>
														<c:if test="${item2.dcount gt 0}">
															<span class="iD">D</span>
														</c:if>
														<c:if test="${item2.vcount gt 0}">
															<span class="iV">V</span>
														</c:if>
													</td>
													<td class="check">
													  <sec:authorize access="isAuthenticated()">
									                       <label><input type="checkbox" name="checkbox1" id="checkbox1" onclick="fncRegDel('${item2.movielistId}','${item2.movieId}','${item2.movieSeq}','${item2.userview}');" <c:if test="${item2.userview eq 'Y'}">checked="checked"</c:if> /></label>
									                   </sec:authorize>
									                   <sec:authorize access="isAnonymous()">
									                       <label><input type="checkbox" onclick="javascript:fcnLogin('form1');" ></label>
									                   </sec:authorize>
									                  <!--  <label><a href="javascript:fcnLogin('form1');" class="mBtn1 purple inline"><span class="iScrap">스크랩하기</span></label> -->
													</td>
												</tr>
												</c:if>
											</c:forEach>
											</tbody>
										</table>
									</c:forEach>

									</div>
								</c:if>

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


//내가 본 영화
function fncRegDel(movielistId,movieId,movieSeq,userview) {
	var frm = document.form1;

	var response = $.fnAjax({
		params:{movielistId: movielistId,
				movieId: movieId,
				movieSeq: movieSeq,
				userview: userview
				}
		, url:"<c:url value='${paramMap._list_path}'/>/proc"
		, async:false
		, showMessage:false});
	    if (response.result == "true") {
	    	if(response.resultCnt == 1){
	    		alert("내가 본 영화에 등록되었습니다.");
	    	}else{
	    		alert("내가 본 영화에서 삭제되었습니다.");
	    	}
			return;
	    }else {
	    	alert("영화 등록중 에러가 발생하였습니다. 로그인 상태를 확인해주세요");
	    	return;
	    }
	    return false;
}


</script>