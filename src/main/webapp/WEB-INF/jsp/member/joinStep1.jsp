<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/member.css">

<div id="contents">
	<div class="breadcrumb">
		<ul>
			<li class="ico-home"><a href="<c:url value='/main'/>">홈</a></li>
			<li class="located"><a href="<c:url value='/member/join'/>">회원가입</a></li>
		</ul>
	</div>
	<div class="container">
		<div class="top-area">
			<div class="prev-page">
				<a href="<c:url value='/member/join'/>"><i class="ico-prev"></i><span>이전</span></a>
			</div>
			<h2>회원가입</h2>
		</div>
		<div class="regi-menu">
			<ul>
				<li class="selected"><a href="javascript:void(0);"><span>Step1</span><span>본인인증</span></a></li>
				<li><a href="javascript:void(0);"><span>Step2</span><span>약관동의</span></a></li>
				<li><a href="javascript:void(0);"><span>Step3</span><span>정보입력</span></a></li>
				<li><a href="javascript:void(0);"><span>Step4</span><span>가입완료</span></a></li>
			</ul>
		</div>
		<div class="choose-txt">
			<p>
				고객님께서 원하시는 본인인증방법을 선택해 주세요. <span>보호자의 휴대폰 및 I-PIN인증을 통해 회원가입 동의하는 단계입니다. 회원의 주요 정보는 암호화되어 처리가 되며, 본인인증으로 사용하는 정보는 데이터베이스에 저장/보관하지 않습니다.</span>
			</p>
		</div>
		<form id="niceForm" name="niceForm" method="post">
            <sec:csrfInput/>
            <input type="hidden" id="param_r1" name="param_r1" value="" />
            <input type="hidden" id="param_r2" name="param_r2" value="" />
            <input type="hidden" id="param_r3" name="param_r3" value="" />

			<fieldset>
				<legend>인증 선택 영역</legend>
				<c:if test="${joinMemberVo.joinType eq 'under14' }">
					<div class="parents-agree">
						<div class="area">
							<div class="box-fold-list">
								<div class="accordion-wrap on">
									<div class="accordion-header">
										<a href="javascript:void(0);" class="accordion-title collapse-handle"><span>어린이/학생(14세 미만)회원 법정 대리인 확인<span class="em weighty">(필수)</span></span> <i class="ico-handle"></i></a>
										<div class="agree-box">
											<label><input type="checkbox" name="" id=""> <span class="label">법정대리임을 확인합니다.</span></label>
										</div>
									</div>
									<div class="accordion-content">
										<ul>
											<li>※한국영상자료원에서는 12세 미만 사용자의 경우 부모님의 동의하에 또는 부모님과 함께 회원가입하나 사용하도록 권장하고 있습니다.</li>
											<li>※따라서 14세 미만의 사용자가 회원가입을 할 경우 부모님 동의 인증을 받고자 안심본인인증 또는 공공 I-PIN을 통해 인증을 받고 있습니다.</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:if>

				<div class="confirm">
					<div class="confirm-box">
						<a href="javascript:fnCheckPerson();"><span>안심본인인증</span><span>본인명의 휴대전화, 범용공인인증서로 본인인증</span><i class="ico-moveright"></i></a>
					</div>
					<div class="confirm-box">
						<a href="javascript:fnCheckIpin();"><span>공공 I-PIN 인증</span><span>인터넷 상에서 신분 확인을 할 수 있는 식별</span><span> 번호로 본인인증</span><i class="ico-moveright"></i></a>
					</div>
				</div>
				<section id="accordion">
					<div class="area">
						<ul class="line-fold-list">
							<li class="accordion-wrap">
								<div class="accordion-header">
									<a href="javascript:void(0);" class="accordion-title collapse-handle"><span>안심본인인증으로 인증실패 메세지가 뜬다면?</span> <i class="ico-handle"></i></a>
								</div>
								<div class="accordion-content">
									<ul class="infoarea">
										<li><span>휴대폰본인확인실패</span>
											<p>본인명의 휴대폰번호와 생년월일 정보가 정확하게 입력되지 않은 경우 인증이 되지 않으므로 입력정보를 다시 한번 확인하여 주십시오.</p></li>
										<li><span>공인인증서인증실패</span>
											<p>보인확인시 공인인증기관에서 발급한 범용공인인증서를 통해서만 인증이가능하며 범용인증서 여부와 인증서 유효기간 등을 확인하여 주십시오.</p></li>
										<li><span>공통사항</span>
											<p>
												정확한 정보를 입력한 후에도 인증에 실패하는 경우 사이트에 시스템 및 통신에러가 발생하여 브라우저 또는 통신상의 일시적인 장애 현상이 나타날 수 있으므로 잠시 후 재시도 해주시고 문제가해결되지 않으면 NICE 고객센터 <span class="em weighty">(1600-1522)</span> 로 문의하여 주십시오.
											</p></li>
									</ul>
								</div>
							</li>
							<li class="accordion-wrap">
								<div class="accordion-header">
									<a href="javascript:void(0);" class="accordion-title collapse-handle"><span>공공아이핀에 대해 궁금하시다면?</span> <i class="ico-handle"></i></a>
								</div>
								<div class="accordion-content">
									아이핀이란 인터넷 상에서 주민번호를 대신하여 아이디와 패스워드를 이용하여 본인확인을 하는 수단입니다. 보다 상세한 내용 및 가입을 원하시는 분은 <a href="www.g-pin.go.kr" class="em weighty">www.g-pin.go.kr</a>를 통해 확인하실 수 있습니다.
								</div>
							</li>
						</ul>
					</div>
				</section>
			</fieldset>
		</form>
	</div>
</div>

<form id="form2" name="form2" method="post">
    <sec:csrfInput/>
    <input type="hidden" id="userName" name="userName" />
    <input type="hidden" id="dupInfo" name="dupInfo" />
    <input type="hidden" id="birthDate" name="birthDate" />
    <input type="hidden" id="sexCode" name="sexCode" />
</form>

<script type="text/javascript" src="<c:url value='/resources/js/nice.js'/>"></script>

<script type="text/javascript">
    window.name = "CertificationWindow";

	$(document).ready(function() {
		//design
		$("#body").addClass("login");
		//$("#wrap").addClass("findid");
	});

    /* 개인인증 callback */
    function callbackCheckPersonResult(pParamJsonStr) {
        var paramJson = JSON.parse(pParamJsonStr);

        $("#userName").val(paramJson.userName);
        $("#dupInfo").val(paramJson.dupInfo);
        $("#birthDate").val(paramJson.birthDate);
        $("#sexCode").val(paramJson.sexCode);

        formSubmit("form2", "<c:url value='/member/join/step2'/>");
    }

    /* ipin callback */
    function callbackCheckIpinResult(pParamJsonStr) {
        var paramJson = JSON.parse(pParamJsonStr);

        $("#userName").val(paramJson.userName);
        $("#dupInfo").val(paramJson.dupInfo);
        $("#birthDate").val(paramJson.birthDate);
        $("#sexCode").val(paramJson.sexCode);

        formSubmit("form2", "<c:url value='/member/join/step2'/>");
    }
</script>