<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/movie.css">

    <div id="contents">
        <div class="breadcrumb">
            <%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
        </div>
        <div class="container">
            <div class="top-area">
                <%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
	            <%@ include file="/WEB-INF/jsp/common/include/common/common02.jsp"%>
            </div>
        <c:set var="yearListLen" value="${fn:length(movieYearList) }"/>
        <form id="form1" name="form1" method="post">
            <sec:csrfInput/>
            <input type="hidden" id="minYear" name="minYear" value="<c:out value="${movieYearList[0]}" />"/>
            <input type="hidden" id="maxYear" name="maxYear" value="<c:out value="${movieYearList[yearListLen - 1]}" />"/>
            <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
            <section id="fieldset">

                <!-- prev/next -->
                <div class="mPNext">
                    <c:choose>
                        <c:when test="${not empty detailInfo.preMaYear }">
                            <a href="<c:url value="/story/year/"/><c:out value="${detailInfo.preMaYear }"/>" class="prev">Prev</a>
                        </c:when>
                        <c:otherwise>
                            <span class="prev">Prev</span>
                        </c:otherwise>
                    </c:choose>

                    <span class="year"><c:out value="${detailInfo.maYear }"/></span>

                    <c:choose>
                        <c:when test="${not empty detailInfo.nextMaYear }">
                            <a href="<c:url value="/story/year/"/><c:out value="${detailInfo.nextMaYear }"/>" class="next">Next</a>
                        </c:when>
                        <c:otherwise>
                            <span class="next">Next</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- //prev/next -->

                <!-- search -->
                <div class="mSearch">
                    <div class="dbinfo-search">
                        <input type="text" id="maYear" name="maYear" placeholder="연도 4자리 ex) <c:out value="${detailInfo.maYear }"/>">
                        <button class="ico-search" id="btnSearch"></button>
                    </div>
                    <p class="info">* 제공연도 : <c:out value="${movieYearList[0]}" />년 ~ <c:out value="${movieYearList[yearListLen - 1]}" />년</p>
                </div>
                <!-- //search -->

                <!-- list -->
                <div class="mList3">
                    <strong class="tit"></strong>
                    <c:out value="${detailInfo.content }" escapeXml="false"/>
                </div>
                <!-- //list -->

            </section>
        </form>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function(){
    //design
    $("#wrap").addClass("background1");

    $("#maYear").inputmask({mask:9999, placeholder: ''});

    $("#form1").validate({
        submitHandler: function(form) {
            formSubmit("form1", "<c:url value='/story/year/'/>" + $("#maYear").val());
        }
        ,rules: {
        	maYear: { required: true, range : [$("#minYear").val(), $("#maxYear").val()] }
        }
        ,messages: {
        	maYear: { required: "검색연도를 입력하세요.", range : $("#minYear").val() + "년 ~ " + $("#maxYear").val() + "년 사이에서 입력하세요."}
        }
    });
});

function fncGoPage(nPage){

}
</script>