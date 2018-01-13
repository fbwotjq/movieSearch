<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!-- profile -->
	<div class="mProfile type2">
		<div class="mImg1">
			<c:choose>
				<c:when test ="${detailInfo.img != null }">
					<span style="background-image: url('<c:out value="${MOVIE_POSTER_PATH}"/><c:out value="${detailInfo.img.imgPath}"/>/tn_<c:out value="${detailInfo.img.filename}"/>')"></span>
				</c:when>
				<c:otherwise>
					<span style="background-image: url('/resources/images/common/noimage.gif')"></span>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="text">
			<div class="nam">
				<div class="na1"><c:out value="${detailInfo.info.title}"/>(<c:out value="${detailInfo.info.prodYear}"/>)</div>
            	<div class="na2">
					<span class="tx"><c:out value="${detailInfo.info.titleEng}"/></span>
					<c:if test="${not empty vodInfo}">
						<span class="vod"><span>VOD</span></span>
					</c:if>
					<span class="vod purple"><span>ENG</span></span>
				</div>
			</div>
			<div class="desc">
				<div class="txt">
					<div class="tx1">
						<a href="###" class="txtBlue"><c:out value="${detailInfo.info.levelnm}"/></a>
						<span class="dots"><a href="###" class="txtBlue"><c:out value="${detailInfo.info.nationClss}"/></a></span>
						<span class="dots"><c:out value="${detailInfo.info.runtime}"/>분</span>
						<fmt:parseDate value="${detailInfo.info.releaseDate}" var="releaseDate" pattern="yyyyMMdd"/>
						<span class="dots type2"><fmt:formatDate value="${releaseDate}" pattern="yyyy-MM-dd"/> <span class="txtGray">(개봉)</span></span>
						<c:if test="${not empty subDetailInfo.viewersNum}">
							<span class="dots forPc">1<c:out value="${subDetailInfo.viewersNum}"/><span class="txtGray">(관람)</span></span>
						</c:if>
					</div>
				</div>
				<dl>
				<c:if test="${not empty subDetailInfo.compyClss}">
					<dt class="forPc">제작사</dt>
					<dd class="forPc"><c:out value="${subDetailInfo.compyClss}"/></dd>
				</c:if>
				<c:if test="${not empty subDetailInfo.distribute}">
					<dt class="forPc">배급사</dt>
					<dd class="forPc"><c:out value="${subDetailInfo.distribute}"/></dd>
				</c:if>
				<c:if test="${not empty directorList}">
				<dt>감독</dt>
					<dd>
					<c:forEach var="item" items="${directorList}" begin="0" end="2" varStatus="status">
						<c:if test="${status.index ne 0}">,</c:if><a href="#"  onclick="fcnPersonDetail('<c:out value="${item.personId}"/>');" class="txtBlue"><c:out value="${item.personNm }"/></a>
					</c:forEach>
					</dd>
				</c:if>
				<c:if test="${not empty actorList}">
				<dt>출연</dt>
				<dd>
					<c:forEach var="item" items="${actorList}" begin="0" end="4" varStatus="status">
						<c:if test="${status.index ne 0}">,</c:if><a href="#" onclick="fcnPersonDetail('<c:out value="${item.personId }"/>');" class="txtBlue"><c:out value="${item.personNm }"/></a>
					</c:forEach>
					<a href="#" onclick="fcnActorSubDetail('<c:out value="${paramMap.movieId }"/>','<c:out value="${paramMap.movieSeq }"/>');"  class="underline">더보기</a>
				</dd>
				</c:if>
				</dl>
				   <sec:authorize access="isAuthenticated()">
                       <a href="#" class="mBtn1 purple inline jsBtnScrap"><span class="iScrap">스크랩하기</span></a>
                   </sec:authorize>
                   <sec:authorize access="isAnonymous()">
                       <a href="javascript:fcnLogin('form1');" class="mBtn1 purple inline"><span class="iScrap">스크랩하기</span></a>
                   </sec:authorize>
				</div>
		</div>
	</div>
	<!-- //profile -->

