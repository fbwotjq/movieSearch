<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
				        <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>

						<section id="fieldset">

							<!-- module -->
							<div class="mImage10">
								<ul>
								<c:if test="${pageListVo.totalCount <= 0 }">
			                    <li><a href="#">등록된 데이터가 없습니다.</a></li>
							    </c:if>
								<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
								<li>
									<a href="#url" onclick="fncDetail('${item.feNo}', '${item.maxfedno}');">
										<span class="mImg1">
										<c:choose>
											<c:when test="${item.festImg != '' && item.festImg ne null}">
											<span style="background-image: url('${KF_FILM_IMAGE_PATH}/festival/${item.feNo}/${item.festImg}')"></span>
											</c:when>
											<c:when test="${item.image != '' && item.image ne null}">
											<span style="background-image: url('${KF_FILM_IMAGE_PATH}/festival/${item.image}')"></span>
											</c:when>
											<c:otherwise>
											<span style="background-image: url('/resources/images/common/noimage.gif')"></span>
											</c:otherwise>
										</c:choose>
										</span>
										<span class="text"><c:out value="${item.nameKor}"/></span>
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

function fncDetail(feNo, fedNo){
    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>"+"/"+feNo+"/"+fedNo;
    frm.submit();
}

</script>