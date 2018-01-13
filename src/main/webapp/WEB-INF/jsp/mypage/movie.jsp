<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/resources/js/mypage.js"></script> <!-- js for mypage page -->
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/mypage.css">

<div id="contents">
			<div class="breadcrumb">
				<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
			</div>
			<div class="container">
				<div class="top-area">
					<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
					<%@ include file="/WEB-INF/jsp/common/include/common/common02.jsp"%>
				</div>
				<form id="form1" name="form1" method="post">
				<sec:csrfInput/>
		        <input type="hidden" id="gubun" name="gubun" value="<c:out value='${paramMap.gubun}'/>"/>
		        <input type="hidden" id="yearGubun" name="yearGubun" value="<c:out value='${paramMap.yearGubun}'/>"/>
		        <input type="hidden" id="monthGubun" name="monthGubun" value="<c:out value='${paramMap.monthGubun}'/>"/>
		        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
		        <input type="hidden" id="searchType" name="searchType" value="<c:out value='${paramMap.searchType}'/>"/>
		        <input type="hidden" id="searchText" name="searchText" value="<c:out value='${paramMap.searchText}'/>"/>
		        <input type="hidden" id="clipseqnoparam" value=""/>
		        <input type="hidden" id="snoparam" value=""/>

					<!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
					<section id="fieldset">

						<!-- button -->
						<div class="mButton3">
							<button class="btn xxlarge weightiest" type="button" onclick="location.href='/mypage/vod'"><span>결제권 구매내역 확인하기</span></button>
						</div>
						<!-- //button -->

						<!-- slide tab -->
						<div class="mMenu1 type2 nonavi">
							<!-- depth1 -->
							<div class="owl-carousel dep1 jsTab1" id="archives-tab-menu3">
								<c:forEach var="item" items="${result.category}" varStatus="status">
								<a href="javascript:fnGubun(<c:out value="${item.gubun }"/>, <c:out value="${item.cnt }"/>);" <c:if test="${item.gubun eq paramMap.gubun }">class='selected'</c:if>><c:out value='${item.sname}'/>(<c:out value="${item.cnt }"/>)</a>
								</c:forEach>
							</div>
							<!-- //depth1 -->
							<!-- depth2 -->
							<div class="owl-carousel dep2" id="archives-tab-dep2-1">
								<c:forEach var="item" items="${result.year}" varStatus="status">
								<a href="javascript:fnYear(<c:out value="${item.yearText }"/>);" <c:if test="${item.yearText eq paramMap.yearGubun }">class='selected'</c:if>>${item.yearText}</a>
								</c:forEach>
							</div>
							<!-- //depth2 -->
							<!-- dept3 -->
							<div class="owl-carousel dep3">
								<a href="javascript:fnMonth('0');" <c:if test="${paramMap.monthGubun eq '0' }">class='selected'</c:if>>전체</a>
								<c:forEach var="item" items="${result.month}" varStatus="status">
								<c:if test="${paramMap.yearGubun eq item.yearText }">
								<a href="javascript:fnMonth('<c:out value="${item.monthText }"/>');" <c:if test="${item.monthText eq paramMap.monthGubun }">class='selected'</c:if>>${item.monthText}</a>
								</c:if>
								</c:forEach>
							</div>
							<!-- //dept3 -->
						</div>
						<!-- //slide tab -->

						<!-- search -->
						<div class="mSearch">
							<div class="dbinfo-search">
								<input type="text" id="schtxt"  placeholder="리스트내 검색" value="<c:out value='${paramMap.searchText}'/>">
								<button class="ico-search" type="button" id="searchBtn"></button>
							</div>
							<div class="dbinfo-radio selector-wrap horizontal">
								<div class="asset type2">
									<label><input type="radio" name="fldname" id="" ${paramMap.searchType == "subject" ? 'checked="checked"' : ''} value="subject"> <span class="label">제목</span></label>
								</div>
								<div class="asset type2">
									<label><input type="radio" name="fldname" id="" ${paramMap.searchType == "director" ? 'checked="checked"' : ''} value="director"> <span class="label">감독</span></label>
								</div>
								<div class="asset type2">
									<label><input type="radio" name="fldname" id="" ${paramMap.searchType == "actor" ? 'checked="checked"' : ''} value="actor"> <span class="label">배우</span></label>
								</div>
							</div>


							<div class="gRt showMobile">
								<span class="lt"><a href="###" class="mBtn1 gray"><span class="iCalendar">캘린더</span></a></span>
								<span class="rt"><a href="###" class="mBtn1"><span class="iEdit jsBtnCategory">카테고리 편집</span></a></span>
							</div>
						</div>
						<!-- //search -->

						<!-- sort -->
						<div class="mSort1">
							<h4>전체게시물 (<span class="em weighty"><fmt:formatNumber	value="${pageListVo.totalCount }" type="number" /></span>)</h4>
							<div class="rt">
								<div class="dbinfo-table-sort">
									<div class="area">
										<label for="select1" class="blind">내림차순</label>
										<select name="" id="select1" class="select-tric">
											<option value="">내림차순</option>
											<option value="">오름차순</option>
										</select>
									</div>
									<div class="area">
										<label for="select2" class="blind">10개 출력</label>
										<select name="" id="select2" class="select-tric">
											<option value="">10개 출력</option>
											<option value="">20개 출력</option>
											<option value="">30개 출력</option>
											<option value="">50개 출력</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<!-- //sort -->

						<!-- module -->
						<div class="result-block-detail type2">
							<ul>

								<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
								<li class="detail-box">
									<div class="check">
										<label><input type="checkbox" name="clipSeqno" id="mymovie${status.index}" value="${item.clipSeqno}"></label>
									</div>
									<div class="details">
										<div class="movie-tt">
											<a href="javascript:fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>');" class="ftc-blue">
												<c:choose>
												 	<c:when test ="${item.levelClss == 'E' }">
												  	<i class="agelimit age19">제</i>
												 	</c:when>
												 	<c:when test ="${item.levelClss == 'B' || item.levelClss == '3' || item.levelClss == '6'}">
												  	<i class="agelimit age12">12</i>
												 	</c:when>
												 	<c:when test ="${item.levelClss == 'C' || item.levelClss == '2' || item.levelClss == '7'}">
												  	<i class="agelimit age15">15</i>
												 	</c:when>
												 	<c:when test ="${item.levelClss == 'D' || item.levelClss == '1' || item.levelClss == '8'}">
												  	<i class="agelimit age19">19</i>
												 	</c:when>
												 	<c:when test ="${item.levelClss == 'A' || item.levelClss == '4' || item.levelClss == '5'}">
												  	<i class="agelimit ageall">전</i>
												 	</c:when>
													<c:otherwise>
												  	<i class="agelimit ageall">전</i>
													</c:otherwise>
												</c:choose>
												<c:out value='${item.title}'/>

											</a>
											<c:if test="${item.cnt > 0}">
												<div class="vod forPc"><span onclick="javascript:fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>');">VOD</span></div> <!-- forPc -->
												</c:if>
										</div>
										<div class="movie-tt-eng"><c:out value='${item.titleEng}'/></div>
										<div class="national">
											<a href="#" class="ftc-blue"><span><c:out value='${item.typeClss}'/></span></a>,  <a href="#2" class="ftc-blue"><span><c:out value='${item.nationClss}'/></span></a>,
										</div>
										<div class="year">
											<span><c:out value='${item.prodYear}'/></span><span class="comma">,</span><span class="dots"><c:out value='${item.runtime}'/>분</span>
										</div>
										<div class="director">
											<span>감독</span>
											<div>
											<c:forEach var="item2" items="${item.directorList}" varStatus="status2">
											<a href="javascript:fcnPersonDetail('<c:out value="${item2.personId}"/>');" class="ftc-blue"><c:out value='${item2.personNm}'/></a><c:if test="${!status2.last}">,</c:if>
											</c:forEach>
											</div>
										</div>
										<div class="actor">
											<span>출연</span>
											<div>
											<c:forEach var="item3" items="${item.actorList}" varStatus="status3">
												<c:choose>
												 	<c:when test ="${item3.movieId eq 'F' }">
												  	<c:out value='${item3.personNm}'/><c:if test="${!status3.last}">,</c:if>
												 	</c:when>
													<c:otherwise>
												  	<a href="javascript:fcnPersonDetail('<c:out value="${item3.personId}"/>');" class="ftc-blue"><c:out value='${item3.personNm}'/></a><c:if test="${!status3.last}">,</c:if>
													</c:otherwise>
												</c:choose>
											</c:forEach>
											</div>
										</div>
										<div class="date type2">
											<c:if test="${item.cnt > 0}">
											<div class="vod forMobile"><span onclick="javascript:fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>');">VOD</span></div> <!-- forMobile -->
											</c:if>

											<c:choose>
											 	<c:when test ="${item.seedate == '0000-00-00' }">
											  	<div class="dat"><em>관람일</em> <span>미등록</span></div><a href="javascript:fnRegistForm('${item.clipSeqno}','${item.sno}');" class="btn type2">등록</a>
											 	</c:when>
												<c:otherwise>
											  	<div class="dat"><em>관람일</em> <c:out value='${item.seedate}'/></div><a href="javascript:fnEditForm('${item.clipSeqno}','${item.sno}','${item.seedate}');" class="btn">수정</a>
												</c:otherwise>
											</c:choose>

										</div>
									</div>
									<div class="poster">
										<a href="javascript:fcnMovieDetail('<c:out value="${item.movieId}"/>','<c:out value="${item.movieSeq}"/>');" class="ftc-blue">
											<c:choose>
											 	<c:when test ="${item.imageInfo != null }">
											  	<img src="<c:out value='${KF_FILM_IMAGE_PATH}'/>/thm/02/<c:out value='${item.imageInfo.imgPath}'/>/tn_<c:out value='${item.imageInfo.filename}'/>" alt="영화 포스터">
											 	</c:when>
												<c:otherwise>
											  	<img src="/resources/images/common/noimage.gif" alt="영화 포스터">
												</c:otherwise>
											</c:choose>
										</a>
									</div>
								</li>
								</c:forEach>
							</ul>
						</div>

						<div class="mButton1 mt1 left">
							<a href="javascript:fnRemove();" class="mBtn1 white inline">삭제</a>
						</div>

						<div class="paging-area">
							<!-- pagination -->
							<div class="pagination medium">
								${paging}
							</div>
							<!-- //pagination -->
						</div>

						<!-- module -->
					</section>
				</form>
			</div>
		</div>

		<!-- 관람일등록 -->
		<div class="mPopup1" id="jsRegister">
			<div class="popupBg">
				<h4 class="title">관람일 등록</h4>
				<div class="cont">
					<input type="text" id="labelBirthFrom" class="iCalendar" title="관람일 등록" placeholder="관람일 8자리 입력">
					<div class="mButton1">
						<button class="btn large weighty" type="button" onclick="fnRegist();">등록</button>
					</div>
				</div>
				<button type="button" class="b-close" title="닫기">닫기</button>
			</div>
		</div>

		<!-- 카테고리편집 -->
		<div class="mPopup1" id="jsCategory">
			<div class="popupBg">
				<h4 class="title">카테고리 편집</h4>
				<div class="cont">
					<div class="list mCustomScrollbar">
						<ul id="categoryList">
						<li class="add">
							<input type="text" id="categoryText" title="신규추가" placeholder="신규추가">
							<div class="rt">
								<a href="javascript:fnAddCategory();" class="iAdd">추가</a>
							</div>
						</li>
						<c:forEach var="item" items="${result.category}" varStatus="status">
						<c:if test="${item.gubun eq '3'}">
						<li>
							<input type="text" id="category_<c:out value='${item.sno}'/>" value="<c:out value='${item.sname}'/>">
							<div class="rt">
								<a href="javascript:fnCategoryEditOrigin(<c:out value='${item.sno}'/>);" class="iModify">수정</a>
								<a href="javascript:fnCategoryRemoveOrigin(<c:out value='${item.sno}'/>);" class="iMinus">삭제</a>
							</div>
						</li>
						</c:if>
						</c:forEach>
						</ul>
					</div>
					<div class="mButton1">
						<button class="btn large weighty" type="button" onclick="fnCategorySave();">저장</button>
					</div>
				</div>
				<button type="button" class="b-close" title="닫기">닫기</button>
			</div>
		</div>

		<div class="mPopup1" id="jsAlert">
		<div class="popupBg">
			<h4 class="title" id="alertText">삭제하시겠습니까?</h4>
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
$(document).ready(function(){
	$searchBtn = $('#searchBtn');
	$('#schtxt').keydown(function (e) {
		if(e.keyCode == 13){
			$searchBtn.trigger('click');
	    }
	});

	$searchBtn.on('click',function(e){
		e.preventDefault();
		fncSearch();
	});

	$('.jsBtnCategory').bind('click', function(e) {
		e.preventDefault();
		BPOPUP =  $('#jsCategory').bPopup({
			modalClose : true,
			opacity: 0.6,
			positionStyle: 'fixed'
		});
	});

	$("#jsCategory .iMinus").off('click');
	$("#jsCategory .iAdd").off('click');

	$.datepicker.setDefaults({
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear: true,
		yearSuffix: '.',
		maxDate: 0
	});

	$("#labelBirthFrom").datepicker();
});

