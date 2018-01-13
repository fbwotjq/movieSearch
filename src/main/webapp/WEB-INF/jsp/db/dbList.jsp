<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/resources/js/db.js"></script>
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
				<form id="form1" name="form1" method="post">
					<sec:csrfInput/>
					<input type="hidden" id="movielistNo" name="movielistNo" value=""/>
					<section id="fieldset">

						<!-- list -->
						<div class="mList6">
							<c:forEach var="item" items="${dbList }">
								<c:if test="${item.movielistDepth eq 1 }">
									<dl>
										<dt class="row2"><div class="ls"><span><span class="brForMobile"><c:out value="${item.movielistName }"/></div></dt>
											<c:forEach var="item2" items="${dbList }">
												<c:if test="${item2.movielistDepth eq 2 and item2.gubun eq item.gubun}">
													<dd><div class="ls"><a href="javascript:fcnDetail('<c:out value="${item2.movielistId}"/>','<c:out value="${item2.movielistNo}"/>');" > <c:out value="${item2.movielistName }"/> </a></div></dd>
												</c:if>
											</c:forEach>
									</dl>
								</c:if>
							</c:forEach>
						</div>
						<!-- //list -->
						<div class="mButton1 type2">
							<span class="lt"><a href="<c:url value="/db/united/list"/>" class="mBtn1 gray"><span class="iList">통합리스트</span></a></span>
							<span class="rt"><a href="###" class="mBtn1"><span class="iFeel2">리스트 이용안내</span></a></span>
						</div>

						<!-- graph -->
						<div class="gTitle2">
							<h3>내가 섭렵한 영화통계</h3>
							<span class="gRt">
								<a href="" onclick="fncReload();" class="iReload">통계 초기화</a>
							</span>
						</div>
						<fmt:parseNumber var="var1" value="${dbListCount}" integerOnly="true" />
						<fmt:parseNumber var="var2" value="${userDbViewCount}" integerOnly="true" />
						<fmt:parseNumber var="var3" value="${var2/var1*100}" integerOnly="true"  />
						<div class="mGraph1">
							<p class="txt1"><c:out value="${dbListCount}"/>편중 <em><c:out value="${userDbViewCount}"/></em>편 관람</p>
							<div class="graph">
								<span class="cur" style="width:${var3}%;"><em></em></span>
							</div>

							<div class="percent">${var3}%</div>
						</div>
						<!-- //graph -->

						<!-- list -->
						<table border="1" class="data-table medium transform-m">
							<caption>내가 섭렵한 영화통계 테이블</caption>
							<colgroup>
								<col style="width:21%">
								<col style="*">
								<col style="width:21%">
								<col style="width:13%">
							</colgroup>
							<thead>
							<tr>
								<th scope="col" colspan="2">Total</th>
								<th scope="col">관리</th>
								<th scope="col">%</th>
							</tr>
							</thead>
							<tbody>
							<c:forEach  var="item" items="${userDbViewList }" varStatus="status">
								<c:if test="${item.movielistDepth eq 1 }">
									<c:set var="i" value="1" />
									<tr class="type2 type2tit">
										<td class="title" rowspan="<c:out value="${item.rcnt}"/>">${item.movielistName}</td>
								</c:if>
								<c:if test="${item.movielistDepth eq 2 and i eq 1}">
										<td class="align-left30">${item.movielistName}</td>
										<td>${item.totcount}편중 <em class="txtPurple">${item.mcount}</em>편 관람</td>
										<c:choose>
											<c:when test="${item.mcount ne 0}">
												<fmt:parseNumber var="var4" value="${item.mcount}" integerOnly="true" />
												<fmt:parseNumber var="var5" value="${item.totcount}" integerOnly="true" />
												<fmt:parseNumber var="var6" value="${var4/var5*100}" integerOnly="true"  />
											</c:when>
											<c:otherwise>
												<c:set var="var6" value="0" />
											</c:otherwise>
										</c:choose>
										<td class="percent">${var6}%</td>
										<c:set var="i" value="2"/>
									</tr>
								</c:if>
								<c:if test="${item.movielistDepth eq 2 and i ne 1}">
									<tr class="type2">
										<td class="align-left30">${item.movielistName}</td>
										<td>${item.totcount}편중 <em class="txtPurple">${item.mcount}</em>편 관람</td>
										<c:choose>
											<c:when test="${item.mcount ne 0}">
												<fmt:parseNumber var="var4" value="${item.mcount}" integerOnly="true" />
												<fmt:parseNumber var="var5" value="${item.totcount}" integerOnly="true" />
												<fmt:parseNumber var="var6" value="${var4/var5*100}" integerOnly="true"  />
											</c:when>
											<c:otherwise >
												<c:set var="var6" value="0" />
											</c:otherwise>
										</c:choose>
										<td class="percent"><c:out value="${var6}"/>%</td>
										<c:set var="i" value="2"/>
									</tr>
								</c:if>
							</c:forEach>
							</tbody>
						</table>
						<!-- //list -->

						</section>
					</form>
				</div>
			</div>


<script type="text/javascript">
$(document).ready(function(){

});

function fncReload(){
	window.location.reload(true);
}

function fcnDetail(idx,mNo){
	$("#movielistNo").val(mNo);
	formSubmit("form1", "<c:url value="/db/list/"/>"+ idx);
}


</script>