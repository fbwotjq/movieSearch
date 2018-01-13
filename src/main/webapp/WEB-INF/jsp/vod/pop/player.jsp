<%@page import="egovframework.ag.common.util.StringUtils"%>
<%@page import="egovframework.ag.common.util.SessionUtil"%>
<%@ page import="egovframework.ag.common.Constant" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko" xml:lang="ko">
<head>
<sec:csrfMetaTags/>
<meta name="generator" content="ONEWARE">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, width=device-width">
<meta name="format-detection" content="telephone=no">
<meta name="robots" content="noindex, nofollow" />
<title>KMDb - 한국영화데이터베이스</title>
<link href="https://fonts.googleapis.com/css?family=Oswald:400,500,600" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/vod/player/video-js.css">
<link rel="stylesheet" type="text/css" href="/resources/vod/player/video-speed.css">
<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
<link rel="stylesheet" type="text/css" href="/resources/css/vendors/uniform.default.css">
<link rel="stylesheet" type="text/css" href="/resources/css/vendors/selectric.css">
<link rel="stylesheet" type="text/css" href="/resources/plugins/owlslide/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="/resources/plugins/owlslide/owl.theme.default.css">
<script type="text/javascript" src="/resources/js/lib/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="http://210.124.107.9/html5/video/swfobject.js"></script>
<script type="text/javascript" src="http://210.124.107.9/html5/video/video.js"></script>
<script type="text/javascript" src="http://210.124.107.9/html5/video/video-speed.js"></script>
<script type="text/javascript" src="http://210.124.107.9/html5/video/videoHandlers.js"></script>
<script id="i5dynamic"></script>
<script type="text/javascript" src="/resources/plugins/owlslide/owl.carousel.js"></script>
<script type="text/javascript" src="/resources/plugins/owlslide/owl.carousel2.thumbs.js"></script>
<script type="text/javascript" src="/resources/plugins/jquery.selectric-1.11.1/jquery.selectric.min.js"></script>
<script type="text/javascript" src="/resources/plugins/jquery.uniform-2.2.0/jquery.uniform.min.js"></script>
<script type="text/javascript" src="/resources/js/common.js"></script>
<script type="text/javascript" src="/resources/js/db.js"></script>
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">

</head>
<body class="hiddenWrap"> <!-- 팝업이 떠 있을 경우 id="wrap" 를 hidden 시켜줍니다. -->
	<!-- 스킵 네비게이션(s) -->
	<div id="skipNavigation">
	</div>
	<!--// 스킵 네비게이션(e) -->
	<div id="wrap">
		<!-- #header -->
		<div id="headerWrap" class="sticky-header">
			<header id="header" class="sticky-header-wrapper">
				<div class="header-global-row">
					<div class="block">
						<div class="logo" id="logo">
							<a href="/" class="">
								<strong>KMDb</strong>
							</a>
						</div>
					</div>
				</div>
			</header>
			<div class="main-navigation">
				<div class="main-navigation-wrap">
				</div>
			</div>
			<div class="main-navigation-cover"></div>
		</div>
		<div class="header-spacer"></div>
		<!-- //#header -->
		<div id="contents">
			<div class="breadcrumb">
			</div>
			<div class="container">
				<div class="top-area pb1">
				</div>
					<section id="fieldset">
					</section>

			</div>
		</div>
		<footer id="footer">

		</footer>
		<div class="btntop">
			<button type="button" id="TopMove" title="상단으로"><span class="ico_totop">상단으로</span></button>
		</div>
	</div>


	<!-- layer -->
	<div class="mLayer1">
		<div class="modalBg"></div>
		<div class="layerBg">
			<div class="cont top">
				<div class="title">
					<h3><c:out value="${result.mulTitle}"/></h3>
				</div>
			</div>

			<!-- movie -->
			<div class="mDMovie1">
				<div class="movie1Bg">
				<a href="###">
					<span><div id="playercontent"></div></span>
				</a>
				</div>
			</div>
			<!-- //movie -->

			<div class="cont">
				<!-- list -->
				<div class="mTitle5">
					<strong class="tit"><c:out value="${result.info.mulTitle}"/> : <c:out value="${result.info.titleSub}"/>[<c:out value="${result.info.titleEtc}"/>]</strong>
					<span class="gRt">관리번호: <c:out value="${result.info.fileNo}"/></span>
				</div>
				<div class="mList13">
					<ul>
					<li class="col2">
						<span class="tit">상영구분</span>
						<span class="txt"><c:out value="${result.info.mscreenClssNm}"/></span>
					</li>
					<li class="col2">
						<span class="tit">관람기준</span>
						<span class="txt"><c:out value="${result.info.levelClssNm}"/></span>
					</li>
					<li class="col2">
						<span class="tit">언어</span>
						<span class="txt"><c:out value="${result.info.language}"/></span>
					</li>
					<li class="col2">
						<span class="tit">상영시간</span>
						<span class="txt"><c:out value="${result.info.runtime}"/></span>
					</li>
					<li class="col2">
						<span class="tit">색채</span>
						<span class="txt"><c:out value="${result.info.colorClssNm}"/></span>
					</li>
					<li class="col2">
						<span class="tit">내용</span>
						<span class="txt"><c:out value="${result.info.plot}"/></span>
					</li>
					<li class="clear">
						<span class="tit">프레임 크기</span>
						<span class="txt"><c:out value="${result.info.hSize}"/> X <c:out value="${result.info.vSize}"/></span>
					</li>
					</ul>
				</div>
				<!-- //list -->
			</div>
		</div>
	</div>
	<!-- //layer -->
<script type="text/javascript">

        var client_type = client_brw_check();
        var surl;
        var check_yn_ = "${result.resultYn}";
        var fno = "${result.fno}";
        var resultMsg = "${result.resultMsg}";
        var movieId = "${result.movieId}";
        var movieSeq = "${result.movieSeq}";
        var userId = "${result.userId}";


        function anPlay(){
           var video = document.getElementById('video');
            video.addEventListener('click',function(){  video.play(); video.webkitEnterFullScreen();},false);
            video.play();
    		video.webkitEnterFullScreen();
    	}

        var userParam = "";
        if(userId != ""){
        	userParam = "&saveid="+userId;
        }

        if(check_yn_ == "Y"){

            surl = "http://210.124.107.9/html5/stream.php?fno="+fno+"&mode="+client_type+"&scr="+mobile_width+"x"+mobile_height+"&vsize_x=720&vsize_y=405"+userParam;

            i5dynamic.src = surl;

        	$.ajax({
        	    url: "<c:url value='/vod/player/count'/>",
        		type: 'POST',
        		beforeSend : function(xhr) {
        			var token = $("meta[name='_csrf']").attr("content");
        			var header = $("meta[name='_csrf_header']").attr("content");
        			xhr.setRequestHeader(header, token);
        		},
        		data: {"movieId" : movieId, "movieSeq" : movieSeq, "userId" : userId},
        		success: function(data) {

                }
        	});


        }else{
        	alert(resultMsg);
        	window.close();
        }

      </script>
</body>
</html>