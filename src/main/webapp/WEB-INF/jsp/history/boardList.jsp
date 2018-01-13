<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="mine" uri="cipherThings" %>
<%@ taglib prefix="mined" uri="downloadTokenThings" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/archives.css">

<script type="text/javascript" src="/resources/js/archives.js"></script> <!-- js for archives page -->

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

        <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
        <section id="fieldset" class="topmrg_type1">

            <!-- search -->
            <div class="mSearch">
                <div class="dbinfo-search">
                    <input type="text" id="searchText" name="searchText" placeholder="리스트내 검색" value="<c:out value="${paramMap.searchText }"/>">
                    <button class="ico-search"></button>
                </div>
                <div class="dbinfo-radio selector-wrap horizontal">
                    <div class="asset type2">
                        <label><input type="radio" name="searchType" id="searchType_TITLE" value="TITLE" <c:if test="${paramMap.searchType == 'TITLE' || empty paramMap.searchType }">checked="checked"</c:if>> <span class="label">제목</span></label>
                    </div>
                    <div class="asset type2">
                        <label><input type="radio" name="searchType" id="searchType_CONTENT_DESC" value="CONTENT_DESC" <c:if test="${paramMap.searchType == 'CONTENT_DESC'}">checked="checked"</c:if>> <span class="label">내용</span></label>
                    </div>
                </div>
            </div>
            <!-- //search -->


            <!-- sort -->
            <div class="mSort1">
                <h4 class="noline">사료관게시판(<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
                <div class="rt">
                    <div class="dbinfo-table-sort">
                        <div class="area">
                            <label for="searchOrderType" class="blind">내림차순</label>
                            <select name="searchOrderType" id="searchOrderType" class="select-tric">
                                <option value="DESC" <c:if test="${paramMap.searchOrderType == 'DESC' || empty paramMap.searchOrderType }">selected="selected"</c:if>>내림차순</option>
                                <option value="ASC" <c:if test="${paramMap.searchOrderType == 'ASC'}">selected="selected"</c:if>>오름차순</option>
                            </select>
                        </div>
                        <div class="area">
                            <label for="_pageSize" class="blind">10개 출력</label>
                            <select name="_pageSize" id="_pageSize" class="select-tric">
                                 <option value="10" <c:if test="${paramMap._pageSize == '10' || empty paramMap.searchType }">selected="selected"</c:if>>10개 출력</option>
                                 <option value="20" <c:if test="${paramMap._pageSize == '20'}">selected="selected"</c:if>>20개 출력</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //sort -->

            <c:if test="${empty pageListVo.resultList }">
	            <div class="noresult">
	                <p>검색 내용이 없습니다.</p>
	            </div>
            </c:if>


            <c:if test="${not empty pageListVo.resultList }">
	            <!-- list -->
	            <table border="1" class="data-table medium transform-m">
	                <caption>사료관 게시판 테이블</caption>
	                <colgroup>
	                    <col style="width:8.5%">
	                    <col style="width:*">
	                    <col style="width:12.5%">
	                    <col style="width:12.5%">
	                    <col style="width:8.5%">
	                </colgroup>
	                <thead>
	                <tr>
	                    <th scope="col">No.</th>
	                    <th scope="col">제목</th>
	                    <th scope="col">작성자</th>
	                    <th scope="col">등록일</th>
	                    <th scope="col">조회수</th>
	                </tr>
	                </thead>
	                <tbody>
	                <c:forEach var="item" items="${pageListVo.resultList }" varStatus="status">
	                    <tr>
	                        <td class="num"><c:out value="${(pageListVo.totalCount - ((paramMap._page -1)  * paramMap._pageSize)) - status.index}"/></td>
	                        <td class="title align-left30"><a href="javascript:fcnDetail('<c:out value="${item.boardSeq }"/>');"><c:out value="${item.title }"/></a></td>
	                        <td><c:out value="${item.createName }"/></td>
	                        <td><fmt:formatDate value="${item.createDate }" pattern="YYYY-MM-DD"/></td>
	                        <td><fmt:formatNumber value="${item.readCount }" groupingUsed="true"/></td>
	                    </tr>
	                </c:forEach>
	                </tbody>
	            </table>
	            <!-- //list -->

	             <div class="paging-area">
	                 <!-- pagination -->
	                 <div class="pagination medium">${paging}</div>
	                 <!-- //pagination -->
	             </div>
            </c:if>
        </section>
        </form>
    </div>
</div>

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
        formSubmit("form1", "/history/board");
    });
});

function fncGoPage(nPage){
    $("#_page").val(nPage);
    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
}

function fcnDetail(pBoardSeq) {
	formSubmit("form1", "<c:url value="/history/board/"/>" + pBoardSeq);
}

</script>