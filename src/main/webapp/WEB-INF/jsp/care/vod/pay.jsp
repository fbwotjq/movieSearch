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
			<div class="service-cont type2">
				<div class="regular-tt">
					<h4>정기이용권 결제시 기간 또는 금액 한도내로 영화를 보실 수 있습니다.</h4>
				</div>
				<div class="regular-cont">
					<ul>
						<li class="price-block">
							<div class="price">
								<span>5,000원</span>
								<span class="em weighty">정액권</span>
								<span>5,000원</span>
							</div>
							<div class="descrip">
								<span>5,000원 내에서 기간 제한 없이 이용</span><span>(500원 영화 10편 감상)</span>
							</div>
							<div class="btn-group large full">
								<a href="javascript:goIniPay(3);" class="btn large slightly">일반 결제</a>
								<!-- <a href="javascript:void(0);" class="btn large kakao">
									<img class="mobile-on" src="../../resources/images/icon/ico-kakao-m.png" alt="카카오페이">
									<img class="mobile-off" src="../../resources/images/icon/ico-kakao-d.png" alt="카카오페이">
								</a> -->
							</div>
						</li>
						<li class="price-block">
							<div class="price">
								<span>10,000원</span>
								<span class="em weighty">정액권</span>
								<span>10,000원</span>
							</div>
							<div class="descrip">
								<span>10,000원 내에서 기간 제한 없이 이용</span><span>(500원 영화 20편 감상 + 1편 보너스!)</span>
							</div>
							<div class="btn-group large full">
								<a href="javascript:goIniPay(4);" class="btn large slightly">일반 결제</a>
								<!-- <a href="javascript:void(0);" class="btn large kakao">
									<img class="mobile-on" src="../../resources/images/icon/ico-kakao-m.png" alt="카카오페이">
									<img class="mobile-off" src="../../resources/images/icon/ico-kakao-d.png" alt="카카오페이">
								</a> -->
							</div>
						</li>
						<li class="price-block">
							<div class="price">
								<span>관람기간</span>
								<span class="em weighty">14일권</span>
								<span>5,000원</span>
							</div>
							<div class="descrip">
								<span>14일간 영화편수 제한없이 무제한으로 이용</span>
							</div>
							<div class="btn-group large full">
								<a href="javascript:goIniPay(1);" class="btn large slightly">일반 결제</a>
								<!-- <a href="javascript:void(0);" class="btn large kakao">
									<img class="mobile-on" src="../../resources/images/icon/ico-kakao-m.png" alt="카카오페이">
									<img class="mobile-off" src="../../resources/images/icon/ico-kakao-d.png" alt="카카오페이">
								</a> -->
							</div>
						</li>
						<li class="price-block">
							<div class="price">
								<span>관람기간</span>
								<span class="em weighty">30일권</span>
								<span>10,000원</span>
							</div>
							<div class="descrip">
								<span>30일간 영화편수 제한없이 무제한으로 이용</span>
							</div>
							<div class="btn-group large full">
								<a href="javascript:goIniPay(2);" class="btn large slightly">일반 결제</a>
								<!-- <a href="javascript:void(0);" class="btn large kakao">
									<img class="mobile-on" src="../../resources/images/icon/ico-kakao-m.png" alt="카카오페이">
									<img class="mobile-off" src="../../resources/images/icon/ico-kakao-d.png" alt="카카오페이">
								</a> -->
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
<form id="form1" name="form1" method="post">
	<sec:csrfInput/>
	<input type="hidden" id="payCheck" name="payCheck" value=""/>
	<input type="hidden" id="buyername" name="buyername" value=""/>
</form>

<script type="text/javascript">
	$(document).ready(function() {
		//design
		$("#wrap").addClass("regular-pass");

	});
</script>

<sec:authorize access="isAnonymous()">
	<script type="text/javascript">
		function goIniPay(){
			alert("로그인후 사용가능합니다.");
			location.href = "/login?returnUrl=/care/vod/pay";
		}
	</script>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
	<script type="text/javascript">
		var win_ = null;
		function goIniPay(payCheck){
			if(win_){
				win_.close();
			}
			win_ = window.open('/care/vod/pay/pop?payCheck='+payCheck, 'KMDbPAY', 'width=500px,height=700px,resizable=yes');
			win_.focus();
		}

	</script>
</sec:authorize>
