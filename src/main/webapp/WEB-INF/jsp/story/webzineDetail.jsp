<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/movie.css">

<div id="contents" class="topfix">
    <div class="breadcrumb">
        <%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
    </div>
    <div class="container">
        <div class="top-area">
            <%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
        </div>

        <form id="form1" name="form1" method="post">
            <sec:csrfInput/>
	        <input type="hidden" id="webzineSeq" name="webzineSeq" value="<c:out value='${paramMap.webzineSeq}'/>"/>
	        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
	        <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>

            <section id="fieldset">
                <!-- prev/next -->
                <div class="mPNext">
                    <c:choose>
                        <c:when test="${not empty detailInfo.preSeq }">
                            <a href="<c:url value="/story/webzine/"/><c:out value="${detailInfo.preSeq }"/>" class="prev">Prev</a>
                        </c:when>
                        <c:otherwise>
                            <span class="prev">Prev</span>
                        </c:otherwise>
                    </c:choose>

                    <span class="year">Vol. <c:out value="${detailInfo.upcate }"/></span>

                    <c:choose>
                        <c:when test="${not empty detailInfo.nextSeq }">
                            <a href="<c:url value="/story/webzine/"/><c:out value="${detailInfo.nextSeq }"/>" class="next">Next</a>
                        </c:when>
                        <c:otherwise>
                            <span class="next">Next</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- //prev/next -->

                <!-- module -->
                <div class="mView2">
                    <div class="title">
                        <div class="img" style="background-image:url('<c:out value="${KF_FILM_UPLOAD_PATH}${detailInfo.coverImgPath }"/>');"></div>

                        <div class="text">
                            <h2>Vol.<c:out value="${detailInfo.upcate }"/> : <c:out value="${detailInfo.reldate }"/></h2>
                            <p class="txt"><c:out value="${detailInfo.nonTagContent }" escapeXml="false"/></p>
                            <a href="/download/url?fileUrl=<c:out value="${KF_FILM_UPLOAD_PATH}${detailInfo.pdfPath }"/>&fileName=<c:out value="${detailInfo.pdfFileName }"/>" class="btnPdf"><span class="">PDF 다운받기</span></a>
                        </div>

                        <div class="article">
                            <strong class="tit">목차</strong>

                            <c:set var="sectionSeq" />
                            <c:set var="sectionNumber" value="1"/>

                            <c:forEach var="item" items="${webzineContentList }" varStatus="status">
                                <c:if test="${item.sectionSeq ne sectionSeq}">
                                 <strong class="tit2">${sectionNumber }. <c:out value="${item.sectionSubject }"/></strong><br>

                                 <c:set var="sectionSeq" value="${item. sectionSeq}"/>
                                 <c:set var="sectionNumber" value="${sectionNumber + 1}"/>
                                </c:if>

                                <a href="javascript:fcnContentDetail('<c:out value="${item.seq }"/>');"><span class="tx1"><c:out value="${item.subject }"/></span></a>&nbsp;<span class="tx2"><c:out value="${item.writerName }"/></span><br>
                            </c:forEach>

                            <%--
                            <strong class="tit">목차</strong>
                            <strong class="tit2">01. 행사 프리뷰</strong><br>
                            <span class="tx1">또렷한 시대 감각을 만나다 (1) 70년대 새로운 세대의 시작</span> <span class="tx2">배수경 (영화사연구소 객원연구원)</span><br>
                            <span class="tx1">또렷한 시대 감각을 만나다 (2) 80년대 사회파 드라마의 거목</span> <span class="tx2">이지윤 (시네마테크부)</span><br>
                            <span class="tx1">스크린을 다시 찾은 영화들</span> <span class="tx2">이지윤 (시네마테크부)</span><br>
                            <span class="tx1">‘혁명’을 담은 영화들</span> <span class="tx2">정민화 (시네마테크부)</span><br><br>

                            <strong class="tit2">02. FOCUS</strong><br>
                            <span class="tx1">조심스레 올라서는 피고석</span> <span class="tx2">김세연(경영기획부) </span><br>
                            <span class="tx1">영화와 친숙해지는 흥미로운 경험</span> <span class="tx2">최승환(한국영화사연구소)</span><br><br>

                            <strong class="tit2">03. 해외통신</strong><br>
                            <span class="tx1">영화에 관한 이야기를 수집하는 아카이브</span> <span class="tx2">손이레(미시간대학교 아시아언어문화학부 박사과정)</span><br>
                            <span class="tx1">“확장보다 활용도를 고민해야 할 단계”</span> <span class="tx2">손이레(미시간대학교 아시아언어문화학부 박사과정)</span><br><br>
                            --%>

                        </div>
                    </div>
                    <div class="btn-group large btnlist">
                        <a class="btn large slightly" href="javascript:fcnGoList();">
                            <i class="ico-btnlist"></i><span>목록</span>
                        </a>
                    </div>
                </div>
                <!-- //module -->
            </section>
        </form>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function(){
    //design
    $("#wrap").addClass("background1 type2");
});

function fcnGoList(){
    formSubmit("form1", "<c:url value="/story/webzine"/>");
}

function fcnContentDetail(pSeq) {
    formSubmit("form1", "<c:url value="/story/webzine/content/"/>" + pSeq);
}
</script>