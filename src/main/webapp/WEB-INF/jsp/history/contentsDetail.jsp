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


        <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
        <section id="fieldset">
            <!-- module -->
            <div class="mView1">
                <div class="title">
                    <h2><c:out value="${masterInfo.subject }"/></h2>
                    <div class="sub-tt">
                        <span class="nam gray"><span>by. </span><c:out value="${masterInfo.targetName }"/></span>
                        <span class="dat"><fmt:formatDate value="${masterInfo.createDate}" pattern="yyyy-MM-dd"/></span>
                    </div>
                </div>
                <div class="article">
                    <div class="img center"><img src="${ONLINE_ARCHIVES_PATH}<c:out value="${masterInfo.fileName }"/>" alt="<c:out value="${masterInfo.fileAlt }"/>"></div>

                    <c:forEach var="item" items="${contentList }">
                        <c:out value="${item.contents }" escapeXml="false"/>
                    </c:forEach>

                    <c:if test="${masterInfo.publicMark != 5}">
                        <div class="type"><img src="/resources/images/common/public_type<c:out value="${masterInfo.publicMark }"/>.jpg" width="64" alt="공공누리 공공저작물"></div>
                    </c:if>

                    <c:if test="${masterInfo.copyProtectionYn eq 'Y' }">
                        <div class="alert">※ 본 게시물에는 작성자(필자)의 요청에 의해 복사, 마우스 드래그, 오른쪽 버튼 클릭 등 일부 기능 사용이 제한됩니다.</div>
                    </c:if>

                </div>
                <div class="btn-group large btnlist"><a class="btn large slightly" href="javascript:fcnGoList();"><i class="ico-btnlist"></i><span>목록</span></a></div>

                <c:if test="${not empty relDataList }">
	                <!-- 관련자료 -->
	                <div class="mPdf type2">
	                    <h4>관련자료</h4>
	                    <ul>
	                    <c:forEach var="item" items="${relDataList }">
	                        <c:choose>
	                            <c:when test="${item.fileAttrCd eq '10' }"> <%--파일 타입 --%>
	                                <li><a href="javascript:fcnDownload('form1', '<c:out value="${item.fileSeq }"/>', '<c:out value="${item.fileOrder }"/>');"><c:out value="${item.fileAlt }"/></a></li>
	                            </c:when>
	                            <c:otherwise>
	                                <li><a href="/download/url?fileUrl=<c:out value="${item.url }"/>" target="_blank" title="새창열림"><c:out value="${item.fileAlt }"/></a></li>
	                            </c:otherwise>
	                        </c:choose>
	                    </c:forEach>
	                    </ul>
	                </div>
	                <!-- //관련자료 -->
                </c:if>

                <c:if test="${not empty relLinkList }">
	                <!-- 관련글 -->
	                <div class="mList2 type2">
	                    <h4>관련글</h4>
	                    <ul>
	                    <c:forEach var="item" items="${relLinkList }">
	                        <li><a href="<c:out value="${item.url }"/>" target="_blank" title="새창열림"><c:out value="${item.subject }"/></a></li>
	                    </c:forEach>
	                    </ul>
	                </div>
	                <!-- //관련글 -->
                </c:if>

            </div>
            <!-- //module -->


        </section>
        </form>
    </div>
</div>


<c:set var="lenSum" value="0"/>
<c:set var="lenSum" value="${lenSum + fn:length(gallaryList) }"/>
<c:set var="lenSum" value="${lenSum + fn:length(relMovieList) }"/>
<c:set var="lenSum" value="${lenSum + fn:length(relPersonList) }"/>

<c:if test="${lenSum > 0 }">
	<!-- grid1 -->
	<div class="gGrid1">
	    <div class="gridBg">

            <c:if test="${fn:length(gallaryList) > 0 }">
	            <!-- 갤러리 -->
	            <div class="mList8 type2">
	                <h4>갤러리 <em>(<c:out value="${fn:length(gallaryList) }"/>)</em></h4>
	                <div class="owl-carousel owl-theme" id="archives-recomd-carousel">
	                    <c:forEach var="item" items="${gallaryList }" varStatus="i" >
	                        <div class="item">
	                            <a href="#url" class="jsBtnImage">
	                                <span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName }"/>')"></span></span>
	                                <span class="text"><c:out value="${item.fileAlt }"/></span>
	                            </a>
	                        </div>
	                    </c:forEach>
	                </div>
	            </div>
	            <!-- //갤러리 -->
            </c:if>


            <c:if test="${fn:length(relMovieList) > 0 }">
	        <!-- 연관영화 -->
	        <div class="mList2">
	            <h4>연관영화</h4>
	            <ul>
	            <c:forEach var="item" items="${relMovieList }">
	                <li><a href="javascript:fcnMovieDetail('<c:out value="${item.movieId }"/>', '<c:out value="${item.movieSeq }"/>');"><c:out value="${item.title }"/>&nbsp;(<c:out value="${item.director }"/>,&nbsp;<c:out value="${item.prodYear }"/>)</a></li>
	            </c:forEach>
	            </ul>
	        </div>
	        <!-- //연관영화 -->
            </c:if>

            <c:if test="${fn:length(relPersonList) > 0 }">
	        <!-- 연관영화인 -->
	        <div class="mList2">
	            <h4>연관영화인</h4>
	            <ul>
	            <c:forEach var="item" items="${relPersonList }">
		            <li><a href="javascript:fcnPersonDetail('<c:out value="${item.personId }"/>');"><c:out value="${item.personName }"/>&nbsp;<c:out value="${item.personfield }"/>&nbsp;<c:out value="${item.birthYear }"/>&nbsp;~&nbsp;<c:out value="${item.deathYear }"/></a></li>
	            </c:forEach>
	            </ul>
	        </div>
	        <!-- //연관영화인 -->
	        </c:if>

	    </div>
	</div>
	<!-- //grid1 -->
</c:if>

<!-- layer -->
<div id="jsImage" class="mLayer1" style="display:none;">
		<div class="modalBg"></div>
		<div class="layerBg">
			<div class="cont top">
				<div class="title">
				<h3>갤러리 <em id="em_count"></em></h3>
				</div>
				<a href="###" class="b-close" title="닫기"">닫기</a>
			</div>

			<!-- swiper -->
			<div class="mVImage1">
				<div class="owl-carousel owl-theme" id="db-image-view1">
				<c:forEach var="item" items="${gallaryList }" varStatus="i" >
					<div class="item">
						<span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName}"/>')"><img src="/resources/images/db/db_frame1.png" alt='<c:out value="${item.fileAlt}"/>' id='img_<c:out value="${i.index}"/>'></span></span>
					</div>
                </c:forEach>
				</div>
				<!-- <a href="###" class="iBig">큰 이미지 보기</a> -->
			</div>
			<!-- //swiper -->

			<div class="cont">
				<!-- list -->
				<div class="mTitle5">
				<strong class="tit" id="imgTitle_"></strong>
				</div>
				<!-- //list -->
			</div>
		</div>
	</div>
<!-- //layer -->

<script type="text/javascript" src="/resources/js/archives.js"></script> <!-- js for archives page -->
<script type="text/javascript" src="/resources/js/history/history.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	setCopyProtection("<c:out value="${masterInfo.copyProtectionYn}"/>");
	var dbImageView1 = $('#db-image-view1');
	dbImageView1.owlCarousel({
		loop:false,
		dots:false,
		nav: true,
		onChanged :callback,
		items:1
	});
	$('.jsBtnImage').bind('click', function(e) {
		e.preventDefault();
		BPOPUP =  $('#jsImage').bPopup({
			positionStyle: 'fixed'
		});
		$("body").addClass("overflowHidden")
		$("#jsImage .layerBg").height( $(window).height() );
	});
	$(window).bind("resize", function(){
		$("#jsImage .layerBg").height( $(window).height() );
	});
	$('#jsImage .b-close').bind('click', function(e) {
		$("body").removeClass("overflowHidden")
	});
});

function fcnGoList() {
	formSubmit("form1", "<c:url value="/history/contents"/>");
}
function callback(event) {
	var items     = event.item.count;     // Number of items
    var item      = event.item.index;
    $("#imgTitle_").text($("#img_"+item).attr("alt"));

    $("#em_count").text("("+(item+1)+"/"+items+")");

}
</script>