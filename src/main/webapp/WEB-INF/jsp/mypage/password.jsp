<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/login.css">

<div id="contents">
	<div class="breadcrumb">
		<ul>
			<li class="ico-home"><a href="<c:out value='/main'/>">홈</a></li>
			<li><a href="<c:out value='/login'/>">로그인</a></li>
			<li class="located"><a href="<c:out value='/mypage/info/password'/>">비밀번호 변경하기</a></li>
		</ul>
	</div>
	<div class="container">
		<div class="top-area">
			<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
			<h2>비밀번호 변경하기</h2>
		</div>

		<div class="forgetten-p">
			<img src="/resources/images/common/img-findpw.png" alt="새로운 비밀번호 이미지">
			<p>
				새로운 비밀번호를 입력해주세요.<span>안전을 위해 비밀번호를 변경해주세요.</span>
			</p>
		</div>
		<form id="form1" name="form1" method="post">
		    <sec:csrfInput/>
			<fieldset>
				<legend>새로운 비밀번호 입력 영역</legend>
				<section>
					<div class="area">
						<div class="area-box">
							<label for="password">비밀번호</label> <input type="password" id="password" name="password" placeholder="비밀번호 입력">
						</div>
						<p class="pwreset-info">※8~20자 이내로 영문 대/소문자, 숫자, 특수문자 중 3가지 이상 포함으로 사용가능합니다.</p>
						<div class="area-box">
							<label for="checkPassword">비밀번호 확인</label> <input type="password" id="checkPassword" name="checkPassword" placeholder="비밀번호 재입력">
						</div>
						<input type="submit" class="btn large weighty" value="확인">
					</div>
				</section>
			</fieldset>
		</form>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		//design
		$("#body").addClass("login");
		$("#wrap").addClass("confirm-mail reset-findpw");

		$.validator.addMethod("validPass", function(value, element) {
			var result = fnIsValidPasswd(value, "<c:out value='${userId}'/>");
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
                formSubmit("form1", "<c:url value='/mypage/info/password/result'/>");
            }
            ,rules: {
            	password: { required: true, validPass : true }
               ,checkPassword: { required: true, equalTo: "#password" }
            }
            ,messages: {
            	password: { required: "비밀번호를 입력하세요."}
               ,checkPassword: { required: "비밀번호 확인을 입력하세요.", equalTo : "비밀번호가 일치하지 않습니다." }
            }
		});
	});
</script>