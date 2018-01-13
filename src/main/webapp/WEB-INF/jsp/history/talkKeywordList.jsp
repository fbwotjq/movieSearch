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
            <div class="submenu-depth3">
                <h3 class="submenu-depth3-title2"><span>#<c:out value="${paramMap.keyword }"/></span></h3>
            </div>
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
                        <label><input type="radio" name="searchType" id="searchType_TARGET" value="TARGET" <c:if test="${paramMap.searchType == 'TARGET' || empty paramMap.searchType }">checked="checked"</c:if>> <span class="label">구술인</span></label>
                    </div>
                    <div class="asset type2">
                        <label><input type="radio" name="searchType" id="searchType_STUDY" value="STUDY" <c:if test="${paramMap.searchType == 'STUDY'}">checked="checked"</c:if>> <span class="label">채록연구자</span></label>
                    </div>
                    <div class="asset type2">
                        <label><input type="radio" name="searchType" id="searchType_SUBJECT" value="SUBJECT" <c:if test="${paramMap.searchType == 'SUBJECT'}">checked="checked"</c:if>> <span class="label">주제</span></label>
                    </div>
                </div>
            </div>
            <!-- //search -->

            <!-- sort -->
            <div class="mSort1">
                <h4>전체게시물 (<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
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
	                     <a href="javascript:fcnDetail('<c:out value="${item.archivesSeq }"/>');">
	                         <span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></span>
                             <span class="text">
                                 <c:choose>
                                     <c:when test="${not empty item.subject }">
                                         <span class="tit"><c:out value="${item.subject }"/></span>
                                     </c:when>
                                     <c:otherwise>
                                         <span class="tit"><c:out value="${item.code01Name }"/></span>
                                     </c:otherwise>
                                 </c:choose>
                                 <span class="nam"><c:out value="${item.targetName }"/> (<c:choose><c:when test="${item.partCode == '9999' }"><c:out value="${item.txtPartCodeName }"/></c:when><c:otherwise><c:out value="${item.partCodeName }"/></c:otherwise></c:choose>) , <c:out value="${item.birthYear }"/></span>
                                 <span class="lst">
                                     <span class="ls"><em>채록연구자</em> <c:out value="${item.chercheur }"/></span>
                                     <span class="ls"><em>구술면담일</em> <c:out value="${item.talkTerm }"/></span>
                                 </span>
                             </span>
	                     </a>
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
            var pKeyword = encodeURIComponent( encodeURIComponent( '<c:out value="${paramMap.keyword }"/>' ) );
            formSubmit("form1", "<c:url value='${paramMap._view_path}'/>?keyword=" + pKeyword);
        }
    });

    $("#_pageSize, #searchOrderType").bind("change", function() {
    	$("#_page").val("1");
    	var pKeyword = encodeURIComponent( encodeURIComponent( '<c:out value="${paramMap.keyword }"/>' ) );
        formSubmit("form1", "<c:url value='${paramMap._view_path}'/>?keyword=" + pKeyword);
    });
});

function fncGoPage(nPage){
    $("#_page").val(nPage);
	var pKeyword = encodeURIComponent( encodeURIComponent( '<c:out value="${paramMap.keyword }"/>' ) );
    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>?keyword=" + pKeyword);
}

function initSearchValue() {
	$("#_page").val("1");
	$("#_pageSize").val("");
	$(":input[name='searchType']:checked").val("");
	$("#searchType").val("");
	$("#searchText").val("");
}


function fcnDetail(pArchivesSeq) {
	initSearchValue();

	formSubmit("form1", "<c:url value="/history/talk/"/>" + pArchivesSeq);
}

</script>