function fncSearch() {

	if($('input:radio[name=fldname]').is(':checked') == false){
		return;
	}

	if($("#schtxt").val() == ""){
		return;
	}
	$("#_page").val("1");
	$("#searchType").val($(':radio[name="fldname"]:checked').val());
	$("#searchText").val($("#schtxt").val());

    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
}

function fnRemove(){
	if ($('input:checkbox[name=clipSeqno]:checked').length ==0) {
		alert('항목을 선택하세요');
		return;
	}

    var checkboxValues = [];
    $("input[name='clipSeqno']:checked").each(function(i) {
        checkboxValues.push($(this).val());
    });
    var allData = { "checkArray": checkboxValues };

    BPOPUP =  $('#jsAlert').bPopup({
		modalClose : false, //배경클릭시 창을 닫을지 여부
		opacity: 0.6,
		positionStyle: 'fixed',
		onOpen: function() {
			$('#alertText').html("삭제 하시겠습니까?");
			$("#alertBtn").off('click');
			$("#compBtn").off('click');
			$("#alertBtn").show();
			$("#compBtn").hide();
			$('#alertBtn').click(function(){

				var response = $.fnAjax({params:allData, url:"<c:url value='${paramMap._view_path}'/>/remove", async:false, showMessage:false});
			    if (response.result == "true") {
			    	$('#closeBtn').hide();
			    	$("#alertBtn").hide();
					$("#compBtn").show();
	    			$('#alertText').html("삭제 되었습니다.");
	    			$('#compBtn').click(function(){
	    				var frm = document.form1;
	    		        frm.target = "_self";
	    		        frm.action = "<c:url value='${paramMap._view_path}'/>";
	    		        frm.submit();
	    			});

			    }else {
			    	$('#alertText').html("삭제중 에러가 발생되었습니다.");
			    	$("#alertBtn").hide();
					$("#compBtn").show();
	    			$('#compBtn').click(function(){
	    				$('#jsAlert').bPopup().close();
	    			});
			    }

			});
		}
	});

}

