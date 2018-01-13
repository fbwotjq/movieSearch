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

						<!-- sort -->
						<div class="mSort1">
							<h4>이용권 (<span class="em weighty"><fmt:formatNumber	value="${pageListVo.totalCount }" type="number" /></span>)</h4>
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
									<a href="#">
										<span class="coupon">
											<span class="ico"><img src="/resources/images/icon/ico-film1.png" alt=""></span>
											<span class="tx1">
											<c:choose>
												<c:when test="${item.couponGubun eq '1' }"><span class="on-play type-2">관람기관 <em>14일권</em></span></c:when>
												<c:when test="${item.couponGubun eq '2' }"><span class="on-play type-2">관람기관 <em>30일권</em></span></c:when>
												<c:when test="${item.couponGubun eq '3' }"><span class="on-play type-2">5,000원 <em>정액권</em></span></c:when>
												<c:when test="${item.couponGubun eq '4' }"><span class="on-play type-2">10,000원 <em>정액권</em></span></c:when>
											</c:choose>
											</span>
											<span class="tx2"><strong><fmt:formatNumber	value="${item.resultprice }" pattern="#,###" /></strong>원</span>
										</span>
										<span class="text">
											<span class="price noicon"><span>구매일 :  <c:out value="${item.createdon }"/></span></span>
											<span class="lst">

												<c:choose>
													<c:when test="${item.couponGubun eq '1'  || item.couponGubun eq '2' }">
													<span class="ls"><em>관람기간</em>
													<c:choose>
														<c:when test="${item.balanceyn eq 'Y' }">
														<c:out value="${item.balancedate }"/>일
														</c:when>
														<c:otherwise>
														없음
														</c:otherwise>
													</c:choose>
													</span>
													</c:when>
													<c:when test="${item.couponGubun eq '3'  || item.couponGubun eq '4' }">
													<span class="ls"><em>잔여내역</em>
													<c:choose>
														<c:when test="${item.balanceyn eq 'Y' }">
														<c:out value="${item.balancecnt }"/>편
														</c:when>
														<c:otherwise>
														없음
														</c:otherwise>
													</c:choose>
													</span>
													</c:when>
												</c:choose>
												<span class="ls"><em>구매방법</em>
												<c:choose>
													<c:when test="${item.paymethod eq 'CARD_M' || item.paymethod eq 'Card'|| item.paymethod eq 'VCard' }">
													카드
													</c:when>
													<c:when test="${item.paymethod eq 'KAKAOPAY' || item.paymethod eq 'KAKAOPAY_M' }">
													카카오페이
													</c:when>
													<c:when test="${item.paymethod eq 'MOBILE_M' || item.paymethod eq 'HPP' }">
													핸드폰
													</c:when>
													<c:when test="${item.paymethod eq 'VBank' || item.paymethod eq 'DirectBank' }">
													계좌이체
													</c:when>
													<c:otherwise>
													기타
													</c:otherwise>
												</c:choose>
												</span>
											</span>
										</span>
									</a>
								</li>
								</c:forEach>
							</ul>

							<div class="paging-area line">
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
    $("#_pageSize").bind("change", function() {
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

    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
}

function fncDetail(idx){
    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>"+"/"+idx;
    frm.submit();
}
</script>