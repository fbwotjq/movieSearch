<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/login.css">

<sec:authorize access="isAuthenticated()">
<script>fnHistoryBack();</script>
</sec:authorize>

<sec:authorize access="isAnonymous()">
<div id="contents">
	<div class="breadcrumb">
		<ul>
			<li class="ico-home"><a href="<c:url value='/main'/>">홈</a></li>
			<li class="located"><a href="<c:url value='/login'/>">로그인</a></li>
		</ul>
	</div>
	<div class="container">
		<div class="top-area">
			<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
			<h2>로그인</h2>
		</div>
		<form id="form1" name="form1" method="post" action="/doLogin">
		    <sec:csrfInput/>
			<input type="hidden" name="returnUrl" value="${param.returnUrl}"/>
			<fieldset>
				<legend>로그인 영역</legend>
				<section class="form-login">
					<div class="area">
						<div class="area-box">
							<input type="text" id="username" name="username" placeholder="아이디" value="tipgiveme">
							<!-- (개발요소)입력창에 텍스트 입력시 삭제버튼 노출됩니다. -->
							<!-- <button type="button" class="btn-del" id="bt_keywordremove" title="입력 삭제"><span class="ico-del">입력 삭제</span></button> -->
						</div>
						<div class="area-box">
							<input type="password" id="password" name="password" placeholder="비밀번호" value="1234">
							<!-- (개발요소)입력창에 텍스트 입력시 삭제버튼 노출됩니다. -->
							<!-- <button type="button" class="btn-del" id="bt_keywordremove" title="입력 삭제"><span class="ico-del">입력 삭제</span></button> -->
						</div>
						<input type="submit" class="btn large weightiest" value="로그인" />
					</div>
					<ul class="finding-list">
						<li><a href="${userIdUrl}">아이디 찾기</a></li>
						<li class="dots"><a href="${userPwUrl}">비밀번호 찾기</a></li>
						<li class="dots"><a href="${userJoinUrl}">회원가입</a></li>
					</ul>
				</section>
			</fieldset>
		</form>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function() {
		//design
		$("#body").addClass("login");

	    $("#form1").validate({
            rules: {
	        	username: { required: true }
	           ,password: { required: true }
	        }
            ,messages: {
	        	username: { required: "아이디를를 입력하세요." }
	           ,password: { required: "비밀번호를 입력하세요." }
	        }
	    });
	});
</script>

</sec:authorize>