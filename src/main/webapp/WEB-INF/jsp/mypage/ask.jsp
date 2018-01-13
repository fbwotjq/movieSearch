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

					<!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
					<section id="fieldset">
						<legend>자료검색</legend>

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
							<caption>1:1문의내역 게시판 테이블</caption>
							<colgroup>
								<col style="width:*">
								<col style="width:15%">
								<col style="width:15%">
							</colgroup>
							<thead>
							<tr>
								<th scope="col">제목</th>
								<th scope="col">작성일</th>
								<th scope="col">상태</th>
							</tr>
							</thead>
							<tbody>
								<c:if test="${pageListVo.totalCount <= 0 }">
				           			<!--검색 결과 없을 경우-->
									<div class="noresult">
										<p>내역이 없습니다.<br> 문의사항이 있으시면 언제든 글을 남겨주세요.</p>
									</div>
									<!--//검색 결과 없을 경우-->
								</c:if>
								<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
									<tr>
										<td class="title2 align-left"><a href="#none" onclick="fncDetail('<c:out value="${item.privateSeq }"/>'); return false;">
											<c:if test="${item.privateTypeCd == 01 }">
												<span class="ellipsisRow1"><span class="item">VOD 이용문의</span>
												<c:out value="${item.title }"/></span>
											</c:if>
											<c:if test="${item.privateTypeCd == 02 }">
												<span class="ellipsisRow1"><span class="item">홈페이지 이용문의</span>
												<c:out value="${item.title }"/></span>
											</c:if>
											<c:if test="${item.privateTypeCd == 03 }">
												<span class="ellipsisRow1"><span class="item">DB 오류신고</span>
												<c:out value="${item.title }"/></span>
											</c:if>
											<c:if test="${item.privateTypeCd == 04 }">
												<span class="ellipsisRow1"><span class="item">기타 문의</span>
												<c:out value="${item.title }"/></span>
											</c:if>
										</a></td>
										<td class="nobar"><c:out value="${item.createDate}"/></td>
										<td class="status">
											<c:if test="${item.replyNm == '처리중' }">
												<span class="iStatus"><c:out value="${item.replyNm }"/></span>
											</c:if>
											<c:if test="${item.replyNm == '답변완료' }">
												<span class="iStatus end"><c:out value="${item.replyNm }"/></span>
											</c:if>
										</td>
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
							<span class="ico type2">다른문의 사항이 있으신가요?</span>
							<div class="gRt">
								<a href="/care/online/ask" class="mBtn1">1:1 문의하기</a>
							</div>
						</div>
						<!-- //리뷰글 -->
					</section>
				</form>
			</div>
		</div>

<script type="text/javascript">
$(document).ready(function(){
	$("#form1").validate({
        submitHandler: function(form) {
        	$("#_page").val("1");
            formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
        }
    });

    $("#_pageSize, #searchOrderType").bind("change", function() {
        fncSearch();
    });
});

function fncSearch() {
	$("#_page").val("1");
    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
}

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