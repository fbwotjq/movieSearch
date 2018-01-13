<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/login.css">

<div id="contents">
	<div class="breadcrumb">
		<ul>
			<li class="ico-home"><a href="<c:out value='/main'/>">홈</a></li>
			<li><a href="<c:out value='/login'/>">로그인</a></li>
			<li class="located"><a href="<c:out value='/member/findId'/>">아이디 찾기</a></li>
		</ul>
	</div>
	<div class="container">
		<div class="top-area">
			<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
			<h2>아이디 찾기</h2>
		</div>

		<c:choose>
			<c:when test="${findId ne null }">
				<div class="forgetten-p">
					<img src="/resources/images/common/img-findid.png" alt="아이디 찾기 완료 이미지">
					<p>
						아이디 찾기 완료<span>아이디 찾기 본인인증에 성공하셨습니다.</span><span>입력하신 정보와 일치하는 아이디 목록입니다.</span>
					</p>
				</div>
				<form>
					<fieldset>
						<legend>아이디 찾기 완료 영역</legend>
						<section>
							<div class="area">
								<div class="area-box">
									<label for="" class="blind">찾은 아이디</label> <input type="text" readonly value="${findId }">
								</div>
							</div>
						</section>
					</fieldset>
				</form>
			</c:when>
			<c:otherwise>
				<fieldset>
					<legend>아이디 찾기 실패 영역</legend>
					<section>
						<div class="forgetten-p noresult">
							<p>
								일치하는 정보가 없습니다.<br>
								<span>다시 한번 정확히 입력해 주시거나</span> <span>다른 찾기 방법으로 진행해주세요.</span>
							</p>
						</div>
						<%@ include file="/WEB-INF/jsp/common/include/login/info01.jsp"%>
					</section>
				</fieldset>
			</c:otherwise>
		</c:choose>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function() {
		//design
		$("#body").addClass("login");
		$("#wrap").addClass("success-findid");
	});
</script>