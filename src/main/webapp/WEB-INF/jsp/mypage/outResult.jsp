<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/login.css">

<div id="contents">
	<div class="breadcrumb">
		<ul>
			<li class="ico-home"><a href="<c:out value='/main'/>">홈</a></li>
			<li><a href="<c:out value='/login'/>">로그인</a></li>
			<li class="located"><a href="<c:out value='/mypage/out'/>">회원탈퇴</a></li>
		</ul>
	</div>
	<div class="container">
		<div class="top-area">
			<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
			<%@ include file="/WEB-INF/jsp/common/include/common/common02.jsp"%>
		</div>

		<div class="forgetten-p">
			<img src="/resources/images/common/img-findid.png" alt="아이디 찾기 완료 이미지">
			<p>
				회원 탈퇴 완료
			</p>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		//design
		$("#body").addClass("login");
		$("#wrap").addClass("success-findid");
	});
</script>