<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>


        <input type="hidden" id="code01" name="code01" value="<c:out value="${paramMap.code01 }"/>"/>
        <input type="hidden" id="code02" name="code02" value="<c:out value="${paramMap.code02 }"/>"/>


        <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
        <section id="fieldset">

            <c:if test="${not empty headInfo }">
	            <!-- image11 -->
	            <div class="mImage11">
	                <a href="javascript:fcnDetail('<c:out value="${headInfo.archivesSeq }"/>');">
	                    <span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${headInfo.fileName }"/>')"></span></span>
	                    <span class="text">
	                        <span class="tit">CONTENTS Pick</span>
	                        <span class="tit2"><span><c:out value="${headInfo.subject }"/></span></span>
	                        <span class="nam"><span>by. </span><span><c:out value="${headInfo.targetName }"/> <em class="dt"><fmt:formatDate value="${headInfo.createDate}" pattern="yyyy-MM-dd"/></em></span>
	                        <span class="des"><c:out value="${headInfo.nonTagContents }" escapeXml="false"/></span>
	                    </span>
	                </a>
	            </div>
	            <!-- //image11 -->
            </c:if>

            <!-- tab -->
            <div class="mTab1 mb1">
                <c:forEach var="item" items="${code01List }">
                    <span class="ls <c:if test="${paramMap.code01 eq item.cCodeSubId }">selected</c:if>"><a href="javascript:fcnSubSearch('<c:out value="${item.cCodeSubId }"/>');"><span class="brForMobile"><c:out value="${item.cCodeSubName }"/></span></a></span>
                </c:forEach>
            </div>
            <!-- //tab -->

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
                        <label><input type="radio" name="searchType" id="searchType_TARGET" value="TARGET" <c:if test="${paramMap.searchType == 'TARGET'}">checked="checked"</c:if>> <span class="label">필자</span></label>
                    </div>
                    <div class="asset type2">
                        <label><input type="radio" name="searchType" id="searchType_CONTENTS" value="CONTENTS" <c:if test="${paramMap.searchType == 'CONTENTS'}">checked="checked"</c:if>> <span class="label">내용</span></label>
                    </div>
                </div>
            </div>
            <!-- //search -->


            <!-- sort -->
            <div class="mSort1">
                <h4>사료콘텐츠 (<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
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
            <div class="mImage1 type3">
                <ul>
                 <c:forEach var="item" items="${pageListVo.resultList }" varStatus="status">
                    <li>
                        <div class="cont">
                            <span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></span>
                            <div class="text">
                                <span class="tit"><a href="javascript:fcnDetail('<c:out value="${item.archivesSeq }"/>');"><c:out value="${item.subject }"/></a></span>
                                <span class="des"><c:out value="${item.nonTagContents }" escapeXml="false"/></span>
                                <span class="nam"><span>by.</span><c:out value="${item.targetName }"/></span>
                                <span class="dat"><fmt:formatDate value="${item.createDate}" pattern="yyyy-MM-dd"/></span>
                            </div>
                        </div>
                    </li>
                </c:forEach>
                </ul>
	            <div class="paging-area">
	                <!-- pagination -->
	                <div class="pagination medium">${paging}</div>
	                <!-- //pagination -->
	            </div>
            </div>
            <!-- //list -->

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
        formSubmit("form1", "/history/contents");
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
}

function fcnSubSearch(pSubCode) {
	initSearchValue();

    $("#code01").val(pSubCode);

    formSubmit("form1", "<c:url value="/history/contents"/>");
}


function fcnDetail(pArchivesSeq) {
	formSubmit("form1", "<c:url value="/history/contents/"/>" + pArchivesSeq);
}

</script>