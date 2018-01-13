<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/member.css">

<div id="contents" class="memberfill">
	<div class="breadcrumb">
				<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
	</div>
	<div class="container">
		<div class="container">
			<div class="top-area">
				<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
				<%@ include file="/WEB-INF/jsp/common/include/common/common02.jsp"%>
			</div>
			<form id="form1" name="form1" method="post">
				<sec:csrfInput/>
				<section id="fieldset">
					<div class="mMyinfo">
						<fieldset class="fieldset">
							<legend>회원가입정보</legend>
								<div class="myinfo">
									나의 정보
									<ul>
										<li class="em weighty"><c:out value='${joinMemberVo.userName }' /></li>
										<li class="bullet-dot"><c:out value='${joinMemberVo.birthYear }' />년 <c:out value='${joinMemberVo.birthMonth }' />월 <c:out value='${joinMemberVo.birthDay }' />일</li>
										<li class="bullet-dot"><c:out value='${joinMemberVo.sex }' /></li>
									</ul>
								</div>
							<div class="field">
								<div class="label">
									<label for="password">
										비밀번호
									</label>
								</div>
								<div class="insert id-check w1">
									<div>
										<input class="btn large disable" type="button" onclick="changePassword();" value="비밀번호 변경하기">
									</div>
								</div>
							</div>
							<div class="field">
								<div class="label">
									<label for="">주소</label>
								</div>
								<div class="insert id-check type2">
									<div>
										<input type="text" id="zipCd" name="zipCd" readonly="readonly" value="${joinMemberVo.zipCd }">
										<input class="btn large disable" type="button" onclick="searchAddress(); return false;" value="주소 찾기">
									</div>
								</div>
								<div class="insert mt1">
									<div class="row">
										<input type="text" id="address" name="address" readonly="readonly" value="${joinMemberVo.address }" placeholder="상세주소 입력">
									</div>
									<div class="row space">
										<input type="text" id="detailAddress" name="detailAddress" value="${joinMemberVo.detailAddress }" placeholder="상세주소 입력">
									</div>
								</div>
							</div>
							<div class="field inline-email">
								<div class="label">
									<label for="cellNo1">휴대폰</label>
								</div>
								<div class="insert">
									<div class="insert-multi with-email">
										<div class="box select-box">
											<select name="cellNo1" id="cellNo1" class="select-tric">
			                                    <option value="010">010</option>
			                                    <option value="011">011</option>
			                                    <option value="016">016</option>
			                                    <option value="017">017</option>
			                                    <option value="018">018</option>
			                                    <option value="019">019</option>
											</select>
										</div>
										<div class="box dash-box">-</div>
										<div class="box">
											<input type="text" id="cellNo2" name="cellNo2" value="${joinMemberVo.cellNo2 }" >
										</div>
										<div class="box dash-box">-</div>
										<div class="box">
											<input type="text" id="cellNo3" name="cellNo3" value="${joinMemberVo.cellNo3 }" >
										</div>
									</div>
								</div>
							</div>

	                        <div class="field inline-email type2">
								<div class="label">
									<label for="">이메일</label>
									<span class="em slightly comment-line"><span class="forPc">*</span> <span class="brForMobile">이메일 주소는 아이디/비밀번호 찾기에서 활용될 수 있습니다.</span> 정확한 메일 주소를 입력해주세요.</span>
								</div>
								<div class="insert">
									<div class="insert-multi with-email">
										<div class="box"><input type="text" placeholder="이메일" id="emailId" name="emailId" value="${joinMemberVo.emailId }"></div>
										<div class="box at-box">@</div>
										<div class="box select-box">
											<select name="selEmailDomain" id="selEmailDomain" class="select-tric">
												<option value="">직접입력</option>
	                                            <c:set var="active" value=""/>
	                                            <option value="naver.com" <c:if test="${joinMemberVo.emailDomain eq 'naver.com' }">selected="selected" <c:set var="active" value="active"/></c:if>>naver.com</option>
	                                            <option value="gmail.com" <c:if test="${joinMemberVo.emailDomain eq 'gmail.com' }">selected="selected" <c:set var="active" value="active"/></c:if>>gmail.com</option>
	                                            <option value="hanmail.net" <c:if test="${joinMemberVo.emailDomain eq 'hanmail.net' }">selected="selected" <c:set var="active" value="active"/></c:if>>hanmail.net</option>
	                                            <option value="nate.com" <c:if test="${joinMemberVo.emailDomain eq 'nate.com' }">selected="selected" <c:set var="active" value="active"/></c:if>>nate.com</option>
	                                        </select>
										</div>
									</div>
									<div class="direct"><input type="text" id="emailDomain" name="emailDomain" value="${joinMemberVo.emailDomain }"  class="input-email mt1" placeholder="직접입력"></div>
								</div>
								<!-- <span class="em slightly comment-line">이메일 형식을 확인해주세요. 이메일은 필수 입니다.</span> -->
							</div>

							<div class="field newletter type2">
								<div class="label">
									<label for="">뉴스레터 수신동의</label>
									<span class="em slightly comment-line"><span class="forPc">*</span> 메일링리스트에 가입하시면 한국영상자료원의 뉴스레터를 만나보실수 있습니다.</span>
								</div>
								<div class="insert">
									<div class="selector-wrap horizontal recieve-select">
										<div class="asset">
											<label><input type="radio" name="receiveCd" value="Y"> <span class="label">수신동의</span></label>
										</div>
										<div class="asset">
											<label><input type="radio" name="receiveCd" value="N"> <span class="label">동의하지 않음</span></label>
										</div>
										<input type="hidden" id="receiveCd" value="${joinMemberVo.receiveCd }">
									</div>
								</div>
							</div>

							<div class="btn-next btn-group large"><button class="btn large weighty" type="button" onclick="changeInfo();">수정</button></div>
								<div class="mMInfo1">
									<strong class="ti">아래의 정보는 수정이 불가능합니다.</strong>
									<span class="brForMobile">이름, 아이디, 생년월일, 성별은 수정이 불가합니다.</span>
									수정을 원하시는 분은 관리자에게 연락주시기 바랍니다.
									<div class="tel">
										<span class="ls"><em class="t">T.</em> 02-3153-2022</span>
										<span class="ls"><em class="t">M.</em> <a href="mailto:duane@koreafilm.or.kr">duane@koreafilm.or.kr</a></span>
									</div>
								</div>

						</fieldset>
					</div>
				</section>
			</form>

		</div>
	</div>
</div>

<c:set var="protocol" value="${pageContext.request.scheme}"/>
<c:choose>
	<c:when test="${protocol eq 'http' }">
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	</c:when>
	<c:otherwise>
	<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
	</c:otherwise>
</c:choose>
<script type="text/javascript">
	$(document).ready(function() {
		//design
		$("#body").addClass("login");
		$("#wrap").addClass("regi-step03");

		var radioArr = document.getElementsByName("receiveCd");

	    if($("#receiveCd").val() == "Y")
	    	radioArr[0].checked = true;
	    else
	    	radioArr[1].checked = true;

		$("#selEmailDomain").change(function() {
			var selTxt = $("#selEmailDomain option:selected").val();

			if(selTxt == '직접입력') {
				$("#emailDomain").val('');
			} else {
				$("#emailDomain").val(selTxt);
			}
		});

	    $("#form1").validate({
	    	debug: true,
            submitHandler: function(form) {
                formSubmit("form1", "<c:url value='/mypage/info/result'/>");
            }
	        ,rules: {
	           zipCd: { required: true }
	           ,address: { required: true }
	           ,detailAddress: { required: true }
	           ,cellNo2: { required: true }
	           ,cellNo3: { required: true }
               ,emailId: { required: true }
               ,emailDomain: { required: true }
	        }
	        ,messages: {
               zipCd: { required: "우편번호를 입력하세요." }
               ,address: { required: "주소를 입력하세요." }
               ,detailAddress: { required: "상세주소를 입력하세요." }
	           ,cellNo2: { required: "핸드폰 가운데 번호를 입력하세요." }
	           ,cellNo3: { required: "핸드폰 마지막 번호를 입력하세요." }
               ,emailId: { required: "이메일 아이디를 입력하세요." }
               ,emailDomain: { required: "이메일 도메인을 입력하세요." }
	        }
	    });
	});

	function changePassword() {
        self.location.href = '/mypage/info/password';
	}

	function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipCd').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address').value = fullRoadAddr;
                document.getElementById('detailAddress').focus();
                //$('#msg_addr').children('p').eq('0').hide();
            }
        }).open({
        	popupName: 'postcodePopup' ,//팝업 이름을 설정(영문,한글,숫자 모두 가능, 영문 추천)
        	autoClose: true
        });
    }

	function changeInfo() {
        if ($('#form1').valid() == false) {
            $("#form1").validate().focusInvalid();
            return;
        }
	}
</script>