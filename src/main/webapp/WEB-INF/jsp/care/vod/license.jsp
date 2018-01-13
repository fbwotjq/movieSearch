<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/service.css">

<div id="contents">
	<div class="breadcrumb">
		<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
	</div>
	<div class="container">
		<div class="top-area">
			<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
			<%@ include file="/WEB-INF/jsp/common/include/common/common02.jsp"%>
		</div>
		<div class="service-cont">
			<div class="license-header">
				<p><span>기관라이선스란 연계약을 통해 한국영화 VOD에서 서비스하는 모든 영화를 자유롭게 관람할 수 있는 서비스입니다.</span><span> 영화연구소, 도서관 등 한국고전영화를 제한 없이 감상(서비스)하고 싶은 기관과 단체에게 추천해드립니다.</span></p>
			</div>
			<div class="license-cont">
				<div class="howtosee">
					<p>한국고전영화를 자유롭게 감상하는 방법</p>
					<span class="em weighty">1년 관람료 : PC 1대만 연 10만원 (고정 1P만 서비스 가능합니다.) </span>
				</div>
				<div class="steplist">
					<ul>
						<li class="steps step01">
							<div class="steps-cont">
								<span>STEP1</span>
								<span>기관라이센스 발급 요청</span>
								<p>신청서를 다운 받으신 후 작성하여 이메일이나 팩스로 보내주세요.<br> M. <a href="marilto:duane@koreafilm.or.kr">duane@koreafilm.or.kr</a><br>F. 02-3153-2080</p>
								<div class="download">
									<a class="btn large disable" href="#"><span>한국어 다운로드</span></a>
									<a class="btn large disable" href="#"><span>영어 다운로드</span></a>
								</div>
							</div>
						</li>
						<li class="steps step02">
							<div class="steps-cont">
								<span>STEP2</span>
								<span>대금결제</span>
								<p>신청서가 접수되면 1~2일 후 한국영상 자료원으로부터 결제를 요청하는 이메일이 발송됩니다. 이메일에서 연결되는 결제화면에 따라 연 관람비용을 결제해주시기 바랍니다. 결제 방법은 신용카드와 무통장입금이 가능합니다.</p>
							</div>
						</li>
						<li class="steps step03">
							<div class="steps-cont">
								<span>STEP3</span>
								<span>영화 감상하기</span>
								<p>대금결제가 확인되면 요청하신 기간 동안 무제한으로 한국고전영화를감상하실 수 있습니다. 즐거운 영화 감상하세요!</p>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function() {
		//design
		$("#wrap").addClass("license");
	});
</script>