<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/resources/js/mypage.js"></script> <!-- js for mypage page -->
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/mypage.css">

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
        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
        <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>

			<!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
			<section id="fieldset">

				<!-- module -->
				<div class="mView1">
					<div class="title">
						<c:if test="${detailInfo.privateTypeCd == 01 }">
							<em class="tit">VOD 이용문의</em>
						</c:if>
						<c:if test="${detailInfo.privateTypeCd == 02 }">
							<em class="tit">홈페이지 이용문의</em>
						</c:if>
						<c:if test="${detailInfo.privateTypeCd == 03 }">
							<em class="tit">DB 오류신고</em>
						</c:if>
						<c:if test="${detailInfo.privateTypeCd == 04 }">
							<em class="tit">기타 문의</em>
						</c:if>
						<h2><c:out value='${detailInfo.title}'/></h2>
						<div class="sub-tt2">
							<c:out value='${detailInfo.createDate}'/>
							<span class="dots">
								<c:if test="${detailInfo.replyNm == '처리중'}">
									<span class="iStatus"><c:out value='${detailInfo.replyNm}'/></span>
								</c:if>
								<c:if test="${detailInfo.replyNm == '답변완료'}">
									<span class="iStatus end"><c:out value='${detailInfo.replyNm}'/></span>
								</c:if>
							</span>
						</div>
					</div>
					<div class="article">
						<c:out value="${detailInfo.contentDesc }" escapeXml="false"/>
						<!-- answer -->
						<c:if test="${detailInfo.replyYn == 'Y'}">
							<div class="mAnswer">
								<strong class="ti"><span class="ico">A</span> <c:out value='${detailInfo.replyTitle}'/></strong>
								<c:out value="${detailInfo.replyContentDesc }" escapeXml="false"/>
							</div>
						</c:if>
						<c:if test="${detailInfo.replyYn == 'N'}">
							<div class="mAnswer gray">
								<strong class="ti"><span class="ico">A</span> 답변이 등록되지 않았습니다.</strong>
							</div>
						</c:if>
						<!-- //answer -->

					</div>
					<div class="btn-group large btnlist">
						<button class="btn large slightly" onClick="fncGoList();"><i class="ico-btnlist"></i><span>목록</span></button>
					</div>
				</div>
				<!-- //module -->
			</section>
		</form>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function(){

});

function fncGoList() {
    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._list_path}'/>";
    frm.submit();
}
</script>