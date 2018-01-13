<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<script type="text/javascript" src="/resources/js/db.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/db.css">


<div id="contents">
			<div class="breadcrumb">
				<%@ include file="/WEB-INF/jsp/common/include/common/common03.jsp"%>
			</div>
			<div class="container">
				<div class="top-area">
					<%@ include file="/WEB-INF/jsp/common/include/common/common01.jsp"%>
				</div>
				<form id="form1" name="form1" method="post">
				        <input type="hidden" id="feNo" name="feNo" value="<c:out value='${paramMap.feNo}'/>"/>
				        <input type="hidden" id="fedNo" name="fedNo" value="<c:out value='${paramMap.fedNo}'/>"/>
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
										<c:out value="${detailInfo.info.introduce}" escapeXml="false"/>
									</p>
								</div>
							</div>
						</div>
						<!-- //profile -->

						<!-- slide tab -->
						<div class="mMenu1 type2">
							<!-- depth1 -->
							<div class="owl-carousel dep1 jsTab1" id="db-tab-menu3">
								<c:if test="${detailInfo.cntInfo.mtotal > 0 || detailInfo.cntInfo.itotal > 0 || detailInfo.cntInfo.btotal > 0 || detailInfo.cntInfo.etotal > 0 }">
								<a href="#db-tab-menu4" >소장자료</a>
								</c:if>
								<a href="#db-tab-menu4_2" class="selected">기본정보</a>
							</div>
							<!-- //depth1 -->
							<!-- depth2 for 소장자료 -->
							<c:if test="${detailInfo.cntInfo.mtotal > 0 || detailInfo.cntInfo.itotal > 0 || detailInfo.cntInfo.btotal > 0 || detailInfo.cntInfo.etotal > 0 }">
							<div class="owl-carousel dep2" id="db-tab-menu4" style="display:none;">
								<c:if test="${detailInfo.cntInfo.mtotal > 0 }">
								<span class="ti"><strong>영상자료</strong>(${detailInfo.cntInfo.mtotal})</span>
								</c:if>
								<c:if test="${detailInfo.cntInfo.filmcnt > 0 }"><a href="###">필름(${detailInfo.cntInfo.filmcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.dcinemacnt > 0 }"><a href="###">D시네마(${detailInfo.cntInfo.dcinemacnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.tapecnt > 0 }"><a href="###">테이프(${detailInfo.cntInfo.tapecnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.diskcnt > 0 }"><a href="###">디스크(${detailInfo.cntInfo.diskcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.moviecnt > 0 }"><a href="###">동영상(${detailInfo.cntInfo.moviecnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.vodcnt > 0 }"><a href="###">VOD(${detailInfo.cntInfo.vodcnt})</a></c:if>

								<c:if test="${detailInfo.cntInfo.itotal > 0 }">
								<span class="ti"><strong>이미지</strong>(${detailInfo.cntInfo.itotal})</span>
								</c:if>
								<c:if test="${detailInfo.cntInfo.postercnt > 0 }"><a href="###">포스터(${detailInfo.cntInfo.postercnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.stilcnt > 0 }"><a href="###">스틸(${detailInfo.cntInfo.stilcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.btotal > 0 }">
								<span class="ti"><strong>문헌자료</strong>(${detailInfo.cntInfo.btotal})</span>
								</c:if>
								<c:if test="${detailInfo.cntInfo.scenariocnt > 0 }"><a href="###">시나리오/콘티(${detailInfo.cntInfo.scenariocnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.handbillcnt > 0 }"><a href="###">전단(${detailInfo.cntInfo.handbillcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.bookcnt > 0 }"><a href="###">도서(${detailInfo.cntInfo.bookcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.theorycnt > 0 }"><a href="###">논문(${detailInfo.cntInfo.theorycnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.censorshipcnt > 0 }"><a href="###">심의서류(${detailInfo.cntInfo.censorshipcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.newscnt > 0 }"><a href="###">보도자료(${detailInfo.cntInfo.newscnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.etccnt > 0 }"><a href="###">기타자료(${detailInfo.cntInfo.etccnt})</a></c:if>

								<c:if test="${detailInfo.cntInfo.etotal > 0 }">
								<span class="ti"><strong>기타</strong>(${detailInfo.cntInfo.etotal})</span>
								</c:if>
								<c:if test="${detailInfo.cntInfo.ostcnt > 0 }"><a href="###">OST(${detailInfo.cntInfo.ostcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.equipcntequipcnt > 0 }"><a href="###">박물류(${detailInfo.cntInfo.equipcntequipcnt})</a></c:if>
							</div>
							<!-- depth2 for 기본정보 -->
							<div class="owl-carousel dep2" id="db-tab-menu4_2">
								<c:if test="${detailInfo.cntInfo.mtotal > 0 }">
								<span class="ti"><strong>영상자료</strong>(${detailInfo.cntInfo.mtotal})</span>
								</c:if>
								<c:if test="${detailInfo.cntInfo.filmcnt > 0 }"><a href="###">필름(${detailInfo.cntInfo.filmcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.dcinemacnt > 0 }"><a href="###">D시네마(${detailInfo.cntInfo.dcinemacnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.tapecnt > 0 }"><a href="###">테이프(${detailInfo.cntInfo.tapecnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.diskcnt > 0 }"><a href="###">디스크(${detailInfo.cntInfo.diskcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.moviecnt > 0 }"><a href="###">동영상(${detailInfo.cntInfo.moviecnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.vodcnt > 0 }"><a href="###">VOD(${detailInfo.cntInfo.vodcnt})</a></c:if>

								<c:if test="${detailInfo.cntInfo.itotal > 0 }">
								<span class="ti"><strong>이미지</strong>(${detailInfo.cntInfo.itotal})</span>
								</c:if>
								<c:if test="${detailInfo.cntInfo.postercnt > 0 }"><a href="###">포스터(${detailInfo.cntInfo.postercnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.stilcnt > 0 }"><a href="###">스틸(${detailInfo.cntInfo.stilcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.btotal > 0 }">
								<span class="ti"><strong>문헌자료</strong>(${detailInfo.cntInfo.btotal})</span>
								</c:if>
								<c:if test="${detailInfo.cntInfo.scenariocnt > 0 }"><a href="###">시나리오/콘티(${detailInfo.cntInfo.scenariocnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.handbillcnt > 0 }"><a href="###">전단(${detailInfo.cntInfo.handbillcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.bookcnt > 0 }"><a href="###">도서(${detailInfo.cntInfo.bookcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.theorycnt > 0 }"><a href="###">논문(${detailInfo.cntInfo.theorycnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.censorshipcnt > 0 }"><a href="###">심의서류(${detailInfo.cntInfo.censorshipcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.newscnt > 0 }"><a href="###">보도자료(${detailInfo.cntInfo.newscnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.etccnt > 0 }"><a href="###">기타자료(${detailInfo.cntInfo.etccnt})</a></c:if>

								<c:if test="${detailInfo.cntInfo.etotal > 0 }">
								<span class="ti"><strong>기타</strong>(${detailInfo.cntInfo.etotal})</span>
								</c:if>
								<c:if test="${detailInfo.cntInfo.ostcnt > 0 }"><a href="###">OST(${detailInfo.cntInfo.ostcnt})</a></c:if>
								<c:if test="${detailInfo.cntInfo.equipcntequipcnt > 0 }"><a href="###">박물류(${detailInfo.cntInfo.equipcntequipcnt})</a></c:if>
							</div>
							</c:if>
							<!-- //depth2 -->
						</div>
						<!-- //slide tab -->

						<!-- 이미지 -->
						<c:if test="${fn:length(detailInfo.ownImgList) > 0}">
						<div class="result-block pt0">
							<div class="result-block-tt type2">
								<h4>이미지 (<span class="em weighty"><c:out value="${fn:length(detailInfo.ownImgList)}"/></span>)</h4>
								<a href="###" class="iMore1">더보기</a>
							</div>
							<!-- list -->
							<div class="mList8">
								<ul>
								<c:forEach var="itemOwn1" items="${detailInfo.ownImgList}" varStatus="statusAward1">
								<c:if test="${statusAward1.count < 4}">
								<li>
									<a href="#url" onclick="fcnMovieDetail(${itemOwn1.movieId}, ${itemOwn1.movieSeq});">
										<span class="mImg1">
										<c:set var="imgPath" value="${itemOwn1.imgPath}" />
										<sec:authorize access="isAnonymous()">
											<c:if test="${itemOwn1.prohibit19 eq 'Y' || itemOwn1.prohibit19 eq 'y'}"><c:set var="imgPath" value="/resources/images/common/poster_adult.jpg" /></c:if>
										</sec:authorize>
										<span style="background-image: url('${imgPath}')"></span>
										</span>
										<span class="text row2"><em>영화제</em> ${itemOwn1.mainTitle}, : ${itemOwn1.titleSub} [${itemOwn1.titleEtc}]</span>
									</a>
								</li>
								</c:if>
								</c:forEach>
								<c:forEach var="itemOwn2" items="${detailInfo.ownImgList}" varStatus="statusAward2">
								<c:if test="${statusAward2.count < 4}">
								<li class="forPc">
									<a href="#url" onclick="fcnMovieDetail(${itemOwn2.movieId}, ${itemOwn2.movieSeq});">
										<span class="mImg1">
										<c:set var="imgPath" value="${itemOwn2.imgPath}" />
										<sec:authorize access="isAnonymous()">
											<c:if test="${itemOwn2.prohibit19 eq 'Y' || itemOwn2.prohibit19 eq 'y'}"><c:set var="imgPath" value="/resources/images/common/poster_adult.jpg" /></c:if>
										</sec:authorize>
										<span style="background-image: url('${imgPath}')"></span>
										</span>
										<span class="text row2"><em>영화제</em> ${itemOwn2.mainTitle}, : ${itemOwn2.titleSub} [${itemOwn2.titleEtc}]</span>
									</a>
								</li>
								</c:if>
								</c:forEach>
								</ul>
							</div>
							<!--//list -->
						</div>
						</c:if>
						<!-- //이미지 -->

						<!-- 수상정보 -->
						<div class="result-block">
							<div class="result-block-tt type2 noline">
								<h4>수상정보</h4>
								<a href="###" class="iMore1" onclick="fncAwordInfo();">더보기</a>
							</div>
							<c:forEach var="itemAward" items="${detailInfo.awardList}" varStatus="statusAward">
								<c:if test="${statusAward.first}">
								<h5 class="mTitle3"><strong><c:out value='${itemAward.fedTime}'/></strong>회 <strong><c:out value='${itemAward.fedYear}'/></strong>년</h5>
								</c:if>
							</c:forEach>
							<!-- list -->
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
								<c:forEach var="item" items="${detailInfo.awardList}" varStatus="status">
								<tr>
									<td class="num">${status.count }</td>
									<td class="title nobar"><a href="javascript:void(0);">${item.feaAword }</a></td>
									<td>${item.feaMovie }</td>
									<td>${item.feaYear }</td>
									<td>${item.fPersName }</td>
								</tr>
								</c:forEach>
								</tbody>
							</table>
							<!--//list -->
						</div>
						<!-- //수상정보 -->

						<!-- 포스터갤러리 -->
						<div class="result-block">
							<div class="result-block-tt type2">
								<h4>포스터 갤러리</h4>
								<a href="###" class="iMore1" onclick="fncPosterInfo();">더보기</a>
							</div>
							<!-- list -->
							<div class="mImage10 mt1">
								<ul>
								<c:forEach var="item2" items="${detailInfo.posterList}" varStatus="status2">
								<li class="pt0">
									<a href="###" onclick="fncDetail(${item2.feNo}, ${item2.fedNo});">
										<c:choose>
											<c:when test="${item2.imageNm != '' && item2.imageNm ne null}">
											<span class="mImg1"><span style="background-image: url('${KF_FILM_IMAGE_PATH}/festival/${item2.feNo}/${item2.imageNm}')"></span></span>
											</c:when>
											<c:when test="${detailInfo.info.image != '' && detailInfo.info.image ne null}">
											<span class="mImg1"><span style="background-image: url('${KF_FILM_IMAGE_PATH}/festival/${detailInfo.info.image}')"></span></span>
											</c:when>
											<c:otherwise>
											<span class="mImg1"><span style="background-image: url('/resources/images/common/noimage.gif')"></span></span>
											</c:otherwise>
										</c:choose>
										<span class="text">${item2.fedTime }회</span>
									</a>
								</li>
								</c:forEach>
								</ul>
							</div>
							<!--//list -->
						</div>
						<!-- //포스터갤러리 -->


					</section>
				</form>
			</div>
		</div>



<script type="text/javascript">
$(document).ready(function(){

});

function fncAwordInfo(){
	 var frm = document.form1;
	    frm.target = "_self";
	    frm.action = "<c:url value='${paramMap._view_path}'/>"+"/award";
	    frm.submit();
}

function fncPosterInfo(){

	 var frm = document.form1;
	    frm.target = "_self";
	    frm.action = "<c:url value='${paramMap._view_path}'/>"+"/poster";
	    frm.submit();
}

function fncDetail(feNo, fedNo){
    $("#_page").val("1");
    var frm = document.form1;
    frm.target = "_self";
    frm.action = "/db/festival/"+feNo+"/"+fedNo;
    frm.submit();
}
</script>