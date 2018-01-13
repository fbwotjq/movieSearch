<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">

<div id="contents">
			<div class="breadcrumb">
				<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
			</div>
			<div class="container">
				<div class="top-area">
					<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
					<div class="submenu-depth3">
						<h3 class="mTitle1"><span>#<c:out value='${preNextMap.keywordname}'/></span></h3>
					</div>
				</div>
				<div class="dbinfo">

						<section id="fieldset">
							<legend>자료검색</legend>
							<div class="total-search">
								<div class="dbinfo-search">
									<form id="form1" name="form1" method="post">
									<sec:csrfInput/>
							        <input type="hidden" id="_page" name="_page" value=""/>
							        <input type="hidden" id="idx" name="idx" value="<c:out value='${preNextMap.idx}'/>"/>
							        <input type="hidden" id="keywordref" name="keywordref" value="<c:out value='${preNextMap.keywordref}'/>"/>
		        					<input type="hidden" id="searchType" name="searchType" value=""/>
		        					<input type="hidden" id="searchText" name="searchText" value=""/>
									<input type="text" placeholder="리스트내 검색"  id="schText" value="">
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
						</section>
				</div>
			</div>
		</div>

<script type="text/javascript">
$(document).ready(function(){
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
		data: $("#form1").serialize(),
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
		data: $("#form1").serialize(),
		success: function(data) {
			$('#wrap').spin(false);
      		$("#engDiv").html(data);
        }
	});
}

function fncProc(objId, movieId, movieSeq, nationalClss){

	if($("#"+objId).val() == ""){
		return;
	}

	if (confirm("등록 하시겠습니까?") == false) {
        return;
    }

	var response = $.fnAjax({
		params:{	movieId: movieId,
		movieSeq: movieSeq,
		nationalClss: nationalClss,
		keywordRef: $("#keywordref").val(),
		memo: $("#"+objId).val()
	}, url:"<c:url value='${paramMap._list_path}'/>/proc"
	, async:false
	, showMessage:false});

    if (response.result == "true") {
    	if(response.resultCnt == "0"){
    		alert('해당 키워드에 선택된 영화가 등록되었습니다.\n관리자 승인후 노출 됩니다.');
    	}else{
    		alert('이미등록된 영화 또는 미승인된 영화입니다.');
    	}
    	$("#"+objId).val("");
		return;
    }else {
    	alert("해당 키워드에 선택된 영화가 등록중 에러가 발생하였습니다.");
    	return;
    }
    return false;

}


function fncPersonDetailGo(personId){
	if(personId == "") return false;

	fcnPersonDetail(personId);
}
</script>