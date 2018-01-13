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

<!-- layer -->
<div class="mLayer1">
	<div class="modalBg"></div>
	<div class="layerBg">
		<div class="cont">
			<div class="title">
				<h3>비밀번호 변경</h3>
			</div>
			<div class="mLPw1">
				<div class="title">
					<sec:authentication var="user" property="principal" />
					<strong class="tit">안녕하세요. ${user.name} 고객님!<br> 비밀번호를 변경해주세요.</strong>
					<p class="info"><span class="brForMobile">현재 고객님께서는</span> 오랫동안 비밀번호를 변경하지 않고 사용하고 계십니다.<br> 소중한 개인정보 보호를 위해 비밀번호를 변경 해주세요.</p>
				</div>
				<form id="form1" name="form1" method="post">
					<fieldset>
						<legend>새로운 비밀번호 입력 영역</legend>
						<section>
							<div class="area">
								<div class="area-box">
									<label for="">현재 비밀번호</label>
									<input type="password" id="nowpassword" name="nowpassword"  placeholder="비밀번호 입력">
								</div>
								<div class="area-box">
									<label for="">새 비밀번호</label>
									<input type="password" id="password" name="password"  placeholder="비밀번호 입력">
								</div>
								<p class="info2"><span class="br">8~20자 이내로 영문 대/소문자, 숫자, 특수문자 중 3가지 이상 포함으로</span> 사용가능합니다.</p>
								<div class="area-box">
									<label for="">새 비밀번호 확인</label>
									<input type="password" id="checkPassword" name="checkPassword" placeholder="비밀번호 재입력">
								</div>
								<div class="mButton1">
									<span class="lt"><input class="btn large weighty line" type="button" value="다음에 변경하기" onclick="fncMain();"></span>
									<span class="rt"><input class="btn large weighty" type="button" value="변경하기" onclick="fncChangePass();return false;"></span>
								</div>
								<div class="check">
									<label><input type="checkbox" id="labelCertifyKey" name="labelCertifyKey" onclick="fncMonthCheck();"> <span class="label">앞으로 1개월 동안 이 페이지를 보지 않습니다.</span></label>
								</div>
							</div>
						</section>
					</fieldset>
				</form>
			</div>
			<a href="#" onclick="fncMain();" class="iClose">팝업 닫기</a>
		</div>
	</div>
</div>
<!-- //layer -->
<script type="text/javascript">
	$(document).ready(function() {

		$.validator.addMethod("validPass", function(value, element) {
			var result = fnIsValidPasswd(value, "<c:out value='${user.userid}'/>");
			var arrResult = result.split("|");

			if (arrResult[0] == "1") {
				return true;
			}else {
				$.validator.messages.validPass = arrResult[1];
				return false;
			}
		}, $.validator.messages.validPass);

		$("#form1").validate({
            submitHandler: function(form) {

            	var response = $.fnAjax({params:$("#form1").serialize(), url:"<c:url value='/member/repass/proc'/>", async:false, showMessage:false});
			    if (response.result == "true") {
			    	alert("패스워드가 변경 되었습니다.");
			    	fncMain();
			    }else {
			    	alert("패스워드 변경에 실패하였습니다.");
			    }
                return false;
            }
            ,rules: {
            	nowpassword: { required: true }
               ,password: { required: true, validPass : true }
               ,checkPassword: { required: true, equalTo: "#password" }
            }
            ,messages: {
            	nowpassword: { required: "비밀번호를 입력하세요."}
               ,password: { required: "비밀번호를 입력하세요."}
               ,checkPassword: { required: "비밀번호 확인을 입력하세요.", equalTo : "비밀번호가 일치하지 않습니다." }
            }
		});

	});

	Date.prototype.yyyymmdd = function()
	{
	    var yyyy = this.getFullYear().toString();
	    var mm = (this.getMonth() + 1).toString();
	    var dd = this.getDate().toString();
	    return yyyy + (mm[1] ? mm : '0'+mm[0]) + (dd[1] ? dd : '0'+dd[0]);
	}

	function fncMain(){
		location.href = "/main";
	}

	function fncMonthCheck(){
		var response = $.fnAjax({params:$("#form1").serialize(), url:"<c:url value='/member/repass/delay'/>", async:false, showMessage:false});
	    if (response.result == "true") {
	    	fncMain();
	    }
        return false;
	}

	function fncChangePass(){
		$("#form1").submit();
	}
</script>