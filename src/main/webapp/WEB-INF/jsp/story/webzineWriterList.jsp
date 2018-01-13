<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/movie.css">

<div id="contents" class="topfix">
    <div class="breadcrumb">
        <%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
    </div>
    <div class="container">
        <div class="top-area type2">
            <%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
	        <div class="submenu-depth3">
	            <h3 class="submenu-depth3-title2"><span><em>영화천국</em> 필자목록</span></h3>
	        </div>
        </div>

        <form>
            <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
            <section id="fieldset">
                <!-- list -->
                <c:set var="divFirstSound" value=""/>

                <div class="mList1">
                    <dl>
                    <c:forEach var="item" items="${writerList }">
                        <dt><c:out value="${item.firstSound }"/></dt>


                            <dd>
                                <div class="list">
	                                <ul>
	                                <c:if test="${empty item.writerDivList }">
	                                    <li class="nodata"><span class="">필진 자료가 없습니다</span></li>
	                                </c:if>
	                                <c:forEach var="subItem" items="${item.writerDivList }">
	                                    <c:choose>
	                                        <c:when test="${subItem.webzineCount <= 0  }">
	                                            <li><a href="#none;"><c:out value="${subItem.writerName }"/><em>(<c:out value="${subItem.webzineCount }"/>)</em></a></li>
	                                        </c:when>
	                                        <c:otherwise>
	                                            <li><a href="<c:url value="/story/webzine/writer/content/list?writer="/><c:out value="${subItem.writerName }"/>"><c:out value="${subItem.writerName }"/><em>(<c:out value="${subItem.webzineCount }"/>)</em></a></li>
	                                        </c:otherwise>
	                                    </c:choose>
	                                </c:forEach>
	                                </ul>
                                </div>
                            </dd>
                    </c:forEach>
                </div>
                <!-- //list -->

            </section>
        </form>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function(){
});

function fncGoPage(nPage){

}
</script>