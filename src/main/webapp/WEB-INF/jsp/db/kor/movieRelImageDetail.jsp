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


		<section id="fieldset">
        <%@ include file="/WEB-INF/jsp/db/kor/movieProfile.jsp"%>

		<c:if test="${not empty pageListVo.resultList }">
			<form id="form1" name="form1" method="post">
			<sec:csrfInput/>
	        <input type="hidden" id="tabIndex" name="tabIndex" value="<c:out value="${paramMap.tabIndex }"/>">
			<input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
			<input type="hidden" id="ownCategory" name="ownCategory" value="<c:url value='${paramMap.ownCategory}'/>"/>
      		<input type="hidden" id="dReturnUrl" name="dReturnUrl" value="<c:url value='${paramMap._view_path}'/>">
			 <!-- sort -->
           	 <div class="result-block ">
				<div class="result-block-tt type2 noline">
	               	<h4>사용자 리뷰 (<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
	                <div class="rt">
	                    <div class="dbinfo-table-sort">
	                        <div class="area">
	                            <label for="select1" class="blind">내림차순</label>
	                            <select name="searchOrderType" id="searchOrderType" class="select-tric">
	                                <option value="DESC" <c:if test="${paramMap.searchOrderType == 'DESC' || empty paramMap.searchOrderType }">selected="selected"</c:if>>내림차순</option>
	                                <option value="ASC" <c:if test="${paramMap.searchOrderType == 'ASC'}">selected="selected"</c:if>>오름차순</option>
	                            </select>
	                        </div>
	                        <div class="area">
	                            <label for="select2" class="blind">10개 출력</label>
	                            <select name="_pageSize" id="_pageSize" class="select-tric">
	                                <option value="10" <c:if test="${paramMap._pageSize == '10' || empty paramMap.searchType }">selected="selected"</c:if>>10개 출력</option>
	                                <option value="20" <c:if test="${paramMap._pageSize == '20'}">selected="selected"</c:if>>20개 출력</option>
	                            </select>
	                        </div>
	                    </div>
	                </div>
	            </div>
           		<!-- //sort -->

				<!-- list -->
				<table border="1" class="data-table medium transform-m">
					<caption>소장자료 테이블</caption>
					<colgroup>
						<col style="width:*">
						<col style="width:17%">
						<col style="width:17%">
						<col style="width:17%">
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
				<c:forEach var="item" items="${pageListVo.resultList }" varStatus="status">
					<tr>
						<td class="title align-left"><a href="#" onclick="fcnReviewDetail('<c:out value="${item.reviewSeq }"/>');"> <c:out value="${item.subject }"/></a></td>
						<td><c:out value="${item.movieTitle }"/>(<c:out value="${item.director }"/>,<c:out value="${item.prodYear }"/>)</td>
						<td><c:out value="${item.createName }"/></td>
						<td><c:out value="${item.createDate }"/></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<!--//list -->
			<div class="paging-area">
				<!-- pagination -->
				<div class="pagination medium">
					${paging}
				</div>
				<!-- //pagination -->
			</div>

			</div>
			<div class="mButton1 posRt">
				<button class="btn xlarge weighty" type="button" onclick="fcnReg();">>등록하기</button>
			</div>
		</c:if>

        </section>
        </form>
    </div>
</div>


<script type="text/javascript" src="/resources/js/db.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
	    $("#form1").validate({
	        submitHandler: function(form) {
	            $("#_page").val("1");
	            formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
	        }
	    });

	    $("#_pageSize, #searchOrderType").bind("change", function() {
	    	$("#_page").val("1");
	        formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
	    });
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

	function fncGoPage(nPage){
	    $("#_page").val(nPage);

	    var frm = document.form1;
	    frm.target = "_self";
	    frm.action = "<c:url value='${paramMap._view_path}'/>";
	    frm.submit();
	}

	function fcnReg() {
		var frm = document.form1;
	    frm.target = "_self";
	    frm.action = "/story/user/form";
	    frm.submit();
	}
</script>