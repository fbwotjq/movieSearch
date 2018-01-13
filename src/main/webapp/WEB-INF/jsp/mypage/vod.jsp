<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/resources/js/mypage.js"></script> <!-- js for mypage page -->
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/mypage.css">

<div id="contents">
			<div class="breadcrumb">
				<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
			</div>
			<div class="container">
				<div class="top-area">
					<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
					<%@ include file="/WEB-INF/jsp/common/include/common/common02.jsp"%>
				</div>
				<form id="form1" name="form1" method="post">
				<sec:csrfInput/>
		        <input type="hidden" id="gubun" name="gubun" value="<c:out value='${gubun}'/>"/>
		        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
					<!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
					<section id="fieldset">

						<!-- tab -->
						<div class="mTab1 col3 mb1">
							<span class='ls <c:if test="${gubun eq 'v'}">selected</c:if>'><a href="/mypage/vod?gubun=v">VOD</a></span>
							<span class="ls <c:if test="${gubun eq 'b'}">selected</c:if>"><a href="/mypage/vod?gubun=b">도서</a></span>
							<span class="ls <c:if test="${gubun eq 'c'}">selected</c:if>"><a href="/mypage/vod?gubun=c">이용권</a></span>
						</div>
						<!-- //tab -->

						<!-- search -->
						<div class="mSearch">
							<div class="dbinfo-search">
								<input type="text" id="searchText" name="searchText" placeholder="리스트내 검색" value="<c:out value="${paramMap.searchText }"/>">
								<button class="ico-search" type="button" id="searchBtn"></button>
							</div>
							<div class="dbinfo-radio selector-wrap horizontal">
								<div class="asset type2">
									<label><input type="radio" name="searchType" id="searchType" checked="checked" value="movieTitle" <c:if test="${empty paramMap.searchType || paramMap.searchType eq 'movieTitle' }">checked="checked"</c:if>> <span class="label">제목</span></label>
								</div>
								<div class="asset type2">
									<label><input type="radio" name="searchType" id="searchType" value="director" <c:if test="${paramMap.searchType eq 'director' }">checked="checked"</c:if>> <span class="label">감독</span></label>
								</div>
								<div class="asset type2">
									<label><input type="radio" name="searchType" id="searchType" value="casts" <c:if test="${paramMap.searchType eq 'casts' }">checked="checked"</c:if>> <span class="label">배우</span></label>
								</div>
							</div>
						</div>
						<!-- //search -->

						<!-- sort -->
						<div class="mSort1">
							<h4>VOD (<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
							<div class="rt">
								<div class="dbinfo-table-sort">
									<div class="area">
										<label for="searchOrderType" class="blind">내림차순</label>
										<select name="searchOrderType" id="searchOrderType" class="select-tric">
											<option value="DESC" <c:if test="${empty paramMap.searchOrderType || paramMap.searchOrderType == 'DESC' }">selected="selected"</c:if>>내림차순</option>
                                    		<option value="ASC"  <c:if test="${paramMap.searchOrderType == 'ASC' }">selected="selected"</c:if>>오름차순</option>
										</select>
									</div>
				                    <div class="area">
				                       	<label for="_pageSize" class="blind">10개 출력</label>
				                        <select name="_pageSize" id="_pageSize" class="select-tric">
											<option value="10" <c:if test="${empty paramMap._pageSize || paramMap._pageSize == '10' }">selected="selected"</c:if>>10개 출력</option>
                                   			<option value="20" <c:if test="${paramMap._pageSize == '20' }">selected="selected"</c:if>>20개 출력</option>
											<option value="30" <c:if test="${paramMap._pageSize == '30' }">selected="selected"</c:if>>30개 출력</option>
				                            <option value="50" <c:if test="${paramMap._pageSize == '50' }">selected="selected"</c:if>>50개 출력</option>
				                        </select>
				                    </div>
								</div>
							</div>
						</div>
						<!-- //sort -->

						<!-- module -->
						<div class="mImage7">
							<ul>
								<c:if test="${pageListVo.totalCount <= 0 }">
		                   			<li><a href="#">구매 내역이 없습니다.</a></li>
						    	</c:if>
								<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
									<li>
										<a href="javascript:fncDetail('<c:out value="${item.movieId }"/>','<c:out value="${item.movieSeq }"/>');">
											<span class="timeline-box">
												<span class="mImg1"><span style="background-image: url('/resources/vod/thumb/${item.movieId}${item.movieSeq}_w.jpg')"></span></span>
												<span class="timeline">
													<span><c:out value="${item.runtime2 }"/></span>
												</span>
												<span class="play"><i class="ico-play"></i></span>
											</span>
											<span class="text">
												<span class="year"><c:out value="${item.director }"/> <span class="dots"><c:out value="${item.prodYear }"/></span></span>
												<span class="title"><c:out value="${item.movieTitle }"/></span>
												<span class="name"><c:out value="${item.castsView }"/></span>
												<span class="lst pt1">
													<span class="ls"><em>결제금액</em> <strong class="txtPurple"><c:out value="${item.resultprice }"/>원</strong></span>
												</span>
												<span class="price noicon"><span>구매일 : <c:out value="${item.createdon }"/></span></span>
											</span>
										</a>
									</li>
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
						<!-- module -->
					</section>
				</form>
			</div>
		</div>
<script type="text/javascript">
$(document).ready(function(){
	$searchBtn = $('#searchBtn');
	$('#searchText').keydown(function (e) {
		if(e.keyCode == 13){
			$searchBtn.trigger('click');
	    }
	});

	$searchBtn.on('click',function(e){
		e.preventDefault();
		fncSearch();
	});

    $("#_pageSize, #searchOrderType").bind("change", function() {
        fncSearch();
    });
});

function fncGoPage(nPage){
    $("#_page").val(nPage);

    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
}

function fncSearch() {
	$("#_page").val("1");
	$("#searchType").val($("#searchType").val());
	$("#searchText").val($("#searchText").val());

    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
}

function fncDetail(movieId, movieSeq){
	fcnMovieDetail(movieId, movieSeq);
}
</script>