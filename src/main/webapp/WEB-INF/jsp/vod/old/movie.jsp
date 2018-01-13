<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript" src="/resources/js/vod.js"></script> <!-- js for vod page -->
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/vod.css">

<div id="contents" class="video-area">
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
		        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
		        <input type="hidden" id="searchType" name="searchType" value="<c:out value='${paramMap.searchType}'/>"/>
		        <input type="hidden" id="searchText" name="searchText" value="<c:out value='${paramMap.searchText}'/>"/>
		        <input type="hidden" id="gubunType" name="gubunType" value="<c:out value='${paramMap.gubunType}'/>"/>
		        <input type="hidden" id="gubunValue" name="gubunValue" value="<c:out value='${paramMap.gubunValue}'/>"/>

				<!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
				<section id="fieldset" class="topmrg_type1">
					<legend>자료검색</legend>

					<!-- 메뉴 -->
					<div class="mMenu1">
						<!-- depth1 -->
						<div class="owl-carousel" id="vod-movie-menu1">
							<div id="gubunTypeDiv" class="item gubunTypeClass ${paramMap.gubunType eq '' || paramMap.gubunType == null ? 'selected' : ''}">
								<a href="#url" onclick="fnGubun1('');">전체</a>
							</div>
							<div id="gubunTypeDivjangre" class="item gubunTypeClass ${paramMap.gubunType eq 'GENRE' ? 'selected' : ''}">
								<a href="#url" onclick="fnGubun1('GENRE');">장르</a>
							</div>
							<div id="gubunTypeDivprodYear" class="item gubunTypeClass ${paramMap.gubunType eq 'YEAR' ? 'selected' : ''}">
								<a href="#url" onclick="fnGubun1('YEAR');">연대</a>
							</div>
							<div id="gubunTypeDivdirector" class="item gubunTypeClass ${paramMap.gubunType eq 'DIRECTOR' ? 'selected' : ''}">
								<a href="#url" onclick="fnGubun1('DIRECTOR');">주요감독</a>
							</div>
							<div id="gubunTypeDiv4" class="item gubunTypeClass ${paramMap.gubunType eq 'RESTORE' ? 'selected' : ''}">
								<a href="#url" onclick="fnGubun1('RESTORE');">복원작</a>
							</div>
						</div>
						<!-- //depth1 -->
						<!-- depth2 * 장르-->

						<c:forEach var="searchItem" items="${vodSearchTextList }" varStatus="searchStatus">
							<!-- dep2-jangre : GENRE, dep2-prodYear : YEAR, dep2-director : DIRECTOR -->
		                    <div id="dep2-${searchItem.searchTypeCd}" class="dep2" style="display: ${paramMap.gubunType eq searchItem.searchTypeCd ? '' : 'none'};">
		                    <c:forEach items="${fn:split(searchItem.searchText, ',') }" var="searchTextSplit">
							    <a href="#open" onclick="fnGubun2('${searchTextSplit}');" class="${paramMap.gubunValue eq searchTextSplit ? 'selected' : ''}" >${searchTextSplit}</a>
							</c:forEach>
		                    </div>
			            </c:forEach>


					</div>
					<!-- //메뉴 -->

					<div class="dbinfo">
						<div class="dbinfo-search">
							<input type="text" name="schtxt" id="schtxt" placeholder="리스트내 검색" value="<c:out value='${paramMap.searchText}'/>" >
							<button class="ico-search" type="button" id="searchBtn"></button>

						</div>
						<div class="dbinfo-radio selector-wrap horizontal">
							<div class="asset">
								<label><input type="radio" name="fldname" value="total" ${paramMap.searchType == "total" ? 'checked' : ''}> <span class="label">전체</span></label>
							</div>
							<div class="asset">
								<label><input type="radio" name="fldname" value="director" ${paramMap.searchType == "director" ? 'checked' : ''}> <span class="label">감독</span></label>
							</div>
							<div class="asset">
								<label><input type="radio" name="fldname" value="casts" ${paramMap.searchType == "casts" ? 'checked' : ''}> <span class="label">배우</span></label>
							</div>

						</div>

						<div class="iFeel"><a href="/care/vod/guide">VOD이용안내</a></div>

						<div class="result-block-tt">
							<h4>영화 (<span class="em weighty"><fmt:formatNumber	value="${pageListVo.totalCount }" type="number" /></span>)</h4>
							<div class="dbinfo-table-sort">
								<div class="area">
									<label for="select1" class="blind">제목순</label>
									<select name="orderKey1" id="select1" class="select-tric">
										<option value="title" ${paramMap.orderKey1 == "title" ? 'selected' : ''}>제목순</option>
										<option value="hit" ${paramMap.orderKey1 == "hit" ? 'selected' : ''}>인기순</option>
										<option value="director" ${paramMap.orderKey1 == "director" ? 'selected' : ''}>감독순</option>
										<option value="year" ${paramMap.orderKey1 == "year" ? 'selected' : ''}>제작년도</option>
									</select>
								</div>
								<div class="area">
									<label for="select2" class="blind">내림차순</label>
									<select name="orderKey2" id="select2" class="select-tric">
										<option value="desc" ${paramMap.orderKey2 == "desc" ? 'selected' : ''}>내림차순</option>
										<option value="asc" ${paramMap.orderKey2 == "asc" ? 'selected' : ''}>오름차순</option>
									</select>
								</div>
								<div class="area">
									<label for="select3" class="blind">10개 출력</label>
									<select name="_pageSize" id="select3" class="select-tric">
										<option value="10" ${paramMap._pageSize == "10" ? 'selected' : ''}>10개 출력</option>
										<option value="20" ${paramMap._pageSize == "20" ? 'selected' : ''}>20개 출력</option>
										<option value="30" ${paramMap._pageSize == "30" ? 'selected' : ''}>30개 출력</option>
									</select>
								</div>
							</div>
						</div>

					</div>

					<!-- module -->
					<div class="mImage7">
						<ul>
							<c:if test="${pageListVo.totalCount <= 0 }">
		                    <li><a href="#">등록된 데이터가 없습니다.</a></li>
						    </c:if>
							<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
							<li>
								<a href="javascript:fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>');">
									<span class="timeline-box">

										<span class="mImg1"><span style="background-image: url('/resources/vod/thumb/${item.movieId}${item.movieSeq}_w.jpg')"></span></span>
										<span class="timeline">
											<span><c:out value="${item.runtime2}"/></span>
										</span>
										<span class="play"><i class="ico-play"></i></span>
									</span>
									<span class="text">
										<span class="year"><c:out value="${item.director}"/> <span class="dots"><c:out value="${item.prodYear}"/></span></span>
										<span class="title"><c:out value="${item.mulTitle}"/></span>
										<span class="name"><c:out value="${item.castsView}"/></span>
										<span class="price"><span><fmt:formatNumber	value="${item.price }" pattern="#,###" />원</span></span>
									</span>
								</a>
							</li>
							</c:forEach>
						</ul>

						<%-- <c:if test="${paramMap._page <  pageTotal}">
						<div class="mButton2">
							<button class="btn xlarge weightiest" type="submit"><span>More</span></button>
						</div>
						</c:if> --%>

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
	$('#schtxt').keydown(function (e) {
		if(e.keyCode == 13){
			$searchBtn.trigger('click');
	    }
	});

	$searchBtn.on('click',function(e){
		e.preventDefault();
		fncSearch();
	});

	$('#select1').on('change', function() {
		fncSelectSubmit();
	});
	$('#select2').on('change', function() {
		fncSelectSubmit();
	});
	$('#select3').on('change', function() {
		fncSelectSubmit();
	});


});

