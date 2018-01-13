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
        </div>

        <form id="form1" name="form1" method="post">
        <sec:csrfInput/>
        <input type="hidden" id="dFileSeq" name="dFileSeq">
        <input type="hidden" id="dFileOrder" name="dFileOrder">
        <input type="hidden" id="dReturnUrl" name="dReturnUrl" value="<c:url value='${paramMap._view_path}'/>">

        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
        <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>
        <input type="hidden" id="searchType" name="searchType" value="<c:out value='${paramMap.searchType}'/>"/>
        <input type="hidden" id="searchText" name="searchText" value="<c:out value='${paramMap.searchText}'/>"/>
        <input type="hidden" id="searchOrderType" name="searchOrderType" value="<c:out value='${paramMap.searchOrderType}'/>"/>

        <input type="hidden" id="code01" name="code01" value="<c:out value="${paramMap.code01 }"/>"/>
        <input type="hidden" id="code02" name="code02" value="<c:out value="${paramMap.code02 }"/>"/>
        <input type="hidden" id="year" name="year" value="<c:out value="${paramMap.year }"/>"/>


        <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
        <section id="fieldset">

            <!-- module -->
            <div class="mView4">
                <!-- profile -->
                <div class="mProfile2">
                    <div class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${masterInfo.fileName }"/>')"></span></div>
                    <div class="text">
                        <span class="tit"><c:out value="${masterInfo.code02Name }"/></span>
                        <span class="nam"><c:out value="${masterInfo.subject }"/></span>
                        <span class="lst">
                            <span class="ls"><em>저자</em> <c:out value="${masterInfo.targetName }"/></span>
                            <span class="ls"><em>발행년도</em> <c:out value="${masterInfo.birthYear }"/>년</span>
                        </span>
                    </div>
                </div>
                <!-- //profile -->

                <div class="mLink">
                    <c:choose>
                        <c:when test="${masterFileInfo.freeYn eq 'N' && masterFileInfo.payYn eq 'N'}">
                            <sec:authorize access="isAuthenticated()">
                                <a href="javascript:fcnPay('<c:out value="${masterInfo.archivesSeq }"/>', '<c:out value="${masterFileInfo.fileSeq }" />', '<c:out value="${masterFileInfo.fileOrder }" />');" class="price"><span><fmt:formatNumber value="${masterFileInfo.amount }" groupingUsed="true"/>원</span></a>
                            </sec:authorize>
                            <sec:authorize access="isAnonymous()">
                                <a href="javascript:fcnLogin('form1');" class="price"><span><fmt:formatNumber value="${masterFileInfo.amount }" groupingUsed="true"/>원</span></a>
                            </sec:authorize>
                        </c:when>
                        <c:otherwise>
                            <span class="link">
                                <c:if test="${masterFileInfo.viewYn eq 'Y' }">
                                    <a href="javascript:fcnPdfViewer('form1', '<c:out value="${masterFileInfo.fileSeq }" />', '<c:out value="${masterFileInfo.fileOrder }" />');" class="iPdf2">뷰어</a>
                                </c:if>

                                <c:if test="${masterFileInfo.downYn eq 'Y' }">
                                    <a href="javascript:fcnDownload('form1', '<c:out value="${masterFileInfo.fileSeq }" />', '<c:out value="${masterFileInfo.fileOrder }" />')" class="iDownload">다운로드</a>
                                </c:if>
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- description -->
                <c:forEach var="item" items="${contentList }">
	                <div class="result-block-tt type2 mt1">
	                    <h4><c:out value="${item.subject }"/></h4>
	                </div>
	                <div class="mTxt3">
	                    <c:out value="${item.contents }" escapeXml="false"/>
	                </div>
                </c:forEach>

                <!-- //description -->

                <c:if test="${masterInfo.publicMark != 5}">
                    <div class="type"><img src="/resources/images/common/public_type<c:out value="${masterInfo.publicMark }"/>.jpg" width="64" alt="공공누리 공공저작물"></div>
                </c:if>

                <c:if test="${masterInfo.copyProtectionYn eq 'Y' }">
                    <div class="alert">※ 본 게시물에는 작성자(필자)의 요청에 의해 복사, 마우스 드래그, 오른쪽 버튼 클릭 등 일부 기능 사용이 제한됩니다.</div>
                </c:if>


                <div class="btn-group large btnlist">
                    <a class="btn large slightly" href="javascript:fcnGoList();"><i class="ico-btnlist"></i><span>목록</span></a>
                </div>
            </div>
            <!-- //module -->


        </section>
        </form>
    </div>
</div>

<script type="text/javascript" src="/resources/js/archives.js"></script> <!-- js for archives page -->
<script type="text/javascript" src="/resources/js/history/history.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	setCopyProtection("<c:out value="${masterInfo.copyProtectionYn}"/>");
});

function fcnGoList() {
	formSubmit("form1", "<c:url value="/history/book"/>");
}

function fcnPay(pArchivesSeq, seq, order){
	window.open("<c:url value='${paramMap._list_path}'/>"+"/pay/"+pArchivesSeq+"/"+seq+"/"+order, 'popPay','toolbar=no,location=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=520, top=30,left=100');
}

function fnRefresh(){
	formSubmit("form1", "<c:url value='${paramMap._list_path}'/>"+"/"+"<c:url value='${masterInfo.archivesSeq}'/>");
}

</script>