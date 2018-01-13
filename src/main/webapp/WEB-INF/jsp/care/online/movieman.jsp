<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="/resources/css/service.css">
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">

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
		<div class="regimovie-tt">
			<h4>개인정보의 수집·이용에 관한 동의사항</h4>
		</div>
		<div class="regimovie-cont">
			<form id="movieForm" name="movieForm" method="post">
				<sec:csrfInput/>
				<section id="fieldset">
					<div class="area">
						<fieldset class="fieldset">
							<legend>개인정보 수집 이용에 관한 동의사항</legend>
							<div class="agree-area">
								<ul>
									<li>
										<div>개인정보의 수집·이용 목적</div>
										<span>한국영화제작 참여인력 영화인 데이터베이스 구축 및 인터넷(<a href="http://www.kmdb.or.kr">http://www.kmdb.or.kr</a>) 서비스</span>
									</li>
									<li>
										<div>수집하는 개인정보의 항목</div>
										<span>필수항목 : 성명, 영문성명, 성  번호, 활동분야, 학력, 이메일, 경력, 영화계 입문배경, 애착작품 및 사유</span>
										<span>선택항목 : 한자성명, 본명, 본명한문, 본명영문, 생년 월일, 키, 주소, 저술내역, 수상내역, 하고싶은 말</span>
									</li>
									<li>
										<div>개인정보의 보유 및 이용기간</div>
										<span>영화인 개인정보 데이터베이스는 서비스 되는 동안 지속적으로 보관되며 외부 서비스 이용은 한국영화데이터베이스 홈페이지(<a href="http://www.kmdb.or.kr">http://www.kmdb.or.kr</a>)가 폐쇄될 때까지 이용됩니다.</span>
									</li>
									<li>
										<div>동의 거부 권리 사실 및 불이익 내용</div>
										<span>영화인 데이터베이스 구축 및 검색서비스 제공에 본인의 개인정보수집, 이용을 원치 않으실 경우 본 동의를 거절하실 수 있습니다.</span>
										<span>동의를 거절하실 경우에는 어떠한 불이익도 없으며, 단 영화인 데이터베이스 구축 및 검색서비스 목록에서 제외됨을 알려드립니다.</span>
									</li>
								</ul>
								<div class="asset">
									<label><input type="checkbox" id="mem_agree" > <span class="label">동의합니다.</span></label>
								</div>
							</div>
							<div class="more-info">
								※ KMDb에 추가할 영화인정보를 입력해 주시면 확인 후 KMDb에 반영하도록 하겠습니다.
							</div>
							<div class="field">
								<div class="label">
									<label for="arname">성명 <span class="em weighty">*</span></label>
								</div>
								<div class="insert">
									<input type="text" id="arname" name="arname" placeholder="이름 입력">
								</div>
								<span id="error-arname"></span>
							</div>
							<div class="field">
								<div class="label">
									<label for="arnameC">한자</label>
								</div>
								<div class="insert">
									<input type="text" id="arnameC" name="arnameC" placeholder="한자 입력">
								</div>
							</div>
							<div class="field">
								<div class="label">
									<label for="arnameE">영문 <span class="em weighty">*</span></label>
								</div>
								<div class="insert">
									<input type="text" id="arnameE" name="arnameE" placeholder="영문 입력">
								</div>
							</div>
							<div class="field">
								<div class="label">
									<label for="arnameR">본명</label>
								</div>
								<div class="insert">
									<input type="text" id="arnameR" name="arnameR" placeholder="본명 입력">
								</div>
							</div>
							<div class="field">
								<div class="label">
									<label for="arnameRC">본명한문</label>
								</div>
								<div class="insert">
									<input type="text" id="arnameRC" name="arnameRC" placeholder="본명한문 입력">
								</div>
							</div>
							<div class="field">
								<div class="label">
									<label for="arnameRE">본명영문</label>
								</div>
								<div class="insert">
									<input type="text" id="arnameRE" name="arnameRE" placeholder="본명영문 입력">
								</div>
							</div>
							<div class="field birth">
								<div class="label">
									<label for="birthday"> 생년월일</label>
								</div>
								<div class="insert">
									<input type="text" id="birthday" name="birthday" placeholder="ex. 20100630">
									<div class="selector-wrap horizontal space">
										<div class="asset">
											<label><input type="radio" name="birthGubun" id="birthGubun" value="양력"> <span class="label">양력</span></label>
										</div>
										<div class="asset">
											<label><input type="radio" name="birthGubun" id="birthGubun2" value="음력"> <span class="label">음력</span></label>
										</div>
									</div>
								</div>
							</div>
							<div class="field gender">
								<div class="label">
									<label for="sex">성별</label>
								</div>
								<div class="insert">
									<div class="selector-wrap horizontal space">
										<div class="asset">
											<label><input type="radio" name="sex" id="sex" value="남성"> <span class="label">여자</span></label>
										</div>
										<div class="asset">
											<label><input type="radio" name="sex" id="sex" value="여성"> <span class="label">남자</span></label>
										</div>
									</div>
								</div>
							</div>
							<div class="field inline-email">
								<div class="label">
									<label for="telno1">전화번호 <span class="em weighty">*</span></label>
								</div>
								<div class="insert">
									<div class="insert-multi with-email">
										<div class="box select-box">
											<select name="telno1" id="telno1" class="select-tric">
												<option value="02" selected>02</option>
												<option value="031">031</option>
												<option value="032">032</option>
												<option value="033">033</option>
												<option value="041">041</option>
												<option value="042">042</option>
												<option value="043">043</option>
												<option value="044">044</option>
												<option value="051">051</option>
												<option value="052">052</option>
												<option value="053">053</option>
												<option value="054">054</option>
												<option value="055">055</option>
												<option value="061">061</option>
												<option value="062">062</option>
												<option value="063">063</option>
												<option value="064">064</option>
												<option value="070">070</option>
												<option value="080">080</option>
											</select>
										</div>
										<div class="box dash-box">-</div>
										<div class="box"><input type="text" id="telno2"  name="telno2"></div>
										<div class="box dash-box">-</div>
										<div class="box"><input type="text" id="telno3"  name="telno3"></div>
									</div>
								</div>
							</div>
							<div class="field inline-email">
								<div class="label">
									<label for="htelno1">휴대폰</label>
								</div>
								<div class="insert">
									<div class="insert-multi with-email">
										<div class="box select-box">
											<select name="htelno1" id="htelno1" class="select-tric">
												<option value="">선택</option>
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
											</select>
										</div>
										<div class="box dash-box">-</div>
										<div class="box"><input type="text" id="htelno2"  name="htelno2"></div>
										<div class="box dash-box">-</div>
										<div class="box"><input type="text" id="htelno3"  name="htelno3"></div>
									</div>
								</div>
							</div>
							<div class="field inline-email">
								<div class="label">
									<label for="email">이메일 <span class="em weighty">*</span></label>
								</div>
								<div class="insert">
									<input type="text" id="email" name="email" placeholder="이메일 입력">
								</div>
							</div>
							<div class="field">
								<div class="label">
									<label for="activeArea">활동분야 <span class="em weighty">*</span></label>
								</div>
								<div class="insert">
									<input type="text" id="activeArea" name="activeArea" placeholder="활동분야 입력">
								</div>
							</div>
							<div class="field textarea-box">
								<div class="label">
									<label for="school">학력 <span class="em weighty">*</span></label>
								</div>
								<div class="insert">
									<textarea name="school" id="school"></textarea>
								</div>
							</div>
							<div class="field textarea-box">
								<div class="label">
									<label for="imHistory">주요경력 <span class="em weighty">*</span></label>
								</div>
								<div class="insert">
									<textarea name="imHistory" id="imHistory"></textarea>
								</div>
							</div>
							<div class="field textarea-box">
								<div class="label">
									<label for="writeHistory">저술내역</label>
								</div>
								<div class="insert">
									<textarea name="writeHistory" id="writeHistory"></textarea>
								</div>
							</div>
							<div class="field textarea-box">
								<div class="label">
									<label for="prizeHistory">수상내역</label>
								</div>
								<div class="insert">
									<textarea name="prizeHistory" id="prizeHistory"></textarea>
								</div>
							</div>
							<div class="field textarea-box">
								<div class="label">
									<label for="movieIn">영화계 입문배경 <span class="em weighty">*</span></label>
								</div>
								<div class="insert">
									<textarea name="movieIn" id="movieIn"></textarea>
								</div>
							</div>
							<div class="field textarea-box">
								<div class="label">
									<label for="likeMovie">애착작품 및 사유 <span class="em weighty">*</span></label>
								</div>
								<div class="insert">
									<textarea name="likeMovie" id="likeMovie"></textarea>
								</div>
							</div>
							<div class="field textarea-box">
								<div class="label">
									<label for="wantTalk">하고 싶은 말</label>
								</div>
								<div class="insert">
									<textarea name="wantTalk" id="wantTalk"></textarea>
								</div>
							</div>
							<div class="btn-next btn-group large"><button class="btn large weighty" onclick="goMovieMan();return false;">등록</button></div>
						</fieldset>
					</div>
				</section>
				</form>
			</div>
		</div>
	</div>
</div>
	<div class="mPopup1" id="jsAlert">
		<div class="popupBg">
			<h4 class="title" id="alertText">등록이 완료 되었습니다.</h4>
			<div class="cont">
				<div class="mButton1">
					<button class="btn large weighty" type="button" id="alertBtn">확인</button>
					<button class="btn large weighty" type="button" id="compBtn">확인</button>
				</div>
			</div>
			<button type="button" class="b-close" title="닫기" id="closeBtn">닫기</button>
		</div>
	</div>

<script type="text/javascript">
	$(document).ready(function() {

		$.validator.addMethod("alpha", function(value, element) {
		    return this.optional(element) || value == value.match(/^[a-zA-Z\s]+$/);
		}, '영문만 입력가능합니다.');

		$("#movieForm").validate({
            submitHandler: function(form) {

            	/* if (confirm("등록 하시겠습니까?") == false) {
                    return;
                }

            	var response = $.fnAjax({params:$("#movieForm").serialize(), url:"<c:url value='/care/online/movieman/proc'/>", async:false, showMessage:false});
                if (response.result == "true") {
                	alert('등록되었습니다.');
					location.href="/";
					return;
                }else {
                	alert("영화인 정보 등록중 에러가 발생하였습니다.");
                	return;
                } */

                BPOPUP =  $('#jsAlert').bPopup({
            		modalClose : false, //배경클릭시 창을 닫을지 여부
            		opacity: 0.6,
            		positionStyle: 'fixed',
            		onOpen: function() {
            			$('#alertText').html("등록 하시겠습니까?");
            			$("#alertBtn").off('click');
            			$("#compBtn").off('click');
            			$("#alertBtn").show();
            			$("#compBtn").hide();
            			$('#alertBtn').click(function(){

            				var response = $.fnAjax({params:$("#movieForm").serialize(), url:"<c:url value='/care/online/movieman/proc'/>", async:false, showMessage:false});
            			    if (response.result == "true") {
            			    	$('#closeBtn').hide();
            			    	$("#alertBtn").hide();
            					$("#compBtn").show();
            	    			$('#alertText').html("등록 되었습니다.");
            	    			$('#compBtn').click(function(){
            	    				location.href="/";
            	    			});

            			    }else {
            			    	$('#alertText').html("영화인 정보 등록중 에러가 발생하였습니다.");
            			    	$("#alertBtn").hide();
            					$("#compBtn").show();
            	    			$('#compBtn').click(function(){
            	    				$('#jsAlert').bPopup().close();
            	    			});
            			    }

            			});
            		}
            	});


                return false;
            },
			rules : {
				arname : {required : true},
				arnameE : {required : true, alpha : true},
				telno2 : {required : true, number: true, rangelength: [3, 4]},
				telno3 : {required : true, number: true, rangelength: [4, 4]},
				email : {required : true, email: true},
				activeArea : {required : true},
				school : {required : true},
				imHistory : {required : true},
				movieIn : {required : true},
				likeMovie : {required : true}
			},
			messages : {
				arname : {required : "성명을 적으세요"},
				arnameE : {required : "영문 성명을 적으세요"},
				telno2 : {required : "전화번호를 적으세요",
	                		number: "전화번호는 숫자로 입력하셔야합니다.",
							rangelength: $.validator.format("전화번호 가운데자리는 최소 {0}글자 이상 {1}글자 이하로 입력하세요.")
							},
				telno3 : {required : "전화번호를 적으세요",
            				number: "전화번호는 숫자로 입력하셔야합니다.",
							rangelength: $.validator.format("전화번호 끝자리는 최소 {0}글자 이상 {1}글자 이하로 입력하세요.")
							},
				email : {required: "이메일을 입력하세요",
		                	email: "올바른 이메일 주소가 아닙니다."},
				activeArea : {required : "활동분야를 적으세요"},
				school : {required : "학력을 적으세요"},
				imHistory : {required : "주용경력을 적으세요"},
				movieIn : {required : "영화계 입문 배경을 적으세요"},
				likeMovie : {required : "애착작품 및 사유를 적으세요"}
			},
			invalidHandler: function(form, validator) {
		        var errors = validator.numberOfInvalids();
		        if (errors) {
		            validator.errorList[0].element.focus();
		        }
		    }
	    });
	});
	function goMovieMan() {
		if ($('#mem_agree').is(':checked') == false) {
			$('#mem_agree').focus();
			alert('개인정보 수집/이용에 관한 동의 사항에 체크하세요');
			return;
		}else{
			$("#movieForm").submit();
		}


	}

</script>