function fncGoPage(nPage){
    $("#_page").val(nPage);

    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
}

function fncSelectSubmit(){
	var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
}

function fncMoreBtn(){

}

function fncSearch() {
	if($(':radio[name="fldname"]:checked').length > 0){
		$("#_page").val("1");

		$("#searchType").val($('input[name="fldname"]:checked').val());
		$("#searchText").val($("#schtxt").val());

	    var frm = document.form1;
	    frm.target = "_self";
	    frm.action = "<c:url value='${paramMap._view_path}'/>";
	    frm.submit();
	}
}

function fnGubun1(cnt){
	$("#gubunType").val(cnt);
	//$(".gubunTypeClass").removeClass('selected');
	//$("#gubunTypeDiv"+cnt).addClass('selected');
	//$(".dep2").hide();
	//$("#dep2-"+cnt).show();

	if((cnt == '' && $("#gubunValue").val() != '')){
		fnGubun2("");
	}else if(cnt == 'GENRE'){
		fnGubun2("멜로");
	}else if(cnt == 'YEAR'){
		fnGubun2("2000");
	}else if(cnt == 'DIRECTOR'){
		fnGubun2("신상옥");
	}else if(cnt == 'RESTORE'){
		fnGubun2("복원작");
	}
}

function fnGubun2(cnt){
	$("#gubunValue").val(cnt);
	$("#_page").val("1");
	$("#searchType").val("");
	$("#searchText").val("");
    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
}
</script>