<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
			 <a href="<c:out value="/story/webzine/writer/list"/>" class="iWriter">영화천국 필자별 보기</a>
		</div>

        <form id="form1" name="form1" method="post">
        <sec:csrfInput/>
        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
        <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>
			<!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
			<section id="fieldset">

				<!-- list -->
				<div class="mImage3">
					<%--
                        <ul>
                            <li>
                                <a href="#">
                                    <span class="gImg"><span class="img" style="background-image: url('../../resources/images/@temp/movie16-1.jpg')"></span></span>
                                    <span class="text">
                                        <span class="tit">Vol.57</span>
                                        <span class="dat">2017.09.01</span>
                                        <span class="txt">멜로 영화 실종에 관한 보고서</span>
                                        <span class="ico"></span>
                                    </span>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <span class="gImg"><span class="img" style="background-image: url('../../resources/images/@temp/movie16-2.jpg')"></span></span>
                                    <span class="text">
                                        <span class="tit">Vol.57</span>
                                        <span class="dat">2017.09.01</span>
                                        <span class="txt">멜로 영화 실종에 관한 보고서</span>
                                        <span class="ico"></span>
                                    </span>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <span class="gImg"><span class="img" style="background-image: url('../../resources/images/@temp/movie16-3.jpg')"></span></span>
                                    <span class="text">
                                        <span class="tit">Vol.57</span>
                                        <span class="dat">2017.09.01</span>
                                        <span class="txt">멜로 영화 실종에 관한 보고서</span>
                                        <span class="ico"></span>
                                    </span>
                                </a>
                            </li>
                        </ul>
						 --%>
					<c:forEach var="item" items="${pageListVo.resultList }" varStatus="status">
						<c:if test="${status.first }">
							<ul>
						</c:if>

						<c:if test="${status.count != 1 && (status.count mod 3) == 1 }">
							</ul>
							<ul>
						</c:if>

						<li>
						    <a href="javascript:fcnDetail('<c:out value="${item.seq }"/>');">
						        <span class="mImg1"><span style="background-image: url('<c:out value="${KF_FILM_UPLOAD_PATH}${item.coverImgPath }"/>')"></span></span>
						        <span class="text">
						            <span class="tit">Vol.<c:out value="${item.upcate }" /></span>
						            <span class="dat"><c:out value="${item.reldate }" /></span>
						            <span class="txt"><c:out value="${item.nonTagContent }" escapeXml="false"/></span>
						            <span class="ico"></span>
							    </span>
						    </a>
						</li>

						<c:if test="${status.last }">
							</ul>
						</c:if>
					</c:forEach>

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

function fncGoPage(nPage){
    $("#_page").val(nPage);

    formSubmit("form1", "<c:url value='${paramMap._view_path}'/>");
}

function fcnDetail(pSeq) {
    formSubmit("form1", "<c:url value="/story/webzine/"/>" + pSeq);
}
</script>