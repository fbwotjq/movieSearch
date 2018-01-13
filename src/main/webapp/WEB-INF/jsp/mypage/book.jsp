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
									<label><input type="radio" name="searchType" id="searchType" checked="checked" value="subject" <c:if test="${empty paramMap.searchType || paramMap.searchType eq 'subject' }">checked="checked"</c:if>> <span class="label">제목</span></label>
								</div>
								<div class="asset type2">
									<label><input type="radio" name="searchType" id="searchType" value="targetName" <c:if test="${paramMap.searchType eq 'targetName' }">checked="checked"</c:if>> <span class="label">저자</span></label>
								</div>
							</div>
						</div>
						<!-- //search -->

						<!-- sort -->
						<div class="mSort1">
							<h4>도서 (<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
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

						<!-- list -->
						<div class="mImage10 type3">
							<ul>
								<c:if test="${pageListVo.totalCount <= 0 }">
			                   		<li><a href="#">구매 내역이 없습니다.</a></li>
							   	</c:if>
								<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
									<li class="pt0">
										<div class="cont">
											<span class="mImg1 h2"><a href="javascript:fncDetail('<c:out value="${item.archivesTypeCd}"/>','<c:out value="${item.archivesSeq}"/>');"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></a></span>
											<span class="text">
												<c:if test="${item.code01 == 10 }">
													<span class="nam"><a href="javascript:fncDetail('<c:out value="${item.archivesTypeCd}"/>','<c:out value="${item.archivesSeq}"/>');">[국문] <c:out value="${item.subject}"/></a></span>
												</c:if>
												<c:if test="${item.code01 == 20 }">
													<span class="nam">[영문] <c:out value="${item.subject}"/></span>
												</c:if>
												<span class="lst">
													<span class="ls char4"><em>저자</em> <c:out value="${item.targetName}"/></span>
													<span class="ls char4"><em>발행년도</em> <c:out value="${item.birthYear}"/>년</span>
													<span class="ls char4"><em>결제금액</em> <strong class="txtPurple"><c:out value="${item.resultprice }"/>원</strong></span>
												</span>
												<span class="price noicon"><span>구매일 : <c:out value="${item.createDate}"/></span></span>
											</span>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
						<!-- //list -->
						<div class="paging-area">
							<!-- pagination -->
							<div class="pagination medium">
								${paging}
							</div>
							<!-- //pagination -->
						</div>
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

function fncDetail(archivesTypeCd, archivesSeq){

	var urlText = "";
	if(archivesTypeCd == "10"){ //구술채록문
		urlText = "/history/talk/";
	}else if(archivesTypeCd == "20"){ //발간도서
		urlText = "/history/book/";
	}else if(archivesTypeCd == "30"){ //영화잡지
		urlText = "/history/magazine/";
	}else if(archivesTypeCd == "40"){ //연감/총서
		urlText = "/history/yearbook/";
	}else if(archivesTypeCd == "50"){ //공문서
		urlText = "/history/document/";
	}else if(archivesTypeCd == "60"){ //사료콘텐츠
		urlText = "/history/contents/";
	}
	location.href = urlText+archivesSeq;
}


</script>