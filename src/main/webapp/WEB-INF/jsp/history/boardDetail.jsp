<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        </div>

        <form id="form1" name="form1" method="post">
        <sec:csrfInput/>

        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
        <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>
        <input type="hidden" id="searchType" name="searchType" value="<c:out value='${paramMap.searchType}'/>"/>
        <input type="hidden" id="searchText" name="searchText" value="<c:out value='${paramMap.searchText}'/>"/>
        <input type="hidden" id="searchOrderType" name="searchOrderType" value="<c:out value='${paramMap.searchOrderType}'/>"/>

        <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
		<section id="fieldset">

		    <!-- module -->
		    <div class="mView1">
		        <div class="title">
		            <h2><c:out value="${detailInfo.title }"/></h2>
		            <div class="sub-tt2">
		                <c:out value="${detailInfo.createName }"/>
		                <span class="dots"><fmt:formatDate value="${detailInfo.createDate }" pattern="YYYY-MM-DD"/></span>
		                <span class="dots"><span class="iCount"><fmt:formatNumber value="${detailInfo.readCount }" groupingUsed="true"/></span></span>
		            </div>
		        </div>
		        <div class="article type2">
                    <c:out value="${detailInfo.contentDesc }" escapeXml="false"/>
		        </div>
		        <div class="btn-group large btnlist"><a class="btn large slightly" href="javascript:fcnGoList();"><i class="ico-btnlist"></i><span>목록</span></a></div>
		    </div>
		    <!-- //module -->


		</section>
        </form>
    </div>
</div>


<script type="text/javascript">
$(document).ready(function(){
	setCopyProtection("<c:out value="${masterInfo.copyProtectionYn}"/>");
});

function fcnGoList() {
	formSubmit("form1", "<c:url value="/history/board"/>");
}

</script>