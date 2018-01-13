<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/service.css">

<div id="contents">
			<div class="breadcrumb">
				<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
			</div>
			<div class="container">
				<div class="top-area">
					<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
					<%@ include file="/WEB-INF/jsp/common/include/common/common02.jsp"%>
				</div>
			<div class="service-cont type3">
				<form id="form1" name="form1" method="post">
				<sec:csrfInput/>
		        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
		        <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>
		        <input type="hidden" id="searchType" name="searchType" value="<c:out value='${paramMap.searchType}'/>"/>
		        <input type="hidden" id="searchText" name="searchText" value="<c:out value='${paramMap.searchText}'/>"/>

					<section id="fieldset">
						<legend>자료검색</legend>
						<div class="notice">
							<div class="notice-select">
								<label for="select1" class="blind">검색 항목 선택</label>
								<select name="fldname" id="fldname" class="select-tric">
									<option value="">제목+내용</option>
									<option value="title" ${paramMap.searchType == "title" ? 'selected' : ''}>제목</option>
									<option value="contentDesc" ${paramMap.searchType == "contentDesc" ? 'selected' : ''}>내용</option>
								</select>
							</div>
							<div class="notice-search">
								<input type="text" name="schtxt" id="schtxt" placeholder="검색" value="<c:out value='${paramMap.searchText}'/>" >
								<button class="ico-search" type="button" id="searchBtn"></button>
							</div>
							<div class="notice-table">
								<div class="notice-count">총 <span class="em weighty"><fmt:formatNumber	value="${pageListVo.totalCount }" type="number" /></span>건</div>
								<table border="1" class="data-table medium transform-m">
									<caption>공지사항 테이블</caption>
									<colgroup>
										<col style="width:8.3%">
										<col style="">
										<col style="width:19.5%">
										<col style="width:8.3%">
									</colgroup>
									<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">등록일</th>
										<th scope="col">조회수</th>
									</tr>
									</thead>
									<tbody>
									<c:if test="${pageListVo.totalCount <= 0 }">
				                        <tr>
				                            <td colspan="4">등록된 데이터가 없습니다.</td>
				                        </tr>
								    </c:if>
									<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
									<tr>
										<td><c:out value="${(pageListVo.totalCount - ((paramMap._page -1)  * paramMap._pageSize)) - status.index}"/></td>
										<td class="title align-left"><a href="#none" onclick="fncDetail('<c:out value="${item.boardSeq }"/>'); return false;"><c:out value="${item.title }"/></a></td>
										<td><c:out value="${item.createDate}"/></td>
										<td><c:out value="${item.readCount}"/></td>
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
							</div>
						</div>
					</section>
				</form>
			</div>
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
	$("#searchType").val($("#fldname").val());
	$("#searchText").val($("#schtxt").val());

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