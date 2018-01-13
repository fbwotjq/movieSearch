<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/archives.css">

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

        <input type="hidden" id="dFileSeq" name="dFileSeq">
        <input type="hidden" id="dFileOrder" name="dFileOrder">
        <input type="hidden" id="dReturnUrl" name="dReturnUrl" value="<c:url value='${paramMap._view_path}'/>">

        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
        <input type="hidden" id="code01" name="code01" value="<c:out value="${paramMap.code01 }"/>"/>
        <input type="hidden" id="code02" name="code02" value="<c:out value="${paramMap.code02 }"/>"/>
        <input type="hidden" id="year" name="year" value="<c:out value="${paramMap.year }"/>"/>


        <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
        <section id="fieldset">

            <!-- tab -->
            <div class="mTab1">
                <c:forEach var="item" items="${code01List }">
                <c:if test="${paramMap.code01 ==  item.cCodeSubId }">
                    <c:set var="code01" value="${item.cCodeSubId }"/>
                    <c:set var="code01Name" value="${item.cCodeSubName }"/>
                </c:if>

                <span class="ls <c:if test="${paramMap.code01 ==  item.cCodeSubId }">selected</c:if>"><a href="javascript:fcnMainSearch('<c:out value="${item.cCodeSubId }"/>');"><c:out value="${item.cCodeSubName }"/></a></span>
                </c:forEach>
            </div>
            <!-- //tab -->
            <%--
            <c:set var="year" value=""/>

            <c:forEach var="item" items="${yearList }" varStatus="status">
                <c:if test="${status.first }">
                    <c:set var="year" value="${item.year }"/>
                </c:if>
            </c:forEach>
            --%>

            <!-- slide tab -->
            <div class="mMenu1 type2 nonavi">
                <!-- depth1 -->
                <div class="owl-carousel dep1 jsTab1" id="archives-tab-menu3">
                    <a href="javascript:fcnSubSearch('');" <c:if test="${empty paramMap.code02 }">class="selected"</c:if>>전체</a>
                    <c:forEach var="item" items="${code02List }">
                        <a href="javascript:fcnSubSearch('<c:out value="${item.cCodeSubId }"/>');" <c:if test="${paramMap.code02 eq item.cCodeSubId }">class="selected"</c:if>><c:out value="${item.cCodeSubName }"/></a>
                    </c:forEach>
                </div>
                <!-- //depth1 -->

                <c:if test="${fn:length(yearList) > 0 }">
	                <div class="owl-carousel dep2" id="archives-tab-menu4_2">
	                    <c:forEach var="item" items="${yearList }">
	                        <a href="javascript:fcnYearSearch('<c:out value="${item.year }"/>');" <c:if test="${paramMap.year eq item.year }">class="selected"</c:if>><c:out value="${item.year }"/></a>
	                    </c:forEach>
	                </div>
                </c:if>

            </div>
            <!-- //slide tab -->


            <!-- search -->
            <div class="mSearch">
                <div class="dbinfo-search">
                    <input type="text" id="searchText" name="searchText" placeholder="리스트내 검색" value="<c:out value="${paramMap.searchText }"/>">
                    <button class="ico-search"></button>
                </div>
                <div class="dbinfo-radio selector-wrap horizontal">
                    <div class="asset type2">
                        <label><input type="radio" name="searchType" id="searchType_SUBJECT" value="SUBJECT" <c:if test="${paramMap.searchType == 'SUBJECT' || empty paramMap.searchType }">checked="checked"</c:if>> <span class="label">제목</span></label>
                    </div>
                    <div class="asset type2">
                        <label><input type="radio" name="searchType" id="searchType_TARGET" value="TARGET" <c:if test="${paramMap.searchType == 'TARGET'}">checked="checked"</c:if>> <span class="label">저자</span></label>
                    </div>
                </div>
            </div>
            <!-- //search -->

            <!-- sort -->
            <div class="mSort1">
                <h4><c:out value="${code01Name }"/> (<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
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
            <div class="mImage10 type3">
                <ul>
                <c:forEach var="item" items="${pageListVo.resultList }" varStatus="status">
                    <c:choose>
                        <c:when test="${status.count <= 4 }">
                            <li class="pt0">
                        </c:when>
                        <c:otherwise>
                            <li>
                        </c:otherwise>
                    </c:choose>
                    <div class="cont">
                        <span class="mImg1 h2"><a href="javascript:fcnDetail('<c:out value="${item.archivesSeq }"/>');"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></a></span>
                        <span class="text">
                            <span class="nam"><a href="javascript:fcnDetail('<c:out value="${item.archivesSeq }"/>');"><c:out value="${item.subject }"/></a></span>
                            <span class="lst">
                                <span class="ls char4"><em>저자</em> <c:out value="${item.targetName }"/></span>
                                <span class="ls char4"><em>발행년도</em> <c:out value="${item.birthYear }"/>년</span>
                            </span>
                            <c:choose>
                                <c:when test="${item.freeYn eq 'N' && item.payYn eq 'N'}">
                                    <sec:authorize access="isAuthenticated()">
                                        <a href="javascript:fcnPay('<c:out value="${item.archivesSeq }"/>', '<c:out value="${item.fileSeq }" />', '<c:out value="${item.fileOrder }" />');" class="price"><span><fmt:formatNumber value="${item.amount }" groupingUsed="true"/>원</span></a>
                                    </sec:authorize>
                                    <sec:authorize access="isAnonymous()">
                                        <a href="javascript:fcnLogin('form1');" class="price"><span><fmt:formatNumber value="${item.amount }" groupingUsed="true"/>원</span></a>
                                    </sec:authorize>
                                </c:when>
                                <c:otherwise>
		                            <span class="link">
		                                <c:if test="${item.viewYn eq 'Y' }">
		                                    <a href="javascript:fcnPdfViewer('form1', '<c:out value="${item.fileSeq }" />', '<c:out value="${item.fileOrder }" />');" title="새창열림" class="iPdf2">뷰어</a>
		                                </c:if>

		                                <c:if test="${item.downYn eq 'Y' }">
		                                    <a href="javascript:fcnDownload('form1', '<c:out value="${item.fileSeq }" />', '<c:out value="${item.fileOrder }" />');" class="iDownload">다운로드</a>
		                                </c:if>
		                            </span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    </li>
                </c:forEach>
                </ul>
            </div>
            <!-- //list -->

            <div class="paging-area">
                <!-- pagination -->
                <div class="pagination medium">${paging}</div>
                <!-- //pagination -->
            </div>
        </section>
        </form>
    </div>
</div>

<script type="text/javascript" src="/resources/js/archives.js"></script> <!-- js for archives page -->
<script type="text/javascript" src="/resources/js/history/history.js"></script>

<script type="text/javascript">
$(document).ready(function(){
    $("#form1").validate({
        submitHandler: function(form) {
            $("#_page").val("1");
            formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
        }
    });

    $("#_pageSize, #searchOrderType").bind("change", function() {
    	$("#_page").val("1");
        formSubmit("form1", "/history/book");
    });
});

function fncGoPage(nPage){
    $("#_page").val(nPage);
    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
}

function initSearchValue() {
	$("#_page").val("1");
	$("#_pageSize").val("");
	$(":input[name='searchType']:checked").val("");
	$("#searchType").val("");
	$("#searchText").val("");
	$("#searchOrderType").val("");

	$("#year").val("");
}

function fcnMainSearch(pCode01) {
	initSearchValue();

    $("#code01").val(pCode01);
    $("#code02").val("");

    formSubmit("form1", "<c:url value="/history/book"/>");
}

function fcnSubSearch(pSubCode) {
    initSearchValue();

    $("#code01").val("<c:out value="${code01}"/>");
    $("#code02").val(pSubCode);

    formSubmit("form1", "<c:url value="/history/book"/>");
}

function fcnYearSearch(pYear) {
    $("#year").val(pYear);

	formSubmit("form1", "<c:url value="/history/book"/>");
}

function fcnDetail(pArchivesSeq) {
	formSubmit("form1", "<c:url value="/history/book/"/>" + pArchivesSeq);
}

function fcnPay(pArchivesSeq, seq, order){
	window.open("<c:url value='${paramMap._view_path}'/>"+"/pay/"+pArchivesSeq+"/"+seq+"/"+order, 'popPay', 'toolbar=no,location=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=520, top=30,left=100');
}

function fnRefresh(){
	formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
}
</script>