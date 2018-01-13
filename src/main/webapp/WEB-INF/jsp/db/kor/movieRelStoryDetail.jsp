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
           	 <div class="result-block pt0">
				<div class="result-block-tt type2">
	               	<h4>관련글 (<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
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
				<div class="mImage1">
					<ul>
						<c:forEach var="item" items="${pageListVo.resultList }" varStatus="status">
						<li>
							<span class="mImg1"><span style="background-image: url('${MOVIE_STORY_IMG_PATH}<c:out value="${item.fileName }"/>')"></span></span>
							<span class="text">
								<a href="javascript:fcnStoryDetail('<c:out value="${item.storyDivSeq}"/>','<c:out value="${item.storySeq}"/>');" class="tit"><c:out value="${item.title}"/></a>
                                   <span class="des"><c:out value="${item.shortNonTagContentDesc }" escapeXml="false"/></span>
                                   <span class="nam"><span>by.</span>${item.writerName }</span>
                                      <fmt:parseDate value="${item.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
                                   <span class="dat"><fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/></span>
							</span>
						</li>
						</c:forEach>
					</ul>
				</div>
				<!--//list -->

				<div class="paging-area">
					<!-- pagination -->
					<div class="pagination medium">
						${paging}
					</div>
					<!-- //pagination -->
				</div>

			</div>
			<!-- //관련글 -->
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
</script>