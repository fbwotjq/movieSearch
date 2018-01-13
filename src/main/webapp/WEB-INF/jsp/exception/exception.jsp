<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko" xml:lang="ko">
<head>
<meta name="generator" content="ONEWARE">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, width=device-width">
<meta name="format-detection" content="telephone=no">
<meta name="robots" content="noindex, nofollow" />
<title>KMDb - 한국영화데이터베이스</title>
<link href="https://fonts.googleapis.com/css?family=Oswald:400,500,600" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
<link rel="stylesheet" type="text/css" href="/resources/css/vendors/uniform.default.css">
<link rel="stylesheet" type="text/css" href="/resources/css/vendors/selectric.css">
<link rel="stylesheet" type="text/css" href="/resources/plugins/owlslide/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="/resources/plugins/owlslide/owl.theme.default.css">
<script type="text/javascript" src="/resources/js/lib/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/resources/plugins/owlslide/owl.carousel.js"></script>
<script type="text/javascript" src="/resources/plugins/owlslide/owl.carousel2.thumbs.js"></script>
<script type="text/javascript" src="/resources/plugins/jquery.selectric-1.11.1/jquery.selectric.min.js"></script>
<script type="text/javascript" src="/resources/plugins/jquery.uniform-2.2.0/jquery.uniform.min.js"></script>
<script type="text/javascript" src="/resources/js/common.js"></script>
<script type="text/javascript" src="/resources/js/mypage.js"></script> <!-- js for mypage page -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/etc.css">

</head>
<body>

	<!-- module -->
	<div class="mError">
		<div class="con">
			<h1 onclick="location.href='/main'">KMDb</h1>
			<h2>ERROR</h2>
			<p class="tit">서비스가 원활하지 않습니다.</p>
			<p class="txt">
				<!-- forPc -->
				<span class="forPc">
					불편을 드려 죄송합니다. 요청하신 서비스가 정상 처리되지 않았습니다.<br>
					보다 정확한 편리한 서비스를 제공할 수 있도록 최선을 다하겠습니다. 감사합니다.
				</span>
				<!-- //forPc -->
				<!-- forMobile -->
				<span class="forMobile">
					불편을 드려 죄송합니다. 요청하신 서비스가 정상 처리되지<br>
					않았습니다. 보다 정확한 편리한 서비스를 제공할 수 있도록<br>
					최선을 다하겠습니다. 감사합니다.
				</span>
				<!-- //forMobile -->
				<span class="txtPurple">
					<span class="brForMobile">※ 기타 문의 사항은 kmdb@koreafilm.or.kr로</span>
					보내주시기 바랍니다.
				</span>
			</p>
		</div>
	</div>
	<!-- //module -->

</body>
</html>
