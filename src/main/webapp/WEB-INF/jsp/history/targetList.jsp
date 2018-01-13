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
                <h3 class="submenu-depth3-title">구술인 전체보기</h3>
            </div>
        </div>

        <form id="form1" name="form1" method="post">
        <sec:csrfInput/>
        <input type="hidden" id="code01" name="code01"/>
        <input type="hidden" id="searchType" name="searchType"/>
        <input type="hidden" id="searchText" name="searchText"/>

	        <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
	        <section id="fieldset">

	            <!-- list -->
	            <div class="mList1">
	                <dl>
	                <c:forEach var="item" items="${targetList }">
	                <dt><c:out value="${item.firstSound }"/></dt>

	                <dd>
	                    <div class="list2">
	                        <ul>
	                        <c:if test="${empty item.targetList }">
	                            <li class="nodata"><span>구술인 자료가 없습니다</span></li>
	                        </c:if>
	                        <c:forEach var="subItem" items="${item.targetList }">
	                            <li class="type2">
	                             <span class="tit"><c:out value="${subItem.targetName }"/></span>
	                             <c:if test="${subItem.cnt10 > 0 }">
	                                 <a href="javascript:fcnGoList('10', '<c:out value="${subItem.targetName }"/>');" class="txtBlue">생애사</a><br>
	                             </c:if>

	                             <c:if test="${subItem.cnt20 > 0 }">
	                                 <a href="javascript:fcnGoList('20', '<c:out value="${subItem.targetName }"/>');" class="txtBlue">주제사</a>
	                             </c:if>
	                            </li>
	                        </c:forEach>
	                        </ul>
	                    </div>
	                </dd>
	                </c:forEach>
	                </dl>
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

});

function fcnGoList(pCode01, pTargetName) {
	$("#code01").val(pCode01);
	$("#searchType").val("TARGET");
	$("#searchText").val(pTargetName);

	formSubmit("form1", "<c:url value="/history/talk"/>");
}

</script>