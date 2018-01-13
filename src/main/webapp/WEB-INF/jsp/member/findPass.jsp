<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/login.css">

<div id="contents">
	<div class="breadcrumb">
		<ul>
			<li class="ico-home"><a href="<c:url value='/main'/>">홈</a></li>
			<li><a href="<c:url value='/login'/>">로그인</a></li>
			<li class="located"><a href="<c:url value='/member/findPass'/>">비밀번호 찾기</a></li>
		</ul>
	</div>
	<div class="container">
		<div class="container">
			<div class="top-area">
				<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
				<h2>비밀번호 찾기</h2>
			</div>
			<div class="forgetten-p">
				<p>
					비밀번호가 생각나지 않으세요?<span>회원님의 개인정보를 안전하게 되찾으실 수 있도록 도와드리겠습니다.</span><span>비밀번호를 찾으실 수단을 선택해주세요.</span>
				</p>
			</div>
			<div class="confirm">
				<div class="confirm-box">
					<a href="<c:out value='/member/findPass/nice'/>"><span>본인인증</span><span>휴대전화, 범용공인인증서 혹은 아이핀 찾기</span><i class="ico-moveright"></i></a>
				</div>
				<div class="confirm-box">
					<a href="<c:out value='/member/findPass/email'/>"><span>이메일 인증</span><span>가입시 등록하셨던 이메일로 찾기 </span><i class="ico-moveright"></i></a>
				</div>
			</div>
			<%@ include file="/WEB-INF/jsp/common/include/login/info01.jsp"%>
		</div>


	</div>
</div>


<script type="text/javascript">
	$(document).ready(function() {
		//design
		$("#body").addClass("login");
		$("#wrap").addClass("findid");
	});
</script>