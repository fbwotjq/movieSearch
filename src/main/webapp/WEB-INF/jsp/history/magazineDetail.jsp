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

        <input type="hidden" id="code01" name="code01" value="<c:out value="${paramMap.code01 }"/>"/>
        <input type="hidden" id="year" name="year" value="<c:out value="${paramMap.year }"/>"/>


        <!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
        <section id="fieldset">

            <c:if test="${not empty gallaryList }">
	            <!-- keyvisual -->
	            <div class="mARKey1">
	                <div class="owl-carousel owl-theme" id="archives-keyvisual">
	                    <c:forEach var="item" items="${gallaryList }">
	                    	<div><a href="###" class="jsBtnImage"><span class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${item.fileName}"/>')"></span></span></a></div>
	                    </c:forEach>
	                </div>
	            </div>
	            <!-- //keyvisual -->
            </c:if>

            <!-- module -->
            <div class="mView4">
                <!-- profile -->
                <div class="mProfile2">
                    <div class="mImg1"><span style="background-image: url('${ONLINE_ARCHIVES_PATH}<c:out value="${masterInfo.fileName }"/>')"></span></div>
                    <div class="text staticForPc">
                        <span class="nam"><c:out value="${masterInfo.subject }"/></span>
                        <div class="mLink">
                            <span class="link col1">
                                <a href="javascript:fcnPdfViewer('form1', '<c:out value="${masterFileInfo.fileSeq }"/>', '${masterFileInfo.fileOrder }');"><span class="iPdf2">뷰어</span></a>
                            </span>
                        </div>
                    </div>
                </div>
                <!-- //profile -->

                <!-- description -->
                <c:forEach var="item" items="${contentList }">
                    <div class="result-block-tt type2 mt2">
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
function callback(event) {
	var items     = event.item.count;     // Number of items
    var item      = event.item.index;
    $("#imgTitle_").text($("#img_"+item).attr("alt"));

    $("#em_count").text("("+(item+1)+"/"+items+")");

}
function fcnGoGallay(){
	$(".mLayer1").show();
}
function fcnGoList() {
	formSubmit("form1", "<c:url value="/history/magazine"/>");
}


</script>