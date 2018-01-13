<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sec:authorize access="isAnonymous()">
	<script>location.href = "/";</script>
</sec:authorize>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/login.css">

<div id="contents">
	<div class="breadcrumb">
		<ul>
			<li class="ico-home"><a href="#">홈</a></li>
			<li class="located"><a href="#">로그인</a></li>
		</ul>
	</div>
	<div class="container">
		<div class="top-area">
			<h2>로그인</h2>
		</div>
			<fieldset>
				<legend>로그인 영역</legend>
				<section class="form-login">
					<div class="area">
						<div class="area-box">
							<input type="text" id="bt_keywordremove1" placeholder="아이디">
							<!-- (개발요소)입력창에 텍스트 입력시 삭제버튼 노출됩니다. -->
							<button type="button" class="btn-del" id="bt_keywordremove1" title="입력 삭제"><span class="ico-del">입력 삭제</span></button>
						</div>
						<div class="area-box">
							<input type="password" id="bt_keywordremove2" placeholder="비밀번호">
							<!-- (개발요소)입력창에 텍스트 입력시 삭제버튼 노출됩니다. -->
							<button type="button" class="btn-del" id="bt_keywordremove2" title="입력 삭제"><span class="ico-del">입력 삭제</span></button>
						</div>
						<button class="btn large weightiest" type="submit"><span>로그인</span></button>
					</div>
					<ul class="finding-list">
						<li><a href="#">아이디 찾기</a></li>
						<li class="dots"><a href="#">비밀번호 찾기</a></li>
						<li class="dots"><a href="#">회원가입</a></li>
					</ul>
				</section>
			</fieldset>
	</div>
</div>
<div class="mLayer1">
		<div class="modalBg"></div>
		<div class="layerBg">
			<div class="cont">
				<div class="title">
				<c:choose>
					<c:when test="${active eq 'Y' }">
						<h3>휴면 계정 활성화</h3>
					</c:when>
					<c:otherwise>
						<h3>회원갱신</h3>
					</c:otherwise>
				</c:choose>
				</div>
				<div class="mLPw1">
					<div class="title">
						<strong class="tit">고객님, 한국영상자료원을<br> 계속 이용하시겠습니까?</strong>
						<p class="info">개인정보의 보유 및 이용기간에 관한 법률에 따라<br> 회원정보보유 동의를 2년마다 받고 있습니다.</p>
					</div>
					<form id="form1" name="form1" method="post">
					<input type="hidden" name="active" id="active" value="${active}"/>
					<div class="con">
						<div class="scroll mCustomScrollbar">
							<div class="term-content" data-mcs-theme="dark">
								<strong>개인정보의 보유 및 이용기간에 관한 법률</strong><br>
								<ul>
								<li><span class="ico">가.</span> 홈페이지 회원 가입 및 관리 : 2년</li>
								<li>
									<span class="ico">나.</span> 다만, 전자상거래에서의 소비자보호에 관한 법률 타 법률에 의해 보존할 필요가 있는 경우에는 일정기간 보존 합니다.<br>
									<div class="ls"><span class="ico">-</span> 보존 근거 : 전자상거래 등에서의 소비자 보호에 관한</div>
								</li>
								<li><span class="ico">가.</span> 홈페이지 회원 가입 및 관리 : 2년</li>
								<li>
									<span class="ico">나.</span> 다만, 전자상거래에서의 소비자보호에 관한 법률 타 법률에 의해 보존할 필요가 있는 경우에는 일정기간 보존 합니다.<br>
									<div class="ls"><span class="ico">-</span> 보존 근거 : 전자상거래 등에서의 소비자 보호에 관한</div>
								</li>
								<li><span class="ico">가.</span> 홈페이지 회원 가입 및 관리 : 2년</li>
								<li>
									<span class="ico">나.</span> 다만, 전자상거래에서의 소비자보호에 관한 법률 타 법률에 의해 보존할 필요가 있는 경우에는 일정기간 보존 합니다.<br>
									<div class="ls"><span class="ico">-</span> 보존 근거 : 전자상거래 등에서의 소비자 보호에 관한</div>
								</li>
								</ul>
							</div>
						</div>

						<div class="info4">
							상기한 바와 같이 개인정보 보유및 이용기간에 따른 법률에 따라 회원정보보유에 동의 후 확인 버튼을 누르시면 회원가입이 연장됩니다.
							<span class="ts"><span class="br">위 내용에 동의하지않으시면 자동으로 회원탈퇴가 진행됩니다.</span> <span class="br">안내 이메일을 받지못하시거나 별도의 의사표시가 없을 경우</span> 휴면계정으로 전환되고, 개인정보는 5년간 보존됩니다.<br> 위와같은 내용에 동의하십니까?</span>
						</div>
						<div class="agree">
							<label><input type="radio"  id="keyRenew1" name="keyRenew" value="01" checked="checked"> <span class="label">동의합니다.</span></label>
							<label><input type="radio"  id="keyRenew2" name="keyRenew" value="99"> <span class="label">동의하지 않습니다.</span></label>
						</div>
						<div class="mButton1">
							<input class="btn xlarge weighty block" type="button" value="확인" onclick="fncRenew();">
						</div>
						<p class="info3">확인 버튼 클릭 시 정보 복원이 완료 됩니다.</p>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
<!-- layer -->
<!-- //layer -->
<script type="text/javascript">

	var typeText = "회원정보 갱신";

	$(document).ready(function() {
		if($("#active").val() == "Y"){
			typeText = "휴면 계정 활성화";
		}
	});

	function fncRenew(){

		if($('input[name=keyRenew]:checked').val() == null){
			alert(typeText+" 동의 여부를 선택하세요.");
			return false;
		}

		if(!$("#keyRenew1")[0].checked){
			if (!confirm(typeText+"에 동의하지 않으시면 탈퇴 처리됩니다.")) return false;
		}else{
			if (!confirm(typeText+"을 하시겠습니까?")) return false;
		}

		var response = $.fnAjax({params:$("#form1").serialize(), url:"<c:url value='/member/renew/proc'/>", async:false, showMessage:false});
	    if (response.result == "true") {
	    	alert(typeText+" 되었습니다.");
	    	fncMain();
	    }else {
	    	alert(typeText+"에 실패하였습니다.");
	    }
	}

	function fncMain(){
		location.href = "/main";
	}


</script>