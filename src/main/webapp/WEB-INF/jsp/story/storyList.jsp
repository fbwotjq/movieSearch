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
                            <label><input type="radio" name="searchType" id="searchType_title" value="TITLE" <c:if test="${empty paramMap.searchType || paramMap.searchType eq 'TITLE' }">checked="checked"</c:if>> <span class="label">제목</span></label>
                        </div>
                        <div class="asset type2">
                            <label><input type="radio" name="searchType" id="searchType_content" value="CONTENT" <c:if test="${paramMap.searchType eq 'CONTENT' }">checked="checked"</c:if>> <span class="label">내용</span></label>
                        </div>
                        <div class="asset type2">
                            <label><input type="radio" name="searchType" id="searchType_writer" value="WRITER" <c:if test="${paramMap.searchType eq 'WRITER' }">checked="checked"</c:if>> <span class="label">필자</span></label>
                        </div>
                    </div>

                    <a href="<c:out value="/story/writer/list"/>" class="iWriter">영화글 필자별 보기</a>

                </div>
                <!-- //search -->

                <!-- sort -->
                <div class="mSort1">
                    <h4>전체게시물(<span class="em weighty"><c:out value="${pageListVo.totalCount }"/></span>)</h4>
                    <div class="rt">
                        <div class="dbinfo-table-sort">
                            <div class="area">
                                <label for="searchOrderType" class="blind">내림차순</label>
                                <select id="searchOrderType" name="searchOrderType" class="select-tric">
                                    <option value="DESC" <c:if test="${empty paramMap.searchOrderType || paramMap.searchOrderType == 'DESC' }">selected="selected"</c:if>>내림차순</option>
                                    <option value="ASC"  <c:if test="${paramMap.searchOrderType == 'ASC' }">selected="selected"</c:if>>오름차순</option>
                                </select>
                            </div>
                            <div class="area">
                                <label for="_pageSize" class="blind">한페이지 출력물수</label>
                                <select id="_pageSize" name="_pageSize" class="select-tric">
                                    <option value="10" <c:if test="${empty paramMap._pageSize || paramMap._pageSize == '10' }">selected="selected"</c:if>>10개 출력</option>
                                    <option value="20" <c:if test="${paramMap._pageSize == '20' }">selected="selected"</c:if>>20개 출력</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //sort -->

                <!-- list -->
                <div class="mImage1">
                    <ul>
                        <%--
                        <li>
                            <a href="#">
                                <span class="mImg1"><span style="background-image: url('../../resources/images/@temp/movie13-01.jpg')"></span></span>
                                <span class="text">
                                    <span class="tit">모감보 Mogam bo (1953)</span>
                                    <span class="des">‘아프리카를 무대로 펼쳐지는 모험과 로맨스의 대작 오락물’에서 존 포드의 이름을 보게 되는 건 아무래도 어색하다. <모감보>는 여러 면에서 예외적인 포드 영화다. 먼저 눈에 띄는 건 배우들이다. 주연을 맡은 당대의 톱스타 클락 게이블...</span>
                                    <span class="nam"><span>by.</span>허문영<em>(영화평론가)</em></span>
                                    <span class="dat">2017-11-02</span>
                                </span>
                            </a>
                        </li>
                        --%>
                        <c:forEach var="item" items="${pageListVo.resultList }" varStatus="status">
	                        <li>
	                            <a href="javascript:fcnDetail('<c:out value="${item.storyDivSeq}"/>','<c:out value="${item.storySeq}"/>');">
	                                <span class="mImg1"><span style="background-image: url('${MOVIE_STORY_IMG_PATH}<c:out value="${item.fileName }"/>')"></span></span>
	                                <span class="text">
										<span class="tit wrap">
											<span class="ti"><c:out value="${item.title }"/></span>
											<span class="ts"><c:out value="${item.subTitle }"/></span>
										</span>
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
    $("#form1").validate({
        submitHandler: function(form) {
        	$("#_page").val("1");
            formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
        }
    });

    $("#_pageSize, #searchOrderType").bind("change", function() {
        fcnSearch();
    });
});

function fcnSearch() {
	$("#_page").val("1");
    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
}

function fncGoPage(nPage){
    $("#_page").val(nPage);
    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
}


function fcnDetail(pStoryDivSeq,pStorySeq) {
	formSubmit("form1", "<c:url value="/story/"/>"+ pStoryDivSeq +"/" + pStorySeq);
}


</script>