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


        <input type="hidden" id="partCode" name="partCode" value="<c:out value="${paramMap.partCode }"/>"/>
        <input type="hidden" id="code01" name="code01" value="<c:out value="${masterInfo.code01 }"/>"/>
        <input type="hidden" id="code02" name="code02" value="<c:out value="${paramMap.code02 }"/>"/>
        <input type="hidden" id="searchGbn" name="searchGbn" value="<c:out value="${paramMap.searchGbn }"/>"/>


            <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
            <section id="fieldset">

                <!-- module -->
                <div class="mView4">
                    <!-- profile -->
                    <div class="mProfile2">
                        <div class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${masterInfo.fileName }"/>')"></span></div>
                        <div class="text">
                            <span class="tit"><c:out value="${masterInfo.subject }"/></span>
                            <span class="nam"><c:out value="${masterInfo.targetName }"/>,  <c:out value="${masterInfo.birthYear }"/>   </span>
                            <span class="lst">
                                <span class="ls"><em>분야</em> <c:choose><c:when test="${masterInfo.partCode == '9999' }"><c:out value="${masterInfo.txtPartCodeName }"/></c:when><c:otherwise><c:out value="${masterInfo.partCodeName }"/></c:otherwise></c:choose></span>
                                <span class="ls"><em>채록연구자</em> <c:out value="${masterInfo.chercheur }"/></span>
                                <span class="ls"><em>구술면담일</em> <c:out value="${masterInfo.talkTerm }"/></span>
                            </span>
                        </div>
                    </div>
                    <!-- //profile -->

                    <!-- 회차별 상세 목록 -->
                    <div class="mDList1">
                        <div class="result-block-tt type2">
                            <h4>회차별 상세 목록</h4>
                        </div>
                        <c:forEach var="item" items="${contentList }" varStatus="status">

                            <dl>

                            <c:choose>
                                <c:when test="${empty item.orgFileName }">
                                    <dt><em class="num"><c:out value="${status.count }"/></em> <c:out value="${item.subject }"/></dt>
                                </c:when>
                                <c:otherwise>
	                                <c:set var="fileSeqTmp" value="" />
	                                <c:set var="fileOrderTmp" value="" />
	                                <c:forEach var="fileItem" items="${contentFileList }">
	                                	<c:if test="${fileItem.detailSeq eq item.detailSeq}">
	                                		<c:set var="fileSeqTmp" value="${fileItem.fileSeq }" />
	                                		<c:set var="fileOrderTmp" value="${fileItem.fileOrder }" />
	                                	</c:if>
			                        </c:forEach>
                                    <dt><em class="num"><c:out value="${status.count }"/></em> <a href="javascript:fcnPdfViewer('form1', '<c:out value="${fileSeqTmp}" />', '<c:out value="${fileOrderTmp}" />');"><span class="iPdf3"><c:out value="${item.subject }"/></span></a></dt>

                                </c:otherwise>
                            </c:choose>

                            <dd>
                                <c:out value="${item.contents }" escapeXml="false"/>
                            </dd>
                            </dl>
                        </c:forEach>

                    </div>
                    <!-- //회차별 상세 목록 -->

                    <!-- 키워드 -->
                    <div class="result-block">
                        <div class="result-block-tt">
                            <h4>키워드</h4>
                        </div>
                        <!-- list -->
                        <div class="mTag1 noline purple">
                            <c:set var="arrSearchKeyword" value="${fn:split(masterInfo.searchKeyword,',')}" />
                            <c:forEach var="item" items="${arrSearchKeyword }">
                                <a href="javascript:fcnKeyword('<c:out value="${fn:trim(item) }"/>');">#<c:out value="${fn:trim(item) }"/></a>
                            </c:forEach>
                        </div>
                        <!--//list -->
                        <%--
                        <div class="mButton1 mt15">
                            <span class="gRight"><a href="#jsKeyword" class="iOpen1">펼쳐보기</a></span>
                        </div>
                         --%>
                    </div>
                    <!-- //키워드 -->

                    <!-- pdf -->
                    <div class="mPdf">
                        <ul>
                        <c:if test="${not empty pdf20FileInfo }">
                            <li><a href="javascript:fcnPdfViewer('form1', '<c:out value="${pdf20FileInfo.fileSeq }" />', '<c:out value="${pdf20FileInfo.fileOrder }" />');">해제문 PDF</a></li>
                        </c:if>
                        <c:if test="${not empty pdf30FileInfo }">
                            <li><a href="javascript:fcnPdfViewer('form1', '<c:out value="${pdf30FileInfo.fileSeq }" />', '<c:out value="${pdf30FileInfo.fileOrder }" />');">경력사항 PDF</a></li>
                        </c:if>
                        <c:forEach var="item" items="${contentFileList }">
                            <li><a href="javascript:fcnPdfViewer('form1', '<c:out value="${item.fileSeq }" />', '<c:out value="${item.fileOrder }" />')"><c:out value="${item.orgFileOnlyName }"/> <c:out value="${item.fileExt }"/></a></li>
                        </c:forEach>
                        </ul>
                    </div>
                    <!-- //pdf -->

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
	formSubmit("form1", "<c:url value="/history/talk"/>");
}

function fcnKeyword(pKeyword) {
    $("#_page").val("1");
    $("#_pageSize").val("");
    $("#searchType").val("");
    $("#searchText").val("");
    $("#partCode").val("");
    $("#code01").val("");
    $("#code02").val("");
    $("#searchGbn").val("");

    pKeyword = encodeURIComponent( encodeURIComponent( pKeyword ) );


	formSubmit("form1", "<c:url value="/history/talk/keyword/list"/>?keyword=" + pKeyword);
}

</script>