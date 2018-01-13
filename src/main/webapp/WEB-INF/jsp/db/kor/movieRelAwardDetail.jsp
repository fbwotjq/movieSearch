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

		<!-- 수상정보 -->
		<div class="result-block pt0">
			<div class="result-block-tt type2">
				<h4>수상정보</h4>
			</div>
			<!-- list -->
			<div class="mList10">
				<ul>
				<c:forEach var="item" items="${awardList}">
				<li>
					<span class="tit"><a href="#"  onclick="goFestivalDetail(${item.feNo},${item.fedNo});" class="txtBlue">제 <c:out value="${item.cnt }"/>회 <c:out value="${item.maintitle }"/>(<c:out value="${item.fedYear }"/>)</a> <span>:</span></span>
					<span class="txt">
						<c:forEach var="item2" items="${item.subList}" >
							<c:out value="${item2.feaAword }"/>(<a href="#" onclick="fcnPersonDetail('<c:out value="${item2.fPersId}"/>');" class="txtBlue"><c:out value="${item2.fPersName }"/></a>)<br>
						</c:forEach>
					</span>
				</li>
				</c:forEach>
			</div>
			<!--//list -->
		</div>
		<!-- //수상정보 -->
		<c:if test="${not empty awardEtcList}">
		<!-- 기타 수상정보 -->
		<div class="result-block mt1">
			<div class="result-block-tt type2">
				<h4>기타 수상정보</h4>
			</div>
			<!-- list -->
			<div class="mList14 type2">
				<ul>
				<c:forEach var="item" items="${awardEtcList}">
					<li><c:out value="${item.award }"/></li>
				</c:forEach>
				</ul>
			</div>
			<!--//list -->
		</div>
		<!-- //기타 수상정보 -->
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