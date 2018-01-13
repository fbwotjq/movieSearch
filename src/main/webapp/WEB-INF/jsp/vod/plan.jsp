<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/resources/js/vod.js"></script> <!-- js for vod page -->
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/vod.css">

<div id="contents">
			<div class="breadcrumb">
				<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
			</div>
			<div class="container">
				<div class="top-area">
					<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
					<%@ include file="/WEB-INF/jsp/common/include/common/common02.jsp"%>
				</div>

				<!-- 서브메뉴영역과 콘텐츠 사이에 라인 간격이 필요한 부분이 예외적으로 있습니다(디자이너지정이나 psd 상에 있음). 그럴때 class="topmrg_type1" 를 부여해 주세요.-->
				<section id="fieldset">

				<form id="form1" name="form1" method="post">
				<sec:csrfInput/>
		        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
		        <input type="hidden" id="_pageSize" name="_pageSize" value="<c:out value='${paramMap._pageSize}'/>"/>
		        <input type="hidden" id="_pageTotal" name="_pageTotal" value="<c:out value='${pageTotal}'/>"/>
		        <input type="hidden" id="searchType" name="searchType" value="<c:out value='${paramMap.searchType}'/>"/>
		        <input type="hidden" id="searchText" name="searchText" value="<c:out value='${paramMap.searchText}'/>"/>


					<!-- search -->
					<div class="mSearch">
						<div class="dbinfo-search">
							<input type="text" name="schtxt" id="schtxt" value="<c:out value='${paramMap.searchText}'/>" placeholder="리스트내 검색">
							<button class="ico-search" type="button" id="searchBtn"></button>
						</div>
						<div class="dbinfo-radio selector-wrap horizontal">
							<div class="asset type2">
								<label><input type="radio" name="fldname" id="" ${paramMap.searchType == "title" ? 'checked' : ''} value="title"> <span class="label">제목</span></label>
							</div>
							<div class="asset type2">
								<label><input type="radio" name="fldname" id="" ${paramMap.searchType == "contents" ? 'checked' : ''}  value="contents"> <span class="label">내용</span></label>
							</div>
							<div class="asset type2">
								<label><input type="radio" name="fldname" id="" value="xxxx"> <span class="label">영화</span></label>
							</div>
						</div>
					</div>
					<!-- //search -->
				</form>
					<!-- list -->
					<div class="mImage5">
						<!-- sort -->
						<div class="mSort1">
							<h4>전체게시물(<span class="em weighty"><fmt:formatNumber	value="${pageListVo.totalCount }" type="number" /></span>)</h4>
						</div>
						<!-- //sort -->
						<ul id="eventListView">
						<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
							<li>
								<a href="#none" onclick="fncDetail('<c:out value="${item.planSeq }"/>'); return false;">
									<div class="mImg1"><span style="background-image: url('<c:out value="${VOD_PLAN_IMG_PATH}"/><c:out value="${item.fileName}"/>')"></span></div>
									<div class="text">
										<span class="tit"><c:out value="${item.title}"/></span>
										<span class="des">
										<c:out value="${item.summaryDesc}" escapeXml="false"/>
										</span>
										<span class="dat"><c:out value="${item.startDateFormat}"/> ~ <c:out value="${item.endDateFormat}"/></span>
									</div>
								</a>
							</li>
						</c:forEach>
						</ul>
						<div class="paging-area">
							<!-- pagination -->
							<div class="pagination medium">
								${paging}
							</div>
							<!-- //pagination -->
						</div>

					</div>
					<!-- //list -->

				</section>
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

	if($(':radio[name="fldname"]:checked').length < 1){
		$('input[name="fldname"]:radio[value="title"]').prop('checked',true);
	}


});


function fncGoPage(nPage){
    $("#_page").val(nPage);

    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
}

function fncMoreBtn(){
    var nPage = Number($("#_page").val());
    var nTotPage = Number($("#_pageTotal").val());
    $("#_page").val(nPage + 1);

    var response = $.fnAjax({params:$("#form1").serialize(), url:"<c:url value='${paramMap._view_path}'/>/page/ajax", async:false, showMessage:false});
    if(response.result == 'Y'){
    	var getHtml = $("#eventListView").html() ;

    	var htmlText = "";
    	for (i = 0; i < response.pageListVo.resultList.length; i++) {
    		htmlText += '<li><a href="#none" onclick="fncDetail('+response.pageListVo.resultList[i].planSeq+'); return false;">';
    		//htmlText += '<div class="mImg1"><span style="background-image: url(\"'+VOD_PLAN_IMG_PATH+response.pageListVo.resultList[i].fileName+'\")"> </span></div>  ';
    		htmlText += '<div class="mImg1"><span';
    		htmlText += " style=\"background-image: url('"+encodeURI("http://kmdbadm.innodis.co.kr/upload/kmdbupload/mainContent/d540eebd-f681-4197-980d-4c3de184acd8.jpg")+"');\">";
    		htmlText += '</span></div>';
    		htmlText += '<div class="text">';
    		htmlText += '<span class="tit">'+response.pageListVo.resultList[i].title+'</span>';
    		htmlText += '<span class="des">'+response.pageListVo.resultList[i].summaryDesc+'</span>';
    		htmlText += '<span class="dat">'+response.pageListVo.resultList[i].startDate+' ~ '+response.pageListVo.resultList[i].endDate+'</span>';
    		htmlText += '</div>';
    		htmlText += '</a></li>';
        }

    	$("#eventListView").html(getHtml + htmlText);

    	if((nPage+2) >= nTotPage){
    		$("#moreBtnView").hide();
    	}
    }

    return false;
}

function fncSearch() {
	$("#_page").val("1");

	$("#searchType").val($('input[name="fldname"]:checked').val());
	$("#searchText").val($("#schtxt").val());

    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
}

function fncDetail(planSeq){
    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>"+"/"+planSeq;
    frm.submit();
}

</script>