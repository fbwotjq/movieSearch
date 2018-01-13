<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/member.css">

<div id="contents" class="memberfill">
	<div class="breadcrumb">
		<ul>
			<li class="ico-home"><a href="<c:url value='/main'/>">홈</a></li>
			<li class="located"><a href="<c:url value='/member/join'/>">회원가입</a></li>
		</ul>
	</div>
	<div class="container">
		<div class="top-area">
			<div class="prev-page">
				<a href="javascript:fnHistoryBack();"><i class="ico-prev"></i><span>이전</span></a>
			</div>
			<h2>회원가입</h2>
		</div>
		<div class="regi-menu">
			<ul>
				<li><a href="javascript:void(0);"><span>Step1</span><span>본인인증</span></a></li>
				<li><a href="javascript:void(0);"><span>Step2</span><span>약관동의</span></a></li>
				<li class="selected"><a href="javascript:void(0);"><span>Step3</span><span>정보입력</span></a></li>
				<li><a href="javascript:void(0);"><span>Step4</span><span>가입완료</span></a></li>
			</ul>
		</div>
		<form id="form1" name="form1" method="post">
			<section id="fieldset">
				<div class="area">
					<fieldset class="fieldset">
						<legend>회원가입정보</legend>
						<c:if test="${joinMemberVo.joinType eq 'over14'}">
							<div class="myinfo">
								나의 정보
								<ul>
									<li class="em weighty"><c:out value='${joinMemberVo.userName }' /></li>
									<li class="bullet-dot"><c:out value='${joinMemberVo.birthYear }' />년 <c:out value='${joinMemberVo.birthMonth }' />월 <c:out value='${joinMemberVo.birthDay }' />일</li>
									<li class="bullet-dot"><c:out value='${joinMemberVo.sex }' /></li>
								</ul>
							</div>
						</c:if>

                        <c:if test="${joinMemberVo.joinType eq 'under14'}">
							<div class="field">
								<div class="label">
									<label for="">
										어린이(자녀) 이름 <span class="em weighty">*</span>
									</label>
								</div>
								<div class="insert">
									<input type="text" placeholder="이름">
								</div>
							</div>
							<div class="field child-birth">
								<div class="label">
									<label for="">
										어린이(자녀) 생년월일 <span class="em weighty">*</span>
									</label>
								</div>
								<div class="insert">
									<input type="text" placeholder="ex. 20100630">
									<div class="selector-wrap horizontal">
										<div class="asset">
											<label>
												<div class="radio">
													<span><input type="radio" name="radio1" id=""></span>
												</div>
												<span class="label">양력</span>
											</label>
										</div>
										<div class="asset">
											<label>
												<div class="radio">
													<span><input type="radio" name="radio1" id=""></span>
												</div>
												<span class="label">음력</span>
											</label>
										</div>
									</div>
								</div>
							</div>
							<div class="field gender">
								<div class="label">
									<label for="">
										성별 <span class="em weighty">*</span>
									</label>
								</div>
								<div class="insert">
									<div class="selector-wrap horizontal">
										<div class="asset">
											<label>
												<div class="radio">
													<span><input type="radio" name="radio2" id=""></span>
												</div>
												<span class="label">여자</span>
											</label>
										</div>
										<div class="asset">
											<label>
												<div class="radio">
													<span><input type="radio" name="radio2" id=""></span>
												</div>
												<span class="label">남자</span>
											</label>
										</div>
									</div>
								</div>
							</div>
						</c:if>
						<div class="field">
							<div class="label">
								<label for="userId">
									아이디 <span class="em weighty">*</span>
								</label>
							</div>
							<div class="insert id-check">
								<div>
									<input type="text" id="userId" name="userId" placeholder="아이디"> <input class="btn large disable" type="submit" value="ID 중복 확인">
								</div>
							</div>
							<span id="error-userId"></span>
							<span class="em slightly comment-line">영문/숫자 6자 이상 15자리까지 가능합니다. 특수문자는 사용 불가합니다. 아이디 중복확인은 필수입니다.</span>
							<!--입력 오류시 보여지는 내용-->
							<!-- <span class="em warning comment-line">아이디는 영문/숫자를 모두 조합하여 6이상 15이하로 만들어주세요. ID 중복 확인을 해주세요. 아이디는 필수 항목입니다.</span>
                                    -->
						</div>
						<div class="field">
							<div class="label">
								<label for="password">
									비밀번호 <span class="em weighty">*</span>
								</label>
							</div>
							<div class="insert">
								<div class="row">
									<input type="password" id="password" name="password" placeholder="비밀번호">
								</div>
								<div class="row">
									<input type="password" id="checkPassword" name="checkPassword" placeholder="비밀번호 확인">
								</div>
							</div>
							<span class="em slightly comment-line">8자리 이상 20자 이내로 영문 대/소문자. 숫자, 특수문자 중 3가지이상 포함으로 사용가능합니다.</span>
							<!-- <span class="em warning comment-line">비밀번호는 영문/숫자/특수문자를 모두 조합하여 8이상 20이하로 만들어주세요. 비밀번호는 필수 항목입니다.</span> -->
						</div>
						<div class="field">
							<div class="label">
								<label for="zipCd">
									주소 <span class="em weighty">*</span>
								</label>
							</div>
							<div class="insert addr-check">
								<div>
									<div class="addr-check-left">
										<input type="text" id="zipCd" name="zipCd">
									</div>
									<input class="btn large disable" type="submit" value="주소찾기">
								</div>
								<input type="text" id="address" name="address" placeholder="주소 입력">
								<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소 입력" class="add-detail">
							</div>
							<span id="error-zipCd"></span>
							<span id="error-address"></span>
							<span id="error-detailAddress"></span>
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
										<input type="text" id="cellNo2" name="cellNo2">
									</div>
									<div class="box dash-box">-</div>
									<div class="box">
										<input type="text" id="cellNo3" name="cellNo3">
									</div>
								</div>
							</div>
							<span id="error-cellNo1"></span>
							<span id="error-cellNo2"></span>
							<span id="error-cellNo3"></span>
						</div>
                        <div class="field inline-email">
                            <div class="label">
                                <label for="emailId">이메일</label>
                            </div>
                            <div class="insert">
                                <div class="insert-multi with-email">
                                    <div class="box">
                                        <input type="text" id="emailId" name="emailId" placeholder="이메일">
                                    </div>
                                    <div class="box at-box">@</div>
                                    <div class="box select-box">
                                        <select name="selEmailDomain" id="selEmailDomain" class="select-tric">
                                            <option value="">직접입력</option>
                                            <option value="naver.com">naver.com</option>
                                            <option value="gmail.com">gmail.com</option>
                                            <option value="hanmail.net">hanmail.net</option>
                                            <option value="nate.com">nate.com</option>
                                        </select>
                                    </div>
                                </div>
                                <input type="text" id="emailDomain" name="emailDomain" class="input-email">
                            </div>
                            <span id="error-emailId"></span>
                            <span id="error-emailDomain"></span>
                        </div>

						<div class="select-favorit">
							<p>아래 선택 항목은 보다 나은 서비스 제공을 위해 한국영상자료원에서 수집하는 내용입니다.</p>
						</div>

						<div class="field job">
							<div class="label">
								<label for="jobCode">직업</label>
							</div>
							<div class="insert">
								<div class="box select-box">
									<select name="jobCode" id="jobCode" class="select-tric">
										<option value="">선택</option>
										<option value="01">회사원</option>
										<option value="02">자영업</option>
										<option value="03">전문직</option>
										<option value="04">대학(원)생</option>
										<option value="05">중/고등학생</option>
										<option value="06">초등학생</option>
										<option value="07">영화계 종사자</option>
										<option value="08">기타</option>
									</select>
								</div>
							</div>
						</div>

						<div class="field favorit">
							<div class="label">자주 이용하시는 한국 영상 자료원 서비스</div>
							<div class="insert">
								<div class="selector-wrap horizontal">
									<div class="asset">
										<label>
											<div class="checker">
												<span><input type="checkbox" name="frequentlyService"></span>
											</div>
											<span class="label">시네마테크KOFA</span>
										</label>
									</div>
									<div class="asset">
										<label>
											<div class="checker">
												<span><input type="checkbox" name="frequentlyService"></span>
											</div>
											<span class="label">한국영화박물관</span>
										</label>
									</div>
									<div class="asset">
										<label>
											<div class="checker">
												<span><input type="checkbox" name="frequentlyService"></span>
											</div>
											<span class="label">영상도서관</span>
										</label>
									</div>
									<div class="asset">
										<label>
											<div class="checker">
												<span><input type="checkbox" name="frequentlyService"></span>
											</div>
											<span class="label">한국고전영화 VOD</span>
										</label>
									</div>
								</div>
							</div>
						</div>
						<div class="field favorit">
							<div class="label">선호 영화</div>
							<div class="insert">
								<div class="selector-wrap horizontal">
									<div class="asset">
										<label>
											<div class="checker">
												<span><input type="checkbox" name="preferenceMovie"></span>
											</div>
											<span class="label">한국영화(최신)</span>
										</label>
									</div>
									<div class="asset">
										<label>
											<div class="checker">
												<span><input type="checkbox" name="preferenceMovie"></span>
											</div>
											<span class="label">한국영화(고전)</span>
										</label>
									</div>
									<div class="asset">
										<label>
											<div class="checker">
												<span><input type="checkbox" name="preferenceMovie"></span>
											</div>
											<span class="label">해외영화(최신)</span>
										</label>
									</div>
									<div class="asset">
										<label>
											<div class="checker">
												<span><input type="checkbox" name="preferenceMovie"></span>
											</div>
											<span class="label">해외영화(고전)</span>
										</label>
									</div>
									<div class="asset">
										<label>
											<div class="checker">
												<span><input type="checkbox" name="preferenceMovie"></span>
											</div>
											<span class="label">독립영화</span>
										</label>
									</div>
								</div>
							</div>
						</div>
						<div class="field newletter">
							<div class="label">
								<label for="">뉴스레터 수신동의</label>
							</div>
							<div class="insert">
								<div class="selector-wrap horizontal recieve-select">
									<div class="asset">
										<label>
											<div class="radio">
												<span><input type="radio" name="receiveCd" value="Y" checked="checked"></span>
											</div>
											<span class="label">수신동의</span>
										</label>
									</div>
									<div class="asset">
										<label>
											<div class="radio">
												<span><input type="radio" name="receiveCd" value="N"></span>
											</div>
											<span class="label">동의하지 않음</span>
										</label>
									</div>
								</div>
							</div>
							<span class="em slightly comment-line">메일링리스트에 가입하시면 한국영상자료원의 뉴스레터를 만나보실수 있습니다.</span>
						</div>
						<div class="btn-next btn-group large">
							<button class="btn large weighty" onclick="joinResult();">다음</button>
						</div>
					</fieldset>
				</div>
			</section>
		</form>
	</div>
</div>

<script type="text/javascript" src="<c:url value='/resources/js/nice.js'/>"></script>

<script type="text/javascript">
	$(document).ready(function() {
		//design
		$("#body").addClass("login");
		$("#wrap").addClass("regi-step03");

        $.validator.addMethod("validPass", function(value, element) {
            var result = fnIsValidPasswd(value, $("#userId").val());
            var arrResult = result.split("|");

            if (arrResult[0] == "1") {
                return true;
            }else {
                $.validator.messages.validPass = arrResult[1];
                return false;
            }
        }, $.validator.messages.validPass);

        $.validator.addMethod("validId", function(value, element) {
            var result = fnIsValidId(value);
            var arrResult = result.split("|");

            if (arrResult[0] == "1") {
                return true;
            }else {
                $.validator.messages.validId = arrResult[1];
                return false;
            }
        }, $.validator.messages.validId);

        $.validator.addMethod("checkIdDup", function(value, element) {
        	var response = $.fnAjax({params:{userId : value}, url:"<c:url value='/member/check/id/dup'/>", async:false, showMessage:false});
            if (response.result == "true") {
            	$.validator.messages.checkIdDup = "이미 사용중인 아이디 입니다.";
            	return false;
            }else {
            	return true;
            }
        }, $.validator.messages.checkIdDup);

	    $("#form1").validate({
	    	debug: true,
            submitHandler: function(form) {
                formSubmit("form1", "<c:url value='/member/join/result'/>");
            }
	        ,rules: {
	            userId: { required: true, validId:true, checkIdDup: true}
	           ,password: { required: true, validPass : true }
	           ,checkPassword: { required: true, equalTo: "#password" }
	           ,zipCd: { required: true }
	           ,address: { required: true }
	           ,detailAddress: { required: true }
	           ,cellNo2: { required: true }
	           ,cellNo3: { required: true }
               ,emailId: { required: true }
               ,emailDomain: { required: true }
	        }
	        ,messages: {
	            userId: { required: "아이디를 입력하세요."}
	           ,password: { required: "비밀번호를 입력하세요." }
	           ,checkPassword: { required: "비밀번호 확인을 입력하세요.", equalTo : "비밀번호가 일치하지 않습니다." }
               ,zipCd: { required: "우편번호를 입력하세요." }
               ,address: { required: "주소를 입력하세요." }
               ,detailAddress: { required: "상세주소를 입력하세요." }
	           ,cellNo2: { required: "핸드폰 가운데 번호를 입력하세요." }
	           ,cellNo3: { required: "핸드폰 마지막 번호를 입력하세요." }
               ,emailId: { required: "이메일 아이디를 입력하세요." }
               ,emailDomain: { required: "이메일 도메인을 입력하세요." }
	        }
	    });
	});

	function joinResult() {
        if ($('#form1').valid() == false) {
            $("#form1").validate().focusInvalid();
            return;
        }
	}

</script>