<!-- slide tab -->
<div class="mMenu1 type2">
    <!-- depth1 -->
    <div class="owl-carousel dep1 jsTab1" id="db-tab-menu3">
        <a href="#db-tab-menu4" class="${paramMap.tabIndex == 'own' ? 'selected' : ''}">소장자료</a>
        <a href="#db-tab-menu4_2" class="${paramMap.tabIndex == '' ? 'selected' : ''}">기본정보</a>
    </div>
    <!-- //depth1 -->
    <!-- depth2 for 소장자료 -->
    <div class="owl-carousel dep2" id="db-tab-menu4" style="display:none;">
		<c:if test="${ownListCount.mtotal >0}">
	        <span class="ti"><strong>영상자료</strong>(<c:out value="${ownListCount.mtotal }"/>)</span>
	        <c:if test="${ownListCount.filmcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','videoData','anchorMovieFilm');">필름(<c:out value="${ownListCount.filmcnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.dcinemacnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','videoData','anchorMovieDCinema');">D시네마(<c:out value="${ownListCount.dcinemacnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.tapecnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','videoData','anchorMovieTape');">테이프(<c:out value="${ownListCount.dcinemacnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.diskcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','videoData','anchorMovieDisk');">디스크(<c:out value="${ownListCount.diskcnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.moviecnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','videoData','anchorMovieMovie');">동영상(<c:out value="${ownListCount.moviecnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.vodcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','videoData','anchorMovieVod');">VOD(<c:out value="${ownListCount.vodcnt }"/>)</a></c:if>
	    </c:if>
	    <c:if test="${ownListCount.itotal >0}">
	        <span class="ti"><strong>이미지</strong>(<c:out value="${ownListCount.itotal }"/>)</span>
	        <c:if test="${ownListCount.postercnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','image','anchorImagePoster');">포스터(<c:out value="${ownListCount.postercnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.stilcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','image','anchorImageStill');">스틸(<c:out value="${ownListCount.stilcnt }"/>)</a></c:if>
	    </c:if>
	    <c:if test="${ownListCount.btotal >0}">
	        <span class="ti"><strong>문헌자료</strong>(<c:out value="${ownListCount.btotal }"/>)</span>
	        <c:if test="${ownListCount.scenariocnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureScenario');">시나리오/콘티(<c:out value="${ownListCount.scenariocnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.handbillcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureDiagnosis');">전단(<c:out value="${ownListCount.handbillcnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.bookcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureBook');">도서(<c:out value="${ownListCount.bookcnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.theorycnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureThesis');">논문(<c:out value="${ownListCount.theorycnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.censorshipcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureDeliberation');">심의자료(<c:out value="${ownListCount.censorshipcnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.newscnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureReport');">보도자료(<c:out value="${ownListCount.newscnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.etccnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureEtc');">기타자료(<c:out value="${ownListCount.etccnt }"/>)</a></c:if>
	    </c:if>
	    <c:if test="${ownListCount.etotal >0}">
	        <span class="ti"><strong>기타</strong>(<c:out value="${ownListCount.etotal }"/>)</span>
	        <c:if test="${ownListCount.ostcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','etc','anchorEtcOst');">OST(<c:out value="${ownListCount.ostcnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.equipcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','etc','anchorEtcHistory');">박물류(<c:out value="${ownListCount.equipcnt }"/>)</a></c:if>
    	</c:if>
    </div>
    <!-- depth2 for 기본정보 -->
    <div class="owl-carousel dep2" id="db-tab-menu4_2">
        <c:if test="${ownListCount.mtotal >0}">
	        <span class="ti"><strong>영상자료</strong>(<c:out value="${ownListCount.mtotal }"/>)</span>
	        <c:if test="${ownListCount.filmcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','videoData','anchorMovieFilm');">필름(<c:out value="${ownListCount.filmcnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.dcinemacnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','videoData','anchorMovieDCinema');">D시네마(<c:out value="${ownListCount.dcinemacnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.tapecnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','videoData','anchorMovieTape');">테이프(<c:out value="${ownListCount.dcinemacnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.diskcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','videoData','anchorMovieDisk');">디스크(<c:out value="${ownListCount.diskcnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.moviecnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','videoData','anchorMovieMovie');">동영상(<c:out value="${ownListCount.moviecnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.vodcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','videoData','anchorMovieVod');">VOD(<c:out value="${ownListCount.vodcnt }"/>)</a></c:if>
	    </c:if>
	    <c:if test="${ownListCount.itotal >0}">
	        <span class="ti"><strong>이미지</strong>(<c:out value="${ownListCount.itotal }"/>)</span>
	        <c:if test="${ownListCount.postercnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','image','anchorImagePoster');">포스터(<c:out value="${ownListCount.postercnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.stilcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','image','anchorImageStill');">스틸(<c:out value="${ownListCount.stilcnt }"/>)</a></c:if>
	    </c:if>
	    <c:if test="${ownListCount.btotal >0}">
	        <span class="ti"><strong>문헌자료</strong>(<c:out value="${ownListCount.btotal }"/>)</span>
	        <c:if test="${ownListCount.scenariocnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureScenario');">시나리오/콘티(<c:out value="${ownListCount.scenariocnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.handbillcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureDiagnosis');">전단(<c:out value="${ownListCount.handbillcnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.bookcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureBook');">도서(<c:out value="${ownListCount.bookcnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.theorycnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureThesis');">논문(<c:out value="${ownListCount.theorycnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.censorshipcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureDeliberation');">심의자료(<c:out value="${ownListCount.censorshipcnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.newscnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureReport');">보도자료(<c:out value="${ownListCount.newscnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.etccnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','document','anchorLiteratureEtc');">기타자료(<c:out value="${ownListCount.etccnt }"/>)</a></c:if>
	    </c:if>
	    <c:if test="${ownListCount.etotal >0}">
	        <span class="ti"><strong>기타</strong>(<c:out value="${ownListCount.etotal }"/>)</span>
	        <c:if test="${ownListCount.ostcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','etc','anchorEtcOst');">OST(<c:out value="${ownListCount.ostcnt }"/>)</a></c:if>
	        <c:if test="${ownListCount.equipcnt >0}"><a href="#" onclick="fcnOwnDetail('${paramMap.movieId}','${paramMap.movieSeq }','etc','anchorEtcHistory');">박물류(<c:out value="${ownListCount.equipcnt }"/>)</a></c:if>
    	</c:if>
    </div>
    <!-- //depth2 -->
</div>
<!-- //slide tab -->


	<!-- 담을 위치 선택 -->
	<div class="mPopup1" id="jsScrap">
		<div class="popupBg">
			<h4 class="title">담을 위치 선택</h4>
			<div class="cont">
				<div class="list">
					<div class="asset">
						<label><input type="radio" name="radio1" id="radio1_view" value="1" checked="checked"> <span class="label" id="scrap_text_1">내가 본 영화</span></label>
					</div>
					<div class="asset">
						<label><input type="radio" name="radio1" id="radio1_want" value="2" > <span class="label" id="scrap_text_2">보고싶은 영화</span></label>
					</div>

				</div>
				<button class="btn large weighty" type="button" onclick="fcnRegMy('<c:out value="${paramMap.movieId }"/>','<c:out value="${paramMap.movieSeq }"/>');">저장</button>
			</div>
			<button type="button" class="b-close" title="닫기">닫기</button>
		</div>
	</div>

<script type="text/javascript">
$(document).ready(function(){
	$('.jsBtnScrap').bind('click', function(e) {
		e.preventDefault();
		BPOPUP =  $('#jsScrap').bPopup({
			modalClose : true,
			opacity: 0.6,
			positionStyle: 'fixed'
		});
	});
});


function fcnPersonDetail(pPersonId) {
	document.location.href = "/db/per/" + pPersonId;
}

function fcnActorSubDetail(movieId,movieSeq) {
	 var frm = document.form1;
	    frm.target = "_self";
	    frm.action = "/db/kor/detail/movie/"+movieId+"/"+movieSeq+"/credit";
	    frm.submit();
}

function fcnSubDetail(div) {
	 var frm = document.form1;
     frm.target = "_self";
     frm.action = "<c:url value='${paramMap._view_path}'/>"+"/"+div;
     frm.submit();
}

function fcnOwnDetail(movieId,movieSeq,div,category) {
	$("#ownCategory").val(category);
	$("#tabIndex").val("own");
	var frm = document.form1;
    frm.target = "_self";
    frm.action = "/db/kor/detail/movie/"+movieId+"/"+movieSeq+"/own/"+div;
    frm.submit();
}

//내가 본 영화 등록
function fcnRegMy(movieId,movieSeq) {
	var frm = document.form1;
	var radio = $(":input:radio[name=radio1]:checked").val();

	var response = $.fnAjax({
		params:{
				radio: radio,
				movieId: movieId,
				movieSeq: movieSeq,
				viewPath: "<c:url value='${paramMap._full_path}'/>"
				}
		, url: "/db/kor/detail/movie/scrap/"+radio+"/proc"
		, async:false
		, showMessage:false});
	    if (response.result == "true") {
	    	if(response.resultCnt == 1){
	    		alert($("#scrap_text_"+radio).text()+"에 등록되었습니다.");
	    	}else if(response.resultCnt == 0){
	    		alert("이미 등록된 영화입니다.");
	    	}
			return;
	    }else {
	    	alert("영화 등록중 에러가 발생하였습니다");
	    	return;
	    }
	    return false;
}
</script>