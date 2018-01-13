<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<style>
.countsort{
	position : relative;
	width : 100%;
	height : 0;
	padding-bottom : 56.25%;
}

.video{
	position : absolute;
	top : 0;
	left : 0;
	width : 100%;
	height : 100%;
}
</style>



<link rel="stylesheet" type="text/css" href="/resources/css/member.css">

<div id="contents" class="">
	<iframe id="contentsFrame" name="contentsFrame" width="100%" height="400px" frameborder="0" src="http://<c:url value="${joinUrl}"/>"></iframe>
</div>

<script type="text/javascript">
	$(document).ready(function() {

	});

	function resize_frame(id) {
		var frm = document.getElementById("contents");
		function resize() {
		frm.style.height = "auto"; // set default height for Opera
		contentHeight = frm.contentWindow.document.documentElement.scrollHeight;
		frm.style.height = contentHeight + 300 + "px"; // 23px for IE7
		}
		if (frm.addEventListener) {
		frm.addEventListener('load', resize, false);
		} else {
		frm.attachEvent('onload', resize);
		}
		}
		resize_frame('contents');
</script>