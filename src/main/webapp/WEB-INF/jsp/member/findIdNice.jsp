<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/login.css">

<div id="contents">
	<div class="breadcrumb">
		<ul>
			<li class="ico-home"><a href="<c:url value='/main'/>">홈</a></li>
			<li><a href="<c:url value='/login'/>">로그인</a></li>
			<li class="located"><a href="<c:url value='/member/findId'/>">아이디 찾기</a></li>
		</ul>
	</div>
	<div class="container">
		<div class="top-area">
			<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
			<h2>아이디 찾기</h2>
		</div>
		<div class="forgetten-p">
			<p>
				본인인증<span>휴대전화, 범용공인인증서 혹은 나이스 아이핀으로 찾기</span>
			</p>
		</div>
		<form id="niceForm" name="niceForm" method="post">
		    <sec:csrfInput/>
			<input type="hidden" id="param_r1" name="param_r1" value="findId" />
			<input type="hidden" id="param_r2" name="param_r2" value="" />
			<input type="hidden" id="param_r3" name="param_r3" value="" />

			<fieldset>
				<legend>인증 선택 영역</legend>
				<div class="confirm">
					<div class="confirm-box">
						<a href="javascript:fnCheckPerson();"><span>안심본인인증</span><span>본인명의 휴대전화, 범용공인인증서로 본인인증</span><i class="ico-moveright"></i></a>
					</div>
					<div class="confirm-box">
						<a href="javascript:fnCheckIpin();"><span>공공 I-PIN 인증</span><span>인터넷 상에서 신분 확인을 할 수 있는 식별</span><span> 번호로 본인인증</span><i class="ico-moveright"></i></a>
					</div>
					<div class="confirm-box confirm-box-info">
						<ul>
							<li class="bullet-dot">휴대폰 명의 정보로 본인임을 확인합니다. 휴대폰이 본인 명의가 아닌 경우 아이핀을 선택해 주세요.</li>
							<li class="bullet-dot">입력하신 정보는 본인확인을 위해 NICE에 제공되며, 본인확인 용도 외에 사용되거나 저장되지 않습니다.</li>
							<li class="bullet-dot">아이핀(I-Pin)은 인터넷 상에서 주민등록번호를 대신하여 본인임을 확인 받을 수 있는 인터넷 상의 개인식별번입니다.</li>
							<li class="bullet-dot">아이핀으로 인증시 가입하신 아이디를 확인하실 수 있습니다.</li>
							<li class="bullet-dot">입력하신 정보는 본인확인을 위해 NICE에 제공되며, 본인 확인 용도 외에 사용되거나 저장되지 않습니다.</li>
						</ul>
					</div>
				</div>
			</fieldset>
		</form>

		<form id="form2" name="form2" method="post">
		    <sec:csrfInput/>
			<input type="hidden" id="findType" name="findType" value="PERSON" />
			<input type="hidden" id="userName" name="userName" />
			<input type="hidden" id="dupInfo" name="dupInfo" />
		</form>

		<%@ include file="/WEB-INF/jsp/common/include/login/info01.jsp"%>
	</div>
</div>

<script type="text/javascript" src="<c:url value='/resources/js/nice.js'/>"></script>

<script type="text/javascript">
    window.name = "CertificationWindow";

	$(document).ready(function() {
		//design
		$("#body").addClass("login");
		$("#wrap").addClass("confirm-personal");
	});

	/* 개인인증 callback */
	function callbackCheckPersonResult(pParamJsonStr) {
		var paramJson = JSON.parse(pParamJsonStr);

		$("#userName").val(paramJson.userName);
		$("#dupInfo").val(paramJson.dupInfo);

		formSubmit("form2", "<c:url value='/member/findId/result'/>");
	}

	/* ipin callback */
	function callbackCheckIpinResult(pParamJsonStr) {
		var paramJson = JSON.parse(pParamJsonStr);

		$("#userName").val(paramJson.userName);
		$("#dupInfo").val(paramJson.dupInfo);

		formSubmit("form2", "<c:url value='/member/findId/result'/>");
	}
</script>