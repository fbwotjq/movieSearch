<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/login.css">
<div id="contents">
			<div class="breadcrumb">
				<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
			</div>
			<div class="container">
				<div class="top-area">
					<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
					<%@ include file="/WEB-INF/jsp/common/include/common/common02.jsp"%>
				</div>
				<div class="forgetten-p">
					<div class="img"><img src="/resources/images/common/img-retire.png" alt="새로운 비밀번호 이미지"></div>
					<p>회원 탈퇴 시, 모든 정보가 삭제됩니다. <span>회원 탈퇴 후 즉시 재가입 가능합니다.<br> 단, 동일한 아이디로는 재가입이 불가합니다.</span></p>
				</div>
			<form id="form1" name="form1" method="post" >
			<sec:csrfInput/>
					<fieldset class="fieldset">
						<legend>이메일 인증영역</legend>
						<section>
							<div class="area">
								<div class="field">
									<div class="label">
										<label for="">비밀번호 재확인</label>
									</div>
									<div class="insert">
										<div class="box"><input type="password" id="password" name="password" placeholder="비밀번호 재확인"></div>
									</div>
								</div>
								<input class="btn large weighty" type="submit" value="회원탈퇴">
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
		$("#wrap").addClass("confirm-mail");

	    $("#form1").validate({
	    	debug: true,
	    	submitHandler: function(form) {
                formSubmit("form1", "<c:url value='/mypage/out/result'/>");
            }
            ,rules: {
	           password: { required: true }
	        }
            ,messages: {
	           password: { required: "비밀번호를 입력하세요." }
	        }
	    });
	});
</script>