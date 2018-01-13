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

						<!-- 수상정보 -->
						<div class="result-block pt0">
							<div class="result-block-tt type2 lineForMobile">
								<h4>수상정보</h4>
							</div>
							<!-- list -->

							<!-- date -->
							<c:forEach var="item" items="${result.awardYearList}" varStatus="status">
							<div class="mDate1 year_div_class" id="${item.fedYear}_DIV" <c:if test="${item.fedNo != paramMap.fedNo}">style="display:none;"</c:if> >
								<div class="dep1">
									<strong class="date">
										<a class="iPrev" href="javascript:fnMoveYear(<c:out value='${item.prevFedYear}'/>)">이전 년도</a>
										${item.fedYear}
										<a class="iNext" href="javascript:fnMoveYear(<c:out value='${item.nextFedYear}'/>)">다음 년도</a>
									</strong>
								</div>
								<div class="dep2">
									<span class="lst">
									<c:forEach var="item" items="${item.subList}" varStatus="status">
										<a href="###"  onclick="goDetail(${item.feNo},${item.fedNo});">${item.fedYear}</a>
									</c:forEach>
									</span>
								</div>
							</div>
							</c:forEach>
							<!-- //date -->

							<c:forEach var="itemAward" items="${result.awardList}" varStatus="statusAward">
								<c:if test="${statusAward.first}">
								<h5 class="mTitle3"><strong><c:out value='${itemAward.fedTime}'/></strong>회 <strong><c:out value='${itemAward.fedYear}'/></strong>년</h5>
								</c:if>
							</c:forEach>

							<table border="1" class="data-table medium transform-m">
								<caption>심의서류 테이블</caption>
								<colgroup>
									<col style="width:7%">
									<col style="*">
									<col style="width:32.5%">
									<col style="width:8.5%">
									<col style="width:18.5%">
								</colgroup>
								<thead>
								<tr>
									<th scope="col">순번</th>
									<th scope="col">수상부문</th>
									<th scope="col">작품명</th>
									<th scope="col">제작년도</th>
									<th scope="col">수상자</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach var="item3" items="${result.awardList}" varStatus="status3">
								<tr>
									<td class="num">${status3.count }</td>
									<td class="title nobar"><a href="javascript:void(0);">${item3.feaAword }</a></td>
									<td>${item3.feaMovie }</td>
									<td>${item3.feaYear }</td>
									<td>${item3.fPersName }</td>
								</tr>
								</c:forEach>
								</tbody>
							</table>
							<!--//list -->
						</div>
						<!-- //수상정보 -->


					</section>
				</form>
			</div>
		</div>

<script type="text/javascript">
$(document).ready(function(){


});

function goDetail(feNo, fedNo){
	 var frm = document.form1;
	    frm.target = "_self";
	    frm.action = "/db/festival/"+feNo+"/"+fedNo+"/award";
	    frm.submit();
}

function fnMoveYear(yearObj){
	if(yearObj != '-1'){
		$(".year_div_class").hide();
		$("#"+yearObj+"_DIV").show();
	}
}
</script>