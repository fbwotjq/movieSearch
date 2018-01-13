<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<header id="header" class="sticky-header-wrapper">
	<div class="header-global-row">
		<a href="javascript:void(0);" class="block menu-block">
			<span class="toggler menu-toggler">
				<span class="bar bar-1"></span>
				<span class="bar bar-2"></span>
				<span class="bar bar-3"></span>
				<span class="label">menu</span>
				<i class="icon icon-header-menu"></i>
			</span>
		</a>
		<div class="block">
			<div class="logo" id="logo">
				<a href="/" class="">
					<strong>KMDb</strong>
					<span>한국영화데이터베이스</span>
				</a>
			</div>
		</div>
		<a href="#headerSearch" class="block search-block">
			<span class="toggler search-toggler">
				<span class="label">Search</span>
				<i class="icon icon-header-search"></i>
			</span>
		</a>
		<a href="/eng/main" class="block lang-block">
			<span class="toggler lang-toggler">
				<span class="label">ENG</span>
				<i class="icon icon-header-search"></i>
			</span>
		</a>
		<div class="block util-block">
			<ul>
				<sec:authorize access="isAnonymous()">
				<li><a href="javascript:location.href='/login';">로그인</a></li>
				<li><a href="${userJoinUrl}">회원가입</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
				<form id="logoutForm" action="${pageContext.request.contextPath}/doLogout" method="post" style="display:none">
				    <sec:csrfInput />
				</form>
				<li><a href="javascript:$('#logoutForm').submit();">로그아웃</a></li>
				<!-- <li><a href="javascript:alert('회원가입을 위해서는 로그아웃을 하셔야합니다.');">회원가입</a></li> -->
				</sec:authorize>
				<li><a href="/care/kmdb">고객서비스</a></li>
				<li><a href="/eng/main">ENG</a></li>
			</ul>
			<a href="javascript:void(0);" class="btn setting bt__mainset">설정</a>
		</div>
	</div>
	<div id="headerSearch" class="header-search">
		<form>
			<div class="input-wrapper">
				<label for="headerDesktopInput" class="blind">통합검색</label>
				<input type="search" name="" id="headerDesktopInput">
				<button type="submit" class="btn btn-search">검색</button>
			</div>
		</form>
	</div>
</header>