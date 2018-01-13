<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<!-- SELECT MUL_ID,FILE_ID,MOVIE_ID,MOVIE_SEQ,VER_TITLE ,ADJUST_DATE , TYPE_CLSS ,DIRECTOR, KEYWORDS ,PROD_YEAR ,RUNTIME,MSCREEN_CLSS,TITLE_ETC,PRICE,MUL_TITLE,MULTOR_NM,ROW_NUM
	FROM
	(SELECT MUL_ID,FILE_ID,MOVIE_ID,MOVIE_SEQ,VER_TITLE ,ADJUST_DATE , TYPE_CLSS ,DIRECTOR, KEYWORDS ,PROD_YEAR ,RUNTIME,MSCREEN_CLSS,TITLE_ETC,PRICE,MUL_TITLE,MULTOR_NM,ROWNUM AS ROW_NUM
		FROM
		(SELECT A.MUL_ID,A.FILE_ID,C.MOVIE_ID,C.MOVIE_SEQ, A.VER_TITLE ,A.ADJUST_DATE , A.PRICE, A.MULTOR_NM,
		C.TYPE_CLSS ,C.DIRECTOR, C.KEYWORDS , C.PROD_YEAR ,
		B.RUNTIME,B.MSCREEN_CLSS,B.TITLE_ETC, B.MUL_TITLE
		FROM MULTI_FILE A ,MULTI_NEW B , V_MOVIE_MUL_DETAIL C
		WHERE 1=1
		AND A.MUL_ID= B.MUL_ID
		AND B.MUL_ID= C.MUL_ID
		AND A.USE_CLSS='6'
		AND A.OPEN_YN='Y'
		AND A.F_SIZE>0
		AND MSCREEN_CLSS='2'
		AND B.TITLE_ETC='본편'
		AND (
		PATTEN_CLSS NOT IN ('2','17','24')
		OR PATTEN_CLSS IN ('2','13','17','24')
		)
		AND C.MOVIE_ID='' --NATION
		AND C.MOVIE_SEQ='' --P_DATAID
		AND A.M_BPS='1000'
	  ORDER BY DBMS_RANDOM.RANDOM
	  )
	  ) WHERE ROW_NUM = 1
	   -->

<!DOCTYPE html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html;" charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<title>동영상플레이</title>
<link rel="stylesheet" type="text/css" href="/resources/css/video-js.css">
<link rel="stylesheet" type="text/css" href="/resources/css/video-speed.css">

<script type="text/javascript" src="<c:url value='/static/js/jquery.min.js'/>"></script>
<script type="text/JavaScript" src="http://210.124.107.9/stream/embed_patch.js"></script>
<script type="text/javascript" src="http://210.124.107.9/player/swfobject.js"></script>
<script type="text/javascript" src="http://210.124.107.9/player/video/video.js"></script>
<script type="text/javascript" src="http://210.124.107.9/player/video/video-speed.js"></script>
<script type="text/javascript" src="http://210.124.107.9/player/video/videoHandlers.js"></script>
<script id="i5dynamic"></script>
</head>
<body style="margin:0 0 0 0;text-align:ceter; background-Color:#000000">
	<div id="flashcontent" style="text-align:cetner;"> <!--This text is replaced by the Flash movie. --></div>
</body>

<script>
var client_type = client_brw_check();
var surl;

function anPlay(){
	var video = document.getElementById('video');
	video.addEventListener('click',function(){  video.play(); video.webkitEnterFullScreen();},false);
	video.play();
	video.webkitEnterFullScreen();
}
surl = "http://210.124.107.9/player/stream.php?fno=MK001013_P03&mode="+client_type+"&scr="+mobile_width+"x"+mobile_height;
i5dynamic.src = surl;
anPlay();

</script>
</html>