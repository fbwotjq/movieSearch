<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/resources/js/vod.js"></script> <!-- js for vod page -->
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">

<div id="contents">
			<div class="breadcrumb">
				<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
			</div>
			<div class="container">
				<div class="top-area pb1">
					<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
				</div>
				<form id="form1" name="form1" method="post">
				<sec:csrfInput/>
		        <input type="hidden" id="_page" name="_page" value="<c:out value='${paramMap._page}'/>"/>
		        <input type="hidden" id="searchType" name="searchType" value="<c:out value='${paramMap.searchType}'/>"/>
		        <input type="hidden" id="searchText" name="searchText" value="<c:out value='${paramMap.searchText}'/>"/>

					<section id="fieldset">

						<!-- profile -->
						<div class="mProfile type2">
							<div class="mImg1">
							<c:choose>
								<c:when test="${detailInfo.info.festImg != '' && detailInfo.info.festImg ne null}">
								<span style="background-image: url('${KF_FILM_IMAGE_PATH}/festival/${detailInfo.info.feNo}/${detailInfo.info.festImg}')"></span>
								</c:when>
								<c:when test="${detailInfo.info.image != '' && detailInfo.info.image ne null}">
								<span style="background-image: url('${KF_FILM_IMAGE_PATH}/festival/${detailInfo.info.image}')"></span>
								</c:when>
								<c:otherwise>
								<span style="background-image: url('/resources/images/common/noimage.gif')"></span>
								</c:otherwise>
							</c:choose>

							</div>
							<div class="text">
								<div class="nam">
									<div class="na1">${detailInfo.info.nameKor }</div>
									<div class="na2">${detailInfo.info.nameEng }</div>
								</div>
								<div class="desc">
									<dl>
									<dt>시작년도</dt>
									<dd>${detailInfo.info.minfedyear }년</dd>
									<dt>개최월</dt>
									<dd>${detailInfo.info.month }월</dd>
									</dl>
									<p class="des">
										${detailInfo.info.introduce }
									</p>
								</div>
							</div>
						</div>
						<!-- //profile -->

						<!-- slide tab -->
						<div class="mMenu1 type2">
							<!-- depth1 -->
							<div class="owl-carousel dep1 jsTab1" id="db-tab-menu3">
								<a href="#db-tab-menu4" class="selected">소장자료</a>
								<a href="#db-tab-menu4_2" >기본정보</a>
							</div>
							<!-- //depth1 -->
							<!-- depth2 for 소장자료 -->
							<div class="owl-carousel dep2" id="db-tab-menu4" >
								<c:if test="${detailInfo.cntInfo.mtotal > 0 }">
								<span class="ti"><strong>영상자료</strong>(${detailInfo.cntInfo.mtotal})</span>
								<a href="###">필름(${detailInfo.cntInfo.filmcnt})</a>
								<a href="###">D시네마(${detailInfo.cntInfo.dcinemacnt})</a>
								<a href="###">테이프(${detailInfo.cntInfo.tapecnt})</a>
								<a href="###">디스크(${detailInfo.cntInfo.diskcnt})</a>
								<a href="###">동영상(${detailInfo.cntInfo.moviecnt})</a>
								<a href="###">VOD(${detailInfo.cntInfo.vodcnt})</a>
								</c:if>
								<c:if test="${detailInfo.cntInfo.itotal > 0 }">
								<span class="ti"><strong>이미지</strong>(${detailInfo.cntInfo.itotal})</span>
								<a href="###">포스터(${detailInfo.cntInfo.postercnt})</a>
								<a href="###">스틸(${detailInfo.cntInfo.stilcnt})</a>
								</c:if>
								<c:if test="${detailInfo.cntInfo.btotal > 0 }">
								<span class="ti"><strong>문헌자료</strong>(${detailInfo.cntInfo.btotal})</span>
								<a href="###">시나리오/콘티(${detailInfo.cntInfo.scenariocnt})</a>
								<a href="###">전단(${detailInfo.cntInfo.handbillcnt})</a>
								<a href="###">도서(${detailInfo.cntInfo.bookcnt})</a>
								<a href="###">논문(${detailInfo.cntInfo.theorycnt})</a>
								<a href="###">심의서류(${detailInfo.cntInfo.censorshipcnt})</a>
								<a href="###">보도자료(${detailInfo.cntInfo.newscnt})</a>
								<a href="###">기타자료(${detailInfo.cntInfo.etccnt})</a>
								</c:if>
								<c:if test="${detailInfo.cntInfo.etotal > 0 }">
								<span class="ti"><strong>기타</strong>(${detailInfo.cntInfo.etotal})</span>
								<a href="###">OST(${detailInfo.cntInfo.ostcnt})</a>
								<a href="###">박물류(${detailInfo.cntInfo.equipcntequipcnt})</a>
								</c:if>
							</div>
							<!-- depth2 for 기본정보 -->
							<div class="owl-carousel dep2" id="db-tab-menu4_2" style="display:none;">

							</div>
							<!-- //depth2 -->
						</div>
						<!-- //slide tab -->

						<!-- search -->
						<div class="mSearch mt1">
							<div class="dbinfo-search">
								<input type="text" name="schtxt" id="schtxt" value="<c:out value='${paramMap.searchText}'/>" placeholder="리스트내 검색">
								<button class="ico-search" type="button" id="searchBtn"></button>
							</div>
							<div class="dbinfo-radio selector-wrap horizontal">
								<div class="asset type2">
									<label><input type="radio" name="fldname" id="" value="title" checked="checked"> <span class="label">회차</span></label>
								</div>
							</div>
						</div>
						<!-- //search -->

						<!-- 포스터 갤러리 -->
						<div class="result-block">
							<div class="result-block-tt type2">
								<h4>포스터 갤러리</h4>
							</div>
							<!-- list -->
							<div class="mImage10 mt1">
								<ul>
								<c:forEach var="item" items="${pageListVo.resultList}" varStatus="status">
								<li class="pt0">
									<a href="###" onclick="fncDetail('${item.feNo }','${item.fedNo }');">
										<span class="mImg1">
										<c:choose>
											<c:when test="${item.imageNm != '' && item.imageNm ne null}">
											<span style="background-image: url('${KF_FILM_IMAGE_PATH}/festival/${item.feNo}/${item.imageNm}')"></span>
											</c:when>
											<c:when test="${detailInfo.info.image != '' && detailInfo.info.image ne null}">
											<span style="background-image: url('${KF_FILM_IMAGE_PATH}/festival/${detailInfo.info.image}')"></span>
											</c:when>
											<c:otherwise>
											<span style="background-image: url('/resources/images/common/noimage.gif')"></span>
											</c:otherwise>
										</c:choose>
										</span>
										<span class="text"><c:out value="${item.fedTime}"/>회</span>
									</a>
								</li>
								</c:forEach>
								</ul>
							</div>
							<!--//list -->
							<div class="paging-area line">
								<!-- pagination -->
								<div class="pagination medium">
									${paging}
								</div>
								<!-- //pagination -->
							</div>
						</div>
						<!-- //포스터 갤러리 -->

					</section>
				</form>
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


});


function fncGoPage(nPage){
    $("#_page").val(nPage);

    var frm = document.form1;
    frm.target = "_self";
    frm.action = "<c:url value='${paramMap._view_path}'/>";
    frm.submit();
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

function fncDetail(feNo, fedNo){
    var frm = document.form1;
    frm.target = "_self";
    frm.action = "/db/festival/"+feNo+"/"+fedNo;
    frm.submit();
}

</script>