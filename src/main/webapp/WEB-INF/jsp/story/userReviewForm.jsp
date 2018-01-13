<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/resources/js/movie.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/movie.css">
<script type="text/javascript" src="<c:url value="/resources/ckeditor/ckeditor.js" />"></script>

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
					<input type="hidden" id="movieId" name="movieId" value=""/>
					<input type="hidden" id="movieSeq" name="movieSeq" value=""/>
					<sec:csrfInput/>

					<!-- module -->
					<fieldset class="fieldset type2">
						<legend>개인정보 수집 이용에 관한 동의사항</legend>
						<div class="field">
							<div class="label">
								<label>등록자</label>
							</div>
								<div class="insert">
									<input type="text" name="createName" id="createName" placeholder="등록자">
								</div>
							</div>
							<div class="field">
							<div class="label">
								<label for="labelWork">작품</label>
							</div>
							<div class="insert type2">
								<a href="#none" class="bt" >작품선택</a>
								<input type="text" id="labelWork" title="작품" readonly >
							</div>
						</div>
						<div class="field">
							<div class="label">
								<label for="labelTitle">제목 <span class="ts">(30자)</span></label>
							</div>
							<div class="insert">
								<input type="text" name="title" id="title"  title="제목" placeholder="제목입력" maxlength="30">
							</div>
						</div>
						<div class="field textarea-box">
							<div class="label">
								<label for="labelContent">
									내용 <span class="ts" id="counter">(0/1000자)</span>
									<span class="tx">내용입력</span>
								</label>
							</div>
							<div class="insert">
								<textarea id="contentDesc" name="contentDesc"></textarea>
							</div>
						</div>
						<div class="mButton1 col2">
							<span class="lt"><button class="btn large weighty gray" type="button" onclick="fncGoList();">취소하기</button></span>
							<span class="rt"><button class="btn large weighty" >등록하기</button></span>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>


	<!-- layer -->
	<div class="mLayer1" style="display: none;" id="mLayer1">
		<div class="modalBg"></div>
		<div class="layerBg">
		<div class="cont">
			<div class="title">
				<h3>사용자 리뷰 영화검색</h3>
			</div>
			<div class="">
				<div class="dbinfo-search">
				<form id="form2" name="form2" method="post">
					<input type="hidden" id="_page" name="_page" value=""/>
					<input type="hidden" id="idx" name="idx" value="<c:out value='${preNextMap.idx}'/>"/>
					<input type="hidden" id="keywordref" name="keywordref" value="<c:out value='${preNextMap.keywordref}'/>"/>
		        	<input type="hidden" id="searchType" name="searchType" value=""/>
		        	<input type="hidden" id="searchText" name="searchText" value=""/>
					<input type="text" placeholder="영화명 검색"  id="schText" name="" value="<c:out value='${searchText}'/>">
					<button class="ico-search" type="button" id="searchBtn"></button>
				</form>
				</div>
				<div class="total-search-cont">
									<div class="total-search-cont">
									<div class="result-block movie-area" id="korDiv">
										<div class="result-block-tt"><h4>한국영화 (<span class="em weighty">0</span>)</h4></div>
										<div class="no-data-area">
											<div class="ico-nodata"></div>
											<p>정보가 없습니다.</p>
										</div>
									</div>
									<div class="result-block movie-area" id="engDiv">
										<div class="result-block-tt"><h4>외국영화 (<span class="em weighty">0</span>)</h4></div>
										<div class="no-data-area">
											<div class="ico-nodata"></div>
											<p>정보가 없습니다.</p>
										</div>
									</div>
				</div>
			</div>
			</div>

			<a href="###" class="iClose">팝업 닫기</a>
		</div>
	</div>
	<!-- //layer -->

<script type="text/javascript">
	$(document).ready(function() {
		var editor = CKEDITOR.replace('contentDesc', {
	        width : '100%',
	        height : '200px'
	    });

		/* CKEDITOR.instances.contentDesc.on('change', function(e) {
			var content = $(this).val();
	          $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
	          $('#counter').html(content.length + '/1000자');
		}); */

		editor.document.on('keyup',function(){alert('kek')});



		$('#title').change(function() {
			if($(this).val()){
				$('#title-error').hide();
			}else{
				if($('#title-error').length > 0){
					$('#title-error').show();
				}
			}
		});

		$.validator.addMethod("maxLengthCheck", function(value, element, param) {
		    return this.optional(element) || maxLengthCheck(value, param);
		}, $.validator.format("내용은 {0}자만 입력 가능합니다."));


		$("#form1").validate({
            submitHandler: function(form) {

            	if (confirm("등록 하시겠습니까?") == false) {
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
                }
                return false;
            },
			rules : {
				createName : {required : true},
				title : {required : true},
				contentDesc: {required: function () {
		               if(CKEDITOR && CKEDITOR.instances && CKEDITOR.instances.contentDesc){
		                   CKEDITOR.instances.contentDesc.updateElement();
		               }else{
		                   true;
		               }
		           }}
			},
			messages : {
				createName : {required : "등록자를 입력하세요"},
				title : {required : "제목을 입력하세요", maxLengthCheck: "입력길이를 초과하였습니다." },
				contentDesc : {required : "내용을 입력하세요"}
			},
			invalidHandler: function(form, validator) {
		        var errors = validator.numberOfInvalids();
		        if (errors) {
		            validator.errorList[0].element.focus();
		        }
		    }
	    });


	/* 	$(".bt").bind('click',function(e) {
			$('.mLayer1').bPopup();
		}); */


		 $(".bt").bind('click',function(e) {
			 e.preventDefault();
			 $('#mLayer1').bPopup({
				  //  content:'iframe',
				  //  contentContainer:'.content',
				  //  loadUrl:'/story/search/pop'
				});
		 });

		 $searchBtn = $('#searchBtn');
			$('#schText').keydown(function (e) {
				if(e.keyCode == 13){
					e.preventDefault();
					$searchBtn.trigger('click');
			    }
		 });

			$searchBtn.on('click',function(e){
				e.preventDefault();
				fncSearch();
		 });

	});


	function fncSearch(){
		if($('#schText').val() == ""){
			return;
		}
		$('#searchText').val($('#schText').val());

		$("#korDiv").html("");
		$("#engDiv").html("");
		$('#wrap').spin();

		fncGoPage_K(1);
		fncGoPage_E(1);
		return false;
	}

	function fncGoPage_K(page_){
		$('#searchType').val("K");
		$('#_page').val(page_);

		$.ajax({
		    url: "<c:url value='${paramMap._list_path}'/>/listpage",
			type: 'POST',
			dataType: 'html',
			beforeSend : function(xhr) {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				xhr.setRequestHeader(header, token);
			},
			data: $("#form2").serialize(),
			success: function(data) {
				$('#wrap').spin(false);
	      		$("#korDiv").html(data);
	        }
		});

	}

	function fncGoPage_E(page_){
		$('#searchType').val("E");
		$('#_page').val(page_);
		$.ajax({
		    url: "<c:url value='${paramMap._list_path}'/>/listpage",
			type: 'POST',
			dataType: 'html',
			beforeSend : function(xhr) {
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				xhr.setRequestHeader(header, token);
			},
			data: $("#form2").serialize(),
			success: function(data) {
				$('#wrap').spin(false);
	      		$("#engDiv").html(data);
	        }
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

	 function fncGoList() {
		    var frm = document.form1;
		    frm.target = "_self";
		    frm.action = "<c:url value='/story/user'/>";
		    frm.submit();
	}

	function fncSelectMovie(pMovieId, pMovieSeq, pTitle, pOrgTit, pProdYear, pDirector, pNationClss, pNationalClss) {
	    try {
	        var resultData = {
	        	    movieId:pMovieId
	        	   ,movieSeq:pMovieSeq
	        	   ,title:pTitle
	        	   ,orgTit:pOrgTit
	        	   ,prodYear:pProdYear
	        	   ,director:pDirector
	        	   ,nationClass:pNationClss
	        	   ,nationalClss:pNationalClss
	        };
	        opener.movieSearchCallback(JSON.stringify(resultData));
	    }catch (e) {
	    }
	}


	function fncProc(movieTitle, movieId, movieSeq, nationalClss){
		document.getElementById("labelWork").value = movieTitle;
		document.getElementById("movieId").value = movieId;
		document.getElementById("movieSeq").value = movieSeq;
		 $("#mLayer1").bPopup().close();
	}

</script>
