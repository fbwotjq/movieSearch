<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/login.css">

<sec:authentication property="principal.name" var="name"/>

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
					<p><span class="tit">${name }님!</span> <span><em class="brForMobile">회원님의 개인정보 보호를 위해</em> 비밀번호를 한번 더 입력해주세요.</span></p>
				</div>

				<form id="form1" name="form1" method="post" >
				<sec:csrfInput/>
					<fieldset class="fieldset">
						<legend>이메일 인증영역</legend>
						<section>
							<div class="area">
								<div class="field">
									<div class="label">
										<label for="">현재 비밀번호</label>
									</div>
									<div class="insert">
										<div class="box"><input type="password" id="password" name="password" placeholder="비밀번호입력"></div>
									</div>
									<!-- <span class="em warning comment-line">정확한 비밀번호를 입력해주세요.</span> -->
								</div>
								<input class="btn large weighty" type="submit" value="확인">
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
                formSubmit("form1", "<c:url value='/mypage/info'/>");
            }
            ,rules: {
	           password: { required: true }
	        }
            ,messages: {
	           password: { required: "정확한 비밀번호를 입력하세요." }
	        }
	    });
	});
</script>