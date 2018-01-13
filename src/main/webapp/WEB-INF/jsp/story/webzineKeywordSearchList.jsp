<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/movie.css">

<div id="contents">
    <div class="breadcrumb">
        <%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
    </div>
    <div class="container">
        <div class="top-area type2"> <!-- 상단에 간격을 주기 위해 class="type2" 추가  -->
            <%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
            <div class="submenu-depth3">
                <h3 class="submenu-depth3-title2"><span>#<c:out value="${paramMap.keyword }"/></span></h3>
            </div>
        </div>

        <form id="form1" name="form1" method="post">
            <sec:csrfInput/>
	        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
	        <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>
        <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
        <section id="fieldset">

            <!-- list -->
            <div class="mImage1">
                <!-- sort -->
                <div class="mSort1">
                    <h4>전체게시물(<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
                </div>
                <!-- //sort -->
                <ul>
                    <c:forEach var="item" items="${pageListVo.resultList }">
	                    <li>
	                        <a href="javascript:fcnContentDetail('<c:out value="${item.seq }"/>');">
	                            <span class="mImg1"><span style="background-image: url('<c:out value="${KF_FILM_UPLOAD_PATH}${item.contentImgPath }"/>')"></span></span>
	                            <div class="text">
	                                <span class="tit"><c:out value="${item.subject }"/></span>
	                                <span class="des"><c:out value="${item.shortNonTagContent }" escapeXml="false"/></span>
	                                <span class="nam"><span>by.</span>&nbsp;<c:out value="${item.writerName }"/></span>
	                                <span class="dat"><fmt:formatDate value="${item.regdt}" pattern="yyyy-MM-dd"/></span>
	                            </div>
	                        </a>
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

<script type="text/javascript">
$(document).ready(function(){
});

function fcnContentDetail(pSeq) {
    $("#_page").val("");
    $("#_pageSize").val("");

    formSubmit("form1", "<c:url value="/story/webzine/content/"/>" + pSeq);
}

function fncGoPage(nPage){
    $("#_page").val(nPage);

    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>?" + "keyword=<c:out value="${paramMap.keyword}"/>");
}
</script>