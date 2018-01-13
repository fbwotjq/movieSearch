<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/resources/js/db.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">


<div id="contents">
    <div class="breadcrumb">
        <%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
    </div>
    <div class="container">
        <div class="top-area pb1">
            <%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
        </div>

        <form id="form1" name="form1" method="post">
        <sec:csrfInput/>
        <input type="hidden" id="tabIndex" name="tabIndex" value="<c:out value="${paramMap.tabIndex }"/>">
        <input type="hidden" id="movielistNo" name="movielistNo" value=""/>
        <input type="hidden" id="ownCategory" name="ownCategory" value="<c:url value='${paramMap.ownCategory}'/>"/>
        <input type="hidden" id="dReturnUrl" name="dReturnUrl" value="<c:url value='${paramMap._view_path}'/>">
        <section id="fieldset">

        <%@ include file="/WEB-INF/jsp/db/kor/movieProfile.jsp"%>

        <!-- 크레디크 -->
		<div class="result-block pt0"> <!-- -->
			<div class="result-block-tt type2">
				<h4>크레디크 (<span class="em weighty">${fn:length(directorList) + fn:length(actorList) + fn:length(staffList) }</span>)</h4>
			</div>
			<!-- list -->
			<div class="mList9 type2">
				<dl>
				<c:if test="${not empty directorList}">
					<dt class="mTitle2">감독 <span>:</span></dt>
					<c:forEach var="item" items="${directorList}" >
						<dd><a href="#"  onclick="fcnPersonDetail('<c:out value="${item.personId}"/>');" class="txtBlue"><c:out value="${item.personNm }"/></a></dd>
					</c:forEach>
				</c:if>
				<c:if test="${not empty actorList}">
					<dt class="mTitle2">출연 <span>:</span></dt>
					<dd>
						<c:forEach var="item" items="${actorList}" >
							<a href="#"  onclick="fcnPersonDetail('<c:out value="${item.personId}"/>');" class="txtBlue"><c:out value="${item.personNm }"/></a>
							<span class="name"><c:out value="${item.staff }"/> 역</span><br>
						</c:forEach>
					</dd>
					</dl>
				</c:if>
				<c:if test="${not empty staffList}">
					<span class="ti">스태프</span>
					<dl class="type2">
						<c:forEach var="item" items="${staffDivList}" >
							<dt class="mTitle2 <c:if test="${(fn:length(item.staff) + fn:length(item.creditNm)) > 10}">type2</c:if>"><c:out value="${item.creditNm }"/><c:if test="${not empty item.staff}">-<c:out value="${item.staff }"/></c:if><span>:</span></dt>
								<dd class="<c:if test="${(fn:length(item.staff) + fn:length(item.creditNm)) > 10}">type2</c:if>" >
									<c:forEach var="item2" items="${staffList}" varStatus="status" >
										<c:if test="${item.creditId eq item2.creditId and item.staff eq item2.staff }">
											<a href="#"  onclick="fcnPersonDetail('<c:out value="${item2.personId}"/>');" class="txtBlue"><c:out value="${item2.personNm }"/></a>
											&nbsp;
										</c:if>
									</c:forEach>
								</dd>
						</c:forEach>
					</dl>
				</c:if>
        </section>
        </form>
    </div>
</div>


<script type="text/javascript" src="/resources/js/db.js"></script>

<script type="text/javascript">

	$(document).ready(function() {

	});


	function fcnKeyword(pKeyword) {
	    pKeyword = encodeURIComponent( encodeURIComponent( pKeyword ) );

		formSubmit("form1", "<c:url value="/history/talk/keyword/list"/>?keyword=" + pKeyword);
	}

	function goFestivalDetail(feNo, fedNo){
		 var frm = document.form1;
		    frm.target = "_self";
		    frm.action = "/db/festival/"+feNo+"/"+fedNo+"/award";
		    frm.submit();
	}

	function fcnListDetail(idx,mNo){
		$("#movielistNo").val(mNo);
		var frm = document.form1;
		    frm.target = "_self";
		    frm.action = "/db/list/"+idx;
		    frm.submit();
	}

	function fcnStoryDetail(pStoryDivSeq,pStorySeq) {
		var frm = document.form1;
		    frm.target = "_self";
		    frm.action = "/story/"+ pStoryDivSeq +"/" + pStorySeq;
		    frm.submit();
	}

	function fcnReviewDetail(idx){
		 var frm = document.form1;
		    frm.target = "_self";
		    frm.action = "/story/user/"+idx;
		    frm.submit();
	}
</script>