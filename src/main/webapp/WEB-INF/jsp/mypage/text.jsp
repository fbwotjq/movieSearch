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
		        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>

					<section id="fieldset" class="topmrg_type1">
						<legend>자료검색</legend>
						<!-- search -->
		                <div class="mSearch">
		                    <div class="dbinfo-search">
		                        <input type="text" id="searchText" name="searchText" placeholder="리스트내 검색" value="<c:out value="${paramMap.searchText }"/>">
		                        <button class="ico-search" type="button" id="searchBtn"></button>
		                    </div>
		                    <div class="dbinfo-radio selector-wrap horizontal">
		                        <div class="asset type2">
		                            <label><input type="radio" name="searchType" id="searchType" value="subject" <c:if test="${empty paramMap.searchType || paramMap.searchType eq 'subject' }">checked="checked"</c:if>> <span class="label">제목</span></label>
		                        </div>
		                        <div class="asset type2">
		                            <label><input type="radio" name="searchType" id="searchType" value="contentDesc" <c:if test="${paramMap.searchType eq 'contentDesc' }">checked="checked"</c:if>> <span class="label">내용</span></label>
		                        </div>
		                        <div class="asset type2">
		                            <label><input type="radio" name="searchType" id="searchType" value="movieTitle" <c:if test="${paramMap.searchType eq 'movieTitle' }">checked="checked"</c:if>> <span class="label">작품</span></label>
		                        </div>
		                    </div>
		                </div>
		                <!-- //search -->

						<!-- sort -->
						<div class="mSort1">
							<h4 class="noline">전체게시물 (<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
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
				                        </select>
				                    </div>
				                </div>
		                    </div>
						</div>
		              	<!-- //sort -->

						<!-- list -->
						<table border="1" class="data-table medium transform-m">
							<caption>나의영화글 게시판 테이블</caption>
							<colgroup>
								<col style="width:*">
								<col style="width:15.5%">
								<col style="width:13.5%">
								<col style="width:13.5%">
							</colgroup>
							<thead>
							<tr>
								<th scope="col">제목</th>
								<th scope="col">작품</th>
								<th scope="col">작성자</th>
								<th scope="col">작성일</th>
							</tr>
							</thead>
							<tbody>
								<c:if test="${pageListVo.totalCount <= 0 }">
				                	<tr>
				                        <td colspan="4">내역이 없습니다.</td>
				                    </tr>
								</c:if>
								<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
									<tr>
										<td class="title align-left"><a href="#none" onclick="fncDetail('<c:out value="${item.reviewSeq }"/>'); return false;"><span class="ellipsisRow1"><c:out value="${item.subject }"/></span></a></td>
										<td><span class="ellipsisRow1"><c:out value="${item.movieTitle}(${item.director},${item.prodYear})"/></span></td>
										<td><c:out value="${item.createId}"/></td>
										<td><c:out value="${item.createDate}"/></td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
							<div class="paging-area">
								<!-- pagination -->
								<div class="pagination medium">
									${paging}
								</div>
								<!-- //pagination -->
							</div>
							<!-- 리뷰글 -->
							<div class="mReview">
								<span class="ico">영화에 대한 리뷰글을 등록해 주세요.</span>
								<div class="gRt">
									<a href="/story/user/form" class="mBtn1">글쓰기</a>
								</div>
							</div>
							<!-- //리뷰글 -->
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

function fncDetail(idx){
    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>"+"/"+idx;
    frm.submit();
}
</script>