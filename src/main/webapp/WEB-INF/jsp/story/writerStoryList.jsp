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
            <h3 class="submenu-depth3-title2"><span><em><c:out value="${paramMap.writerName }"/></em> 필자의 글 입니다.</span></h3>
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
	                <c:forEach var="item" items="${pageListVo.resultList }" varStatus="status">
	                    <li>
	                        <a href="javascript:fcnDetail('<c:out value="${item.storyDivSeq }"/>','<c:out value="${item.storySeq}"/>');">
	                            <span class="mImg1"><span style="background-image: url('${MOVIE_STORY_IMG_PATH}<c:out value="${item.fileName }"/>')"></span></span>
	                            <span class="text">
	                                <span class="tit"><c:out value="${item.title }"/></span>
	                                <span class="des"><c:out value="${item.shortNonTagContentDesc }" escapeXml="false"/></span>
	                                <span class="nam"><span>by.</span>${item.writerName }</span>
	                                <fmt:parseDate value="${item.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
	                                <span class="dat"><fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/></span>
	                            </span>
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

function fcnDetail(pStoryDivSeq, pStorySeq) {
	$("#_page").val("");
	$("#_pageSize").val("");

    formSubmit("form1", "<c:url value="/story/"/>" + pStoryDivSeq + "/" + pStorySeq);
}

function fncGoPage(nPage){
    $("#_page").val(nPage);

    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>?writer=<c:out value="${paramMap.writerName}"/>");
}
</script>