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

<!-- 이니시스 표준결제 js
	'가맹점의 URL이 http: 인경우 js URL도 http://stdpay.inicis.com/stdjs/INIStdPay.js 로 변경합니다.
	' https 일 경우 http://stgstdpay.inicis.com/stdjs/INIStdPay.js
	'가맹점에서 사용하는 케릭터셋이 EUC-KR 일 경우 charset="UTF-8"로 UTF-8 일 경우 charset="UTF-8"로 설정합니다.
-->

<c:choose>
	<c:when test ="${activeType eq 'LIVE' }">
		<script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
	</c:when>
	<c:otherwise>
		<script language="javascript" type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
	</c:otherwise>
</c:choose>

<sec:authorize access="isAnonymous()">
	<script>
		alert("접속정보가 없습니다. 다시 로그인 하세요."); window.close();
	</script>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="user" property="principal" />
</sec:authorize>

<script>
window.resizeTo(850, 700);
</script>

<form id="SendPayForm_id" method="POST" >
		<input type="hidden" name="version" value="1.0" />
		<input type="hidden" name="mid" value="${inipayMid}" />
		<input type="hidden" name="goodname" value="${selGoodsName}" />
		<input type="hidden" name="oid" value="${oid}" />
		<input type="hidden" name="price" value="${price}" />
		<input type="hidden" name="currency" value="WON" />
		<input type="hidden" name="buyername"value="${user.name}" />
		<input type="hidden" name="timestamp" value="${timestamp }" />
		<input type="hidden" name="signature" value="${signature }" />
		<input type="hidden" name="returnUrl" value="${inipayReturnUrl}?${_csrf.parameterName}=${_csrf.token}" />
		<input type="hidden" name="mKey" value="${mKey }" />
		<input type="hidden" name="offerPeriod" value="" />
		<input type="hidden" name="charset" value="UTF-8" />
		<input type="hidden" name="payViewType" value="" />
		<input type="hidden" name="closeUrl" value="${inipayCloseUrl }" />
		<input type="hidden" name="popupUrl" value="${inipayPopupUrl }" />
		<input type="hidden" name="languageView" value="" />
		<input type="hidden" name="acceptmethod" value="${inipayPayMethod }" />
		<input type="hidden" name="quotabase" value="${inipayMonth }" />
		<input type="hidden" name="ini_cardcode" value="" />
		<input type="hidden" name="ansim_quota" value="" />
		<input type="hidden" name="vbankRegNo" value="" />
		<input type="hidden" name="merchantData" value="${merchantData}" />

	<div class="mPopup1 winPop" id="jsPayVod">
		<div class="popupBg">
			<h4 class="title">VOD 결제하기</h4>
			<div class="cont">
				<dl class="lst1">
				<dt>상풍명</dt>
				<dd>${selGoodsName }</dd>
				<dt>관람료</dt>
				<dd><fmt:formatNumber value="${price}" type="number"/> 원</dd>
				<dt class="to">결제금액</dt>
				<dd class="to"><fmt:formatNumber value="${price}" type="number"/> 원</dd>
				</dl>
				<strong class="tit2">결제방법</strong>
				<dl class="lst2">
				<dt>결제수단</dt>
				<dd>
					<div class=" select-box">
						<select name="gopaymethod" id="select" class="select-tric">
							<c:if test="${price > 1000}">
					  		<option value="Card">신용카드</option>
					  		</c:if>
							<option value="HPP">휴대폰</option>
						</select>
					</div>
				</dd>
				<dt><label id="buyertel">연락처</label></dt>
				<dd>
					<div class="gIt"><input type="text" id="buyertel" name="buyertel" title="연락처" placeholder="직접입력"></div>
				</dd>
				<dt><label id="buyeremail">이메일</label></dt>
				<dd>
					<div class="gIt"><input type="text" id="buyeremail" name="buyeremail" title="연락처" placeholder="직접입력" value="${user.mailaddr}"></div>
				</dd>
				</dl>
				<ul class="info">
				<li>전자우편과 이동전화번호를 입력받는 것은 고객님의 결제 성공 내역을 E-MAIL 또는 SMS로 알려드리기 위함이오니 반드시 기입하시기 바랍니다.</li>
				<li class="txtPurple">결제된 내용은 취소되지 않으니 유념하시기 바랍니다.</li>
				</ul>
				<div class="mButton1">
					<button class="btn large weighty" type="button" onclick="fncGoPay();">결제하기</button>
				</div>
			</div>
		</div>
	</div>
</form>

<script type="text/javascript">

function fncGoPay(){

	if(isEmpty($("input[name=buyertel]").val())){
		alert("구매자 전화번호가 빠졌습니다. 필수항목입니다.");
		return false;
	}

	if(isEmpty($("input[name=buyeremail]").val())){
		alert("구매자 이메일주소가 빠졌습니다. 필수항목입니다.");
		return false;
	}
	// 정규식 - 이메일 유효성 검사
    var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;

    if(!regEmail.test($("input[name=buyeremail]").val())) {
        alert('이메일 주소가 유효하지 않습니다');
        return false;
    }

	INIStdPay.pay('SendPayForm_id');
}

function isEmpty(val){
	  if(val == null || typeof val == 'undefind' || val.trim().length < 1){
	    return true;
	  }
	  return false;
}
</script>