function fnAddCategory(){

	if ($("#categoryText").val().length ==0) {
		return;
	}

	var allData = { "categoryName": encodeURIComponent($("#categoryText").val())};

	var response = $.fnAjax({params:allData, url:"<c:url value='${paramMap._view_path}'/>/category/check", async:false, showMessage:false});
    if (response.result == "true") {

    	var categoryTextValueCnt = $('.categoryTextValue').length;

    	var htmlText = '<li>';
    	htmlText += '<input type="text" id="categoryTextId_'+(categoryTextValueCnt+1)+'" class="categoryTextValue" value="'+$("#categoryText").val()+'">';
    	htmlText += '<div class="rt">';
    	htmlText += '<a href="javascript:fnRemoveRow('+(categoryTextValueCnt+1)+')" class="iMinus">삭제</a>';
    	htmlText += '</div>';
    	htmlText += '</li>';

    	$("#categoryList").append(htmlText);
    	$("#categoryText").val("");

		return;
    }else {
    	alert("이미 등록된 카테고리명 입니다.");
    	$("#categoryText").val("");
    	return;
    }
}
function fnRemoveRow(cnt){
	$("#categoryTextId_"+cnt).parent().remove();
}

function fnCategorySave(){

	if ($(".categoryTextValue").length ==0) {
		$('#jsCategory').bPopup().close();
		return;
	}

	BPOPUP =  $('#jsAlert').bPopup({
		modalClose : false, //배경클릭시 창을 닫을지 여부
		opacity: 0.6,
		positionStyle: 'fixed',
		onOpen: function() {

			$('#alertText').html("저장 하시겠습니까?");
			$("#alertBtn").off('click');
			$("#compBtn").off('click');
			$("#alertBtn").show();
			$("#compBtn").hide();

			$('#alertBtn').click(function(){

				var checkboxValues = [];
			    $(".categoryTextValue").each(function(i) {
			        checkboxValues.push(encodeURIComponent($(this).val()));
			    });

				var allData = { "categoryNameList": checkboxValues};

				var response = $.fnAjax({params:allData, url:"<c:url value='${paramMap._view_path}'/>/category/proc", async:false, showMessage:false});
				if (response.result == "true") {
					$('#alertText').html("저장 되었습니다.");
					$("#closeBtn").hide();
					$("#alertBtn").hide();
					$("#compBtn").show();
					$("#compBtn").off('click').click(function(){
						var frm = document.form1;
				        frm.target = "_self";
				        frm.action = "<c:url value='${paramMap._view_path}'/>";
				        frm.submit();
				        return;
					});

			    }else {
			    	$('#alertText').html("저장중 에러가 발생하였습니다.");
					$("#closeBtn").hide();
					$("#alertBtn").hide();
					$("#compBtn").show();
					$("#compBtn").off('click').click(function(){
						$('#jsAlert').bPopup().close();
					});
			    	return;
			    }

			});
		}
	});


}

function fnCategoryEditOrigin(sno){

	var editText = $("#category_"+sno).val();
	if (editText.length ==0) {
		return;
	}

	BPOPUP =  $('#jsAlert').bPopup({
		modalClose : true, //배경클릭시 창을 닫을지 여부
		opacity: 0.6,
		positionStyle: 'fixed',
		onOpen: function() {
			$('#alertText').html("수정 하시겠습니까?");
			$("#alertBtn").off('click');
			$("#compBtn").off('click').click(function(){
				$('#jsAlert').bPopup().close();
			});
			$("#alertBtn").show();
			$("#compBtn").hide();

			$('#alertBtn').click(function(){

				var allData = { "sno": sno, "editText": encodeURIComponent(editText)};

				var response = $.fnAjax({params:allData, url:"<c:url value='${paramMap._view_path}'/>/category/edit", async:false, showMessage:false});
				if (response.result == "true") {
					$('#alertBtn').hide();
					$('#compBtn').show();
					$('#alertText').html("수정 되었습니다.");
					return;
			    }else {
			    	$('#alertText').html("수정중 에러가 발생하였습니다.");
			    	$('#alertBtn').hide();
					$('#compBtn').show();
			    	return;
			    }

			});
		}
	});


}

function fnCategoryRemoveOrigin(sno){

	var editText = $("#category_"+sno).val();
	if (editText.length ==0) {
		return;
	}

	BPOPUP =  $('#jsAlert').bPopup({
		modalClose : true, //배경클릭시 창을 닫을지 여부
		opacity: 0.6,
		positionStyle: 'fixed',
		onOpen: function() {
			$('#alertText').html("삭제 하시겠습니까?");
			$("#alertBtn").off('click');
			$("#compBtn").off('click').click(function(){
				$('#jsAlert').bPopup().close();
			});
			$("#alertBtn").show();
			$("#compBtn").hide();
			$('#alertBtn').click(function(){
				var allData = { "sno": sno, "editText": encodeURIComponent(editText)};

				var response = $.fnAjax({params:allData, url:"<c:url value='${paramMap._view_path}'/>/category/remove", async:false, showMessage:false});
				if (response.result == "true") {
					$('#alertBtn').hide();
					$('#compBtn').show();
					$('#alertText').html("삭제 되었습니다.");
					$("#category_"+sno).parent().remove();
					return;
			    }else {
			    	$('#alertBtn').hide();
					$('#compBtn').show();
					$('#alertText').html("삭제중 에러가 발생하였습니다.");
			    	return;
			    }
			});
		}
	});


}
function fnGubun(gubun, cnt){
	if(cnt < 1){
		return;
	}
	$("#gubun").val(gubun);
	$("#yearGubun").val("0");
	$("#monthGubun").val("0");
	$("#_page").val("1");

	var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
}


function fnYear(year_){
	$("#yearGubun").val(year_);
	$("#monthGubun").val("0");
	$("#_page").val("1");

	var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
}


function fnMonth(month_){
	$("#monthGubun").val(month_);
	$("#_page").val("1");

	var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
}

function fnRegistForm(clipSeqNo, sno){
	$("#labelBirthFrom").val("");
	$("#clipseqnoparam").val(clipSeqNo);
	$("#snoparam").val(sno);
	BPOPUP =  $('#jsRegister').bPopup({
		modalClose : false,
		opacity: 0.6,
		zIndex: 9990,
		positionStyle: 'fixed'
	});

}

function fnEditForm(clipSeqNo, sno, seedate){
	$("#labelBirthFrom").val(seedate);
	$("#clipseqnoparam").val(clipSeqNo);
	$("#snoparam").val(sno);
	BPOPUP =  $('#jsRegister').bPopup({
		modalClose : false,
		opacity: 0.6,
		zIndex: 9990,
		positionStyle: 'fixed'
	});

}

function fnRegist(){
	if($("#labelBirthFrom").val() == ""){
		return;
	}

	var seeDate = $("#labelBirthFrom").val();

	BPOPUP =  $('#jsAlert').bPopup({
		modalClose : false, //배경클릭시 창을 닫을지 여부
		opacity: 0.6,
		positionStyle: 'fixed',
		onOpen: function() {

			$('#alertText').html("저장 하시겠습니까?");
			$("#alertBtn").off('click');
			$("#compBtn").off('click');
			$("#alertBtn").show();
			$("#compBtn").hide();

			$('#alertBtn').click(function(){

				var allData = { "seeDate": seeDate, "clipSeqno":$("#clipseqnoparam").val(), "sno":$("#snoparam").val()};

				var response = $.fnAjax({params:allData, url:"<c:url value='${paramMap._view_path}'/>/see/regist", async:false, showMessage:false});
				if (response.result == "true") {
					$('#alertText').html("저장 되었습니다.");
					$("#closeBtn").hide();
					$("#alertBtn").hide();
					$("#compBtn").show();
					$("#compBtn").off('click').click(function(){
						var frm = document.form1;
				        frm.target = "_self";
				        frm.action = "<c:url value='${paramMap._view_path}'/>";
				        frm.submit();
				        return;
					});

			    }else {
			    	$('#alertText').html("저장중 에러가 발생하였습니다.");
					$("#closeBtn").hide();
					$("#alertBtn").hide();
					$("#compBtn").show();
					$("#compBtn").off('click').click(function(){
						$('#jsAlert').bPopup().close();
					});
			    	return;
			    }

			});
		}
	});
}

</script>