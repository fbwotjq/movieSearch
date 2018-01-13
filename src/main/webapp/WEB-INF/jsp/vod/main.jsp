<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript" src="/resources/js/vod.js"></script> <!-- js for vod page -->
<link rel="stylesheet" type="text/css" href="/resources/css/module.css">
<link rel="stylesheet" type="text/css" href="/resources/css/vod.css">

<!-- vod-visual -->
		<div class="vod-visual">
			<div class="back-img" style="background-image:url(<c:out value="${MAIN_CONTENT_IMG_PATH}"/><c:out value="${detailInfo.fileName}"/>);"></div>
			<div class="back-dim"></div>
			<div class="back-gradiation"></div>
			<div class="con">
				<em class="tit"><span><c:out value="${detailInfo.subTitle}"/></span></em>
				<strong class="tit"><span><c:out value="${detailInfo.title}"/></span></strong>
				<div class="owl-carousel owl-theme" id="vod-visual-menu1">
				<c:forEach var="detailInfoListVar" items="${detailInfoList}" >

					<div class="item">
						<a href="javascript:fcnMovieDetail('${detailInfoListVar.movieId}', '${detailInfoListVar.movieSeq}');">
							<span class="img" style='background-image:url(<c:out value="${VOD_PLAN_IMG_PATH}"/><c:out value="${detailInfoListVar.fileName}"/>);'><img src="/resources/images/vod/vodcont-img-blank.png" alt=""></span>
							<span class="txt">
								<span class="nu">${detailInfoListVar.sortNo}</span>
								<strong class="tx1">${detailInfoListVar.movieTitle}</strong>
								<span class="tx2">${detailInfoListVar.director}, ${detailInfoListVar.prodYear}</span>
							</span>
						</a>
					</div>

				</c:forEach>
				</div>
			</div>
		</div>
		<!-- vod-visual -->

		<div id="contents">

			<!-- search -->
			<div class="vod-search">
				<div class="select">
					<label for="schtype" class="blind">검색 항목 선택</label>
					<select name="schtype" id="schtype" class="select-tric">
						<option value="movie">고전영화</option>
						<option value="docu">인물다큐</option>
					</select>
				</div>
				<div class="search">
					<input type="text" name="schtxt" id="schtxt" placeholder="VOD를 검색해보세요" value="" >
					<button class="ico-search" type="button" id="searchBtn"></button>
				</div>
				<div class="go">
					<a href="/vod/old/movie">VOD 전체 리스트</a>
					<a href="javascript:fnSearchTitle('RESTORE','복원작')">한국영상자료원 복원작 VOD 리스트</a>
					<a href="/care/vod/pay">정기이용권 결제</a>
				</div>
			</div>
			<!-- //search -->

			<!-- 분류_tab -->
			<div class="division-tab">

				<c:forEach var="item" items="${searchTypeCodeSubList }" varStatus="status">
				<div class="list type${status.count}">
					<div class="tit"><c:out value="${item.cCodeSubName }" /></div>
					<div class="owl-carousel owl-theme" id="division-tab-menu${status.count}">
						<c:forEach var="searchItem" items="${vodSearchTextList }" varStatus="searchStatus">
		                    <c:if test="${searchItem.searchTypeCd eq item.cCodeSubId}">

		                    <c:forEach items="${fn:split(searchItem.searchText, ',') }" var="searchTextSplit">
							    <div class="item">
									<a href="#search" onclick="fnSearchTitle('${searchItem.searchTypeCd}','${searchTextSplit}')"><c:out value="${searchTextSplit}"/></a>
								</div>
							</c:forEach>
		                    </c:if>
			            </c:forEach>
					</div>
				</div>
				</c:forEach>

			</div>
			<!-- //분류_tab -->

		</div>

		<!-- 동영상 -->
		<div class="vod-movie">
			<div class="timeline-box">
				<a href="javascript:fcnMovieDetail('${movieVodInfo.movieId}','${movieVodInfo.movieSeq}');">
					<div class="mImg1"><span style="background-image: url('<c:out value="${MAIN_CONTENT_IMG_PATH}"/><c:out value="${movieInfo.fileName}"/>')"></span></div>
					<span class="play"><i class="ico-play"></i></span>
				</a>
			</div>
			<span class="text">
				<span class="textBg">
					<span class="tit">
						<em class="ti">VOD Pick</em>
						<strong class="ti"><c:out value="${movieInfo.title}"/></strong>
						<span class="tx"><c:out value="${movieInfo.subTitle}"/></span>
						<span class="da"><c:out value="${movieInfo.movieDirector}"/> &middot; <c:out value="${movieInfo.moveiProdyear}"/></span>
					</span>
					<span class="txt">
						<c:out value="${movieInfo.contentDesc }" escapeXml="false"/>
					</span>
				</span>
			</span>
		</div>

		<!-- //동영상 -->
<form id="form1" name="form1" method="post">
	<sec:csrfInput/>
    <input type="hidden" id="_page" name="_page" value=""/>
    <input type="hidden" id="searchType" name="searchType" value=""/>
    <input type="hidden" id="searchText" name="searchText" value=""/>
    <input type="hidden" id="gubunValue" name="gubunValue" value=""/>
    <input type="hidden" id="gubunType" name="gubunType" value=""/>
</form>
<script type="text/javascript">

    $(document).ready(function() {
		$("#body").addClass("login");

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
    $(window).on("load",function(){
	    $(".term-content").mCustomScrollbar();
	});


    function fncSearch() {

    	if($.trim($('#schtxt').val()) != ''){
    		var selectValue = $("#schtype option:selected").val();
    		$("#_page").val("1");
    		$("#searchType").val("total");
    		$("#searchText").val($("#schtxt").val());

    		var frm = document.form1;
    	    frm.target = "_self";
    	    frm.action = "/vod/old/"+selectValue;
    	    frm.submit();
    	}
    }

    function fnSearchTitle(gubun, text){
		$("#_page").val("1");
		$("#gubunType").val(gubun);
		$("#gubunValue").val(text);
		$("#searchType").val("");
		$("#searchText").val("");

		var frm = document.form1;
	    frm.target = "_self";
	    frm.action = "/vod/old/movie";
	    frm.submit();
    }

</script>