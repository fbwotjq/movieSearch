<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
<link rel="stylesheet" type="text/css" href="/resources/css/vendors/uniform.default.css">
<link rel="stylesheet" type="text/css" href="/resources/css/vendors/selectric.css">
<link rel="stylesheet" type="text/css" href="/resources/plugins/owlslide/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="/resources/plugins/owlslide/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="/resources/plugins/jquery.mCustomScrollbar/jquery.mCustomScrollbar.css" />
<link rel="stylesheet" type="text/css" href="/resources/plugins/pg-calendar-master/pignose.calendar.min.css">
<script type="text/javascript" src="/resources/js/lib/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/resources/js/lib/jquery.bpopup.js"></script>
<script type="text/javascript" src="/resources/plugins/owlslide/owl.carousel.js"></script>
<script type="text/javascript" src="/resources/plugins/owlslide/owl.carousel2.thumbs.js"></script>
<script type="text/javascript" src="/resources/plugins/jquery.selectric-1.11.1/jquery.selectric.min.js"></script>
<script type="text/javascript" src="/resources/plugins/jquery.uniform-2.2.0/jquery.uniform.min.js"></script>
<script type="text/javascript" src="/resources/plugins/jquery.mCustomScrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
<script type="text/javascript" src="/resources/plugins/pg-calendar-master/pignose.calendar.full.min.js"></script>
<script type="text/javascript" src="/resources/js/common.js"></script>
<script type="text/javascript" src="/resources/js/vod.js"></script> <!-- js for vod page -->

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/vod.css">
<c:if test="${returnCode != '0' }">
	<script>alert("${returnMap.resultMsg}"); window.close();</script>
</c:if>

<c:if test="${returnCode == '0' }">
<script>
window.resizeTo(1024, 500);
</script>

<!-- VOD 결제하기 -->
	<div class="mPopup1 winPop" id="jsPayVod">
		<div class="popupBg">
			<h4 class="title">VOD 결제하기</h4>
			<div class="cont">
				<p class="info2">결제가 완료되었습니다.</p>
				<strong class="tit2">결제방법</strong>
				<ul class="info mt1">
				<li>
					<span class="t">거래번호</span>
					<span class="c">${returnMap.tid}</span>
				</li>
				<li>
					<span class="t">주문번호</span>
					<span class="c">${returnMap.moid}</span>
				</li>
				<li>
					<span class="t">결제수단</span>
					<span class="c">${returnMap.payMethod}</span>
				</li>
				<li>
					<span class="t">결제금액</span>
					<span class="c"><strong class="txtPruple"><fmt:formatNumber value="${returnMap.totPrice}" type="number"/> 원</strong></span>
				</li>
				<li>
					<span class="t">승인날짜</span>
					<span class="c">
					<fmt:parseDate var="dateString" value="${returnMap.applDate}${returnMap.applTime }" pattern="yyyyMMddHHmmss" />
				  	<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" />
				  	</span>
				</li>
				<li>
					<span class="t">승인시간</span>
					<span class="c"><fmt:formatDate value="${dateString}" pattern="HH:mm:ss" type="time"/></span>
				</li>
				</ul>
				<div class="mButton1">
					<button class="btn large weighty" type="button" onclick="window.close();">확인</button>
				</div>
			</div>
			<button type="button" class="b-close" title="닫기" onclick="window.close();">닫기</button>
		</div>
	</div>
	<!--//VOD 결제하기 -->
	<c:if test="${refreshYn == 'Y' }">
	<script type="text/javascript">
		try {
			if(typeof(opener.fnRefresh) == "function") {
				opener.fnRefresh();
			}
		} catch(e) {

		}
	</script>
	</c:if>

</c:if>