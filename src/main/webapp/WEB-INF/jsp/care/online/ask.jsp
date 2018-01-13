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
			<div class="service-cont">
				<form id="form1" name="form1" method="post">
				<sec:csrfInput/>

					<fieldset class="fieldset">
						<legend>1:1문의 영역</legend>
						<div class="personalask-tt">
							<h4><span>한국영상자료원을 이용하시면서 궁금하신 점이나 전해주실 의견을 남겨주세요.</span> <span> 등록된 내용은 각 부서 담당자들에게 전달되며, 처리 시간은 1~3일 정도 소요됩니다.</span></h4>
							<sec:authorize access="isAuthenticated()">
							<button class="btn large disable" type="button" onclick="goList();">나의 1:1 문의 내역</button>
							</sec:authorize>
						</div>
						<div class="personalask-cont">
							<div class="field">
								<div class="label">
									<label for="">등록자</label>
								</div>
								<div class="insert">
									<input type="text" name="createName" id="createName" placeholder="등록자" value="${paramMap.userName }">
								</div>
							</div>
							<div class="field">
								<div class="label">
									<label for="">분류선택</label>
								</div>
								<div class="insert">
									<div class="insert">
										<div class="box select-box">
											<select name="privateTypeCd" id="privateTypeCd" class="select-tric">
												<option value="">선택</option>
												<c:forEach var="item" items="${privateTypeList}" varStatus="status">
		                                            <option value="<c:out value='${item.cCodeSubId }'/>" <c:if test="${item.cCodeSubId eq paramMap.privateType}">selected</c:if>><c:out value='${item.cCodeSubName }'/></option>
		                                        </c:forEach>
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="field">
								<div class="label">
									<label for="">제목<span class="condition" id="titleCount">(0/30자)</span></label>
								</div>
								<div class="insert">
									<input type="text" name="title" id="title"  placeholder="제목입력">
								</div>
							</div>
							<div class="field textarea-box">
								<div class="label">
									<label for="">내용<span class="condition" id="contentCount">(0/1000자)</span></label>
								</div>
								<div class="insert">
									<textarea name="contentDesc" id="contentDesc" cols="30" rows="10"></textarea>
								</div>
							</div>
							<div class="btn-group full large">
								<button class="btn large disable" type="button" onclick="goReset();return false;"><i class="ico-reset"></i>다시입력</button>
								<button class="btn large weighty">등록하기</button>
							</div>
						</div>
					</fieldset>
				</form>
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

		$(document.body).on("keyup","#title",function(){
			var cont = $(this).val();
			$("#titleCount").text("("+cont.replace(/\s/g, "").length+"/30자)");

			if(cont.replace(/\s/g, "").length > 30 ){
				alert('30자 이내로 작성하여 주세요.') ;
				var modCon = cont.replace(/\s/g, "").substring(0,30);
				$("#title").val(modCon);
				$("#titleCount").text("(30/30자)");
				return false;
			}

		});

		$(document.body).on("keyup","#contentDesc",function(){
			var cont = $(this).val();
			$("#contentCount").text("("+cont.replace(/\s/g, "").length+"/1000자)");

			if(cont.replace(/\s/g, "").length > 1000 ){
				alert('1000자 이내로 작성하여 주세요.') ;
				var modCon = cont.replace(/\s/g, "").substring(0,1000);
				$("#contentDesc").text(modCon);
				$("#contentCount").text("(1000/1000자)");
				return false;
			}

		});


		$('#privateTypeCd').change(function() {
			if($(this).val()){
				$('#privateTypeCd-error').hide();
			}else{
				if($('#privateTypeCd-error').length > 0){
					$('#privateTypeCd-error').show();
				}
			}
		});

		$.validator.addMethod("maxLengthCheck", function(value, element, param) {
		    return this.optional(element) || maxLengthCheck(value, param);
		}, $.validator.format("내용은 {0}자만 입력 가능합니다."));

		$("#form1").validate({
            submitHandler: function(form) {

            	/* if (confirm("등록 하시겠습니까?") == false) {
                    return;
                }

            	var response = $.fnAjax({params:$("#form1").serialize(), url:"<c:url value='${paramMap._view_path}'/>/proc", async:false, showMessage:false});
                if (response.result == "true") {
                	alert('등록되었습니다.');
                	goReset();
					return;
                }else {
                	alert("등록중 에러가 발생하였습니다.");
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

                        	var response = $.fnAjax({params:$("#form1").serialize(), url:"<c:url value='${paramMap._view_path}'/>/proc", async:false, showMessage:false});
            			    if (response.result == "true") {
            			    	$('#closeBtn').hide();
            			    	$("#alertBtn").hide();
            					$("#compBtn").show();
            	    			$('#alertText').html("등록 되었습니다.");
            	    			$('#compBtn').click(function(){
            	    				goReset();
            	    				$('#jsAlert').bPopup().close();
            	    			});

            			    }else {
            			    	$('#alertText').html("등록중 에러가 발생하였습니다.");
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
				createName : {required : true},
				title : {required : true},
				privateTypeCd: { required : true },
				contentDesc : {required : true, maxLengthCheck : 1000}
			},
			messages : {
				createName : {required : "등록자를 입력하세요"},
				title : {required : "제목을 입력하세요"},
				privateTypeCd: { required : "분류선택을 하세요", maxLengthCheck: "입력길이를 초과하였습니다." },
				contentDesc : {required : "내용을 입력하세요"}
			},
			onfocusout: function(element) {

	        },
			invalidHandler: function(form, validator) {
		        var errors = validator.numberOfInvalids();
		        if (errors) {
		            validator.errorList[0].element.focus();
		        }
		    }
	    });
	});

	function goList() {
		self.location.href = '/mypage/ask';
	}

	function goReset() {
		$("#form1")[0].reset();
		$("textarea").val("");
		$("#titleCount").text("(0/30자)");
		$("#contentCount").text("(0/1000자)");
		$("span[id$='-error']").remove();
		$('select').each( function() {
			$(this).find('option:first').attr('selected', 'selected');
			$(this).selectric('refresh');
	    });

	}

	/**
	 * 바이트 문자 입력가능 문자수 체크
	 *
	 * @param id : tag id
	 * @param title : tag title
	 * @param maxLength : 최대 입력가능 수 (byte)
	 * @returns {Boolean}
	 */
	function maxLengthCheck(values, maxLength){
	     if(Number(byteCheck(values)) > Number(maxLength)) {
	         return false;
	     } else {
	         return true;
	    }
	}

	/**
	 * 바이트수 반환
	 *
	 * @param el : tag jquery object
	 * @returns {Number}
	 */
	function byteCheck(values){
	    var codeByte = 0;
	    for (var idx = 0; idx < values.length; idx++) {
	        var oneChar = escape(values.charAt(idx));
	        if ( oneChar.length == 1 ) {
	            codeByte ++;
	        } else if (oneChar.indexOf("%u") != -1) {
	            codeByte += 2;
	        } else if (oneChar.indexOf("%") != -1) {
	            codeByte ++;
	        }
	    }
	    return codeByte;
	}


</script>