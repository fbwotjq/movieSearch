<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
			<form id="form1" name="form1" method="post">
				<sec:csrfInput/>
		        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
			<div class="service-cont faq">
				<ul class="line-fold-list">
					<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
					<li class='accordion-wrap <c:if test="${status.first}">on</c:if>'>
						<div class="accordion-header"><a href="javascript:void(0);" class="accordion-title collapse-handle"><span class="faq-q"><c:out value="${item.title}"/></span> <i class="ico-handle"></i></a></div>
						<div class="accordion-content">
						<div class="faq-answer"><c:out value="${item.contents}" escapeXml="false"/></div>
						</div>
					</li>
					</c:forEach>
				</ul>
			</div>
			<div class="paging-area">
				<!-- pagination -->
				<div class="pagination medium">
					${paging}
				</div>
				<!-- //pagination -->
			</div>
			</form>
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

</script>