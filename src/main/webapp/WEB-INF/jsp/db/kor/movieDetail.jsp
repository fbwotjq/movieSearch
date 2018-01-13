<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/resources/js/db.js"></script>
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
        <input type="hidden" id="tabIndex" name="tabIndex" value="<c:out value="${paramMap.tabIndex }"/>">
        <input type="hidden" id="movielistNo" name="movielistNo" value=""/>
        <input type="hidden" id="ownCategory" name="ownCategory" value="<c:url value='${paramMap.ownCategory}'/>"/>
        <input type="hidden" id="dReturnUrl" name="dReturnUrl" value="<c:url value='${paramMap._view_path}'/>">
        <section id="fieldset">

        <%@ include file="/WEB-INF/jsp/db/kor/movieProfile.jsp"%>

        <c:if test="${not empty vodInfo}">
	        <!-- vod -->
			<div class="mView3">
				<div class="result-block-tt type2">
					<h4>VOD</h4>
					<c:if test="${not empty vodInfo.mulTitle}"><span class="info"><c:out value="${vodInfo.mulTitle}"/></span></c:if>
					<a href="/care/vod/guide" class="iFeel"><span>VOD이용안내</span></a>
				</div>
				<div class="timeline-box">
					<a href="javascript:fcnVodPlayer('${vodInfo.movieId}','${vodInfo.movieSeq}','${vodInfo.multorNm}');" >
					<span class="mImg1"><span style="background-image: url('/resources/vod/thumb/<c:out value="${vodInfo.movieId}"/><c:out value="${vodInfo.movieSeq}"/>_w.jpg')"></span></span>
					<span class="timeline">
						<span class="timeline-vod">VOD</span>
						<span><c:out value="${vodInfo.runtime2}"/></span>
					</span>
					<span class="play purple"><i class="ico-play"></i></span>
					</a>
				</div>
				<div class="text">
					<div class="tit">
						<span class="ti"><c:out value="${detailInfo.info.title}"/>[<c:out value="${vodInfo.titleEtc}"/>]</span>
						<span class="bt">kmdb VOD</span> <!-- 저장위치 개발 필요  -->
					</div>
					<dl>
					<c:if test="${not empty vodInfo.runtime2}">
						<dt>상영시간</dt>
						<dd><c:out value="${vodInfo.runtime2}"/></dd>
					</c:if>
					<c:if test="${not empty vodInfo.codeNm}">
						<dt>색채</dt>
						<dd><c:out value="${vodInfo.codeNm}"/></dd>
					</c:if>
					<dt>프레임크기</dt>
					<dd><c:out value="${vodInfo.vSize}"/>x<c:out value="${vodInfo.hSize}"/></dd>
					<dt>관람료</dt>
					<dd><c:out value="${vodInfo.price}"/>원</dd>
					</dl>
					<div class="sns">
						<c:if test="${not empty vodInfo.naverUrl}">
							<a href="<c:url value='${item.naverUrl }'/>" class="naver">NAVER</a>
						</c:if>
						<c:if test="${not empty item.naverUrl}">
							<a href="<c:url value='${item.youtubeUrl }'/>" class="youtube">YOUTUBE</a>
						</c:if>
					</div>
				</div>
			</div>
			<!-- //vod -->
        </c:if>

		<c:if test="${not empty imageList}">
			<!-- 이미지 -->
			<div class="result-block mt2">
				<div class="result-block-tt type2">
					<h4>이미지 (<span class="em weighty">23</span>)</h4>
					<a href="#" onclick="alert('이미지더보기');" class="iMore1">더보기</a>
				</div>
				<!-- list -->
				<div class="mList8">
					<ul>
					<c:forEach var="item" items="${imageList}" begin="0" end="3" varStatus="status">
						<li <c:if test="${status.index gt 2}"> class="forPc" </c:if> >
							<a href="#" onclick="alert('이미지더보기');">
								<span class="mImg1"><span style="background-image: url('<c:out value="${PERSON_IMG_PATH2}${item.imgPath}"/>')"></span></span>
								<span class="text"><em class="tit"><c:out value="${item.title}"/></em></span>
							</a>
						</li>
					</c:forEach>
					</ul>
				</div>
				<!--//list -->
			</div>
			<!-- //이미지 -->
		</c:if>

		<c:if test="${not empty detailInfo.info.plot}">
			<!-- 줄거리 -->
			<div class="result-block mt1">
				<div class="result-block-tt type2">
					<h4>줄거리</h4>
				</div>
				<!-- list -->
				<div class="mTxt3">
					<c:out value="${detailInfo.info.plot}"/>
					<div id="jsSummary" class="moreHidden">
					</div>
				</div>
				<!--//list -->
				<div class="mButton1 mt0">
					<span class="gRight"><a href="#jsSummary" class="iOpen1">펼쳐보기</a></span>
				</div>

				<div class="mList12">
					<dl>
					<c:if test="${not empty detailInfo.info.typeClss}">
						<dt>장르</dt>
						<dd class="mTag1 gray">
							<c:set var="arrGenre" value="${fn:split(detailInfo.info.typeClss,',')}" />
		                       <c:forEach var="item" items="${arrGenre }">
		                           <a href="javascript:fcnKeyword('<c:out value="${fn:trim(item) }"/>');">#<c:out value="${fn:trim(item) }"/></a>
		                      </c:forEach>
						</dd>
					</c:if>
					<c:if test="${not empty detailInfo.info.keywords}">
						<dt>키워드</dt>
						<dd class="mTag1 purple">
							 <c:set var="arrKeywords" value="${fn:split(detailInfo.info.keywords,',')}" />
		                     <c:forEach var="item" items="${arrKeywords }">
		                           <a href="javascript:fcnKeyword('<c:out value="${fn:trim(item) }"/>');">#<c:out value="${fn:trim(item) }"/></a>
		                     </c:forEach>
						</dd>
					</c:if>
					</dl>
				</div>
			</div>
			<!-- //줄거리 -->
		</c:if>

		<c:if test="${not empty directorList or not empty actorList or not empty staffList}">
			<!-- 크레디크 -->
			<div class="result-block mt1">
				<div class="result-block-tt type2">
					<h4>크레디크 (<span class="em weighty">${fn:length(directorList) + fn:length(actorList) + fn:length(staffList) }</span>)</h4>
					<a href="#" onclick="fcnSubDetail('credit');" class="iMore1">더보기</a>
				</div>
				<!-- list -->
				<div class="mList9 type2">
					<dl>
					<c:if test="${not empty directorList}">
						<dt class="mTitle2">감독 <span>:</span></dt>
						<c:forEach var="item" items="${directorList}" >
							<dd><a href="#"  onclick="fcnPersonDetail('<c:out value="${item.personId}"/>');" class="txtBlue"><c:out value="${item.personNm }"/></a></dd>
						</c:forEach>
					</c:if>
					<c:if test="${not empty actorList}">
						<dt class="mTitle2">출연 <span>:</span></dt>
						<dd>
							<c:forEach var="item" items="${actorList}" begin="0" end="4" varStatus="status">
								<a href="#"  onclick="fcnPersonDetail('<c:out value="${item.personId}"/>');" class="txtBlue"><c:out value="${item.personNm }"/></a>
								<span class="name"><c:out value="${item.staff }"/> 역</span>
							</c:forEach>
						</dd>
						</dl>
					</c:if>
					<c:if test="${not empty staffList}">
						<span class="ti">스태프</span>
						<dl class="type2">
						<c:forEach var="item" items="${staffDivList}" begin="0" end="10" varStatus="status">
							<dt class="mTitle2 <c:if test="${(fn:length(item.staff) + fn:length(item.creditNm)) > 10}">type2</c:if>"><c:out value="${item.creditNm }"/><c:if test="${not empty item.staff}">-<c:out value="${item.staff }"/></c:if><span>:</span></dt>
							<dd class="<c:if test="${(fn:length(item.staff) + fn:length(item.creditNm)) > 10}">type2</c:if>">
								<c:forEach var="item2" items="${staffList}" varStatus="status" >
									<c:if test="${item.creditId eq item2.creditId and item.staff eq item2.staff }">
										<a href="#"  onclick="fcnPersonDetail('<c:out value="${item2.personId}"/>');" class="txtBlue"><c:out value="${item2.personNm }"/></a>
										&nbsp;
									</c:if>
								</c:forEach>
							</dd>
						</c:forEach>
						</dl>
					</c:if>
				</div>
				<!--//list -->
			</div>
		<!-- //크레디크 -->
		</c:if>

		<c:if test="${not empty awardList}">
			<!-- 수상정보 -->
			<div class="result-block mt1">
				<div class="result-block-tt type2">
					<h4>수상정보</h4>
					<a href="#" onclick="fcnSubDetail('award');" class="iMore1">더보기</a>
				</div>
				<!-- list -->
				<div class="mList10">
					<ul>
					<c:forEach var="item" items="${awardList}">
						<li>
							<span class="tit"><a href="#"   onclick="goFestivalDetail(${item.feNo},${item.fedNo});" class="txtBlue">제 <c:out value="${item.cnt }"/>회 <c:out value="${item.maintitle }"/>(<c:out value="${item.fedYear }"/>)</a> <span>:</span></span>
							<span class="txt">
								<c:forEach var="item2" items="${item.subList}" >
									<c:out value="${item2.feaAword }"/>(<a href="#" onclick="fcnPersonDetail('<c:out value="${item2.fPersId}"/>');" class="txtBlue"><c:out value="${item2.fPersName }"/></a>)<br>
								</c:forEach>
							</span>
						</li>
					</c:forEach>
					</ul>
				</div>
				<!--//list -->
			</div>
			<!-- //수상정보 -->
		</c:if>

		<c:if test="${not empty subDetailInfo}">
			<!-- 상세정보 -->
			<div class="result-block mt1">
				<div class="result-block-tt type2">
					<h4>상세정보</h4>
				</div>
				<!-- list -->
				<div class="mList13">
					<dl>
					<c:if test="${not empty subDetailInfo.levelnm}">
						<dt>등급정보</dt>
						<dd><c:out value="${subDetailInfo.cnsNo}"/>
							<fmt:parseDate value="${subDetailInfo.cnsDate}" var="fmtcnsDate" pattern="yyyyMMdd"/>
		                    <fmt:formatDate value="${fmtcnsDate}" pattern="yyyy-MM-dd"/>
							<c:out value="${subDetailInfo.levelnm}"/>
						</dd>
					</c:if>
					<c:if test="${not empty anotherTitleInfo}">
						<dt>다른제목</dt>
						<dd>
							<c:if test="${not empty anotherTitleInfo.titleName}">
								<c:out value="${anotherTitleInfo.titleName}"/>(<c:out value="${anotherTitleInfo.titlenm}"/>)<br>
							</c:if>
							<c:if test="${not empty anotherTitleInfo.btitleEng}">
								<c:out value="${anotherTitleInfo.btitleEng}"/>(<c:out value="${anotherTitleInfo.titlenm}"/>)
							</c:if>
						</dd>
					</c:if>
					<c:if test="${not empty subDetailInfo.theater}">
						<dt>개봉극장</dt>
						<dd><c:out value="${subDetailInfo.theater}"/></dd>
					</c:if>
					<c:if test="${not empty subDetailInfo.exportStat}">
						<dt>수출현황</dt>
						<dd><c:out value="${subDetailInfo.exportStat}"/></dd>
					</c:if>
					<c:if test="${not empty locationList}">
						<dt>로케이션</dt>
						<dd class="type2">
							<c:forEach var="item" items="${locationList}"  varStatus="status">
							<span class="gab1"><a href="<c:out value="${item.placeSeqno}"/>" class="txtBlue"><c:out value="${item.place}"/></a><c:if test="${not status.last }">, </c:if></span>
							</c:forEach>
						</dd>
					</c:if>
					<c:if test="${not empty subDetailInfo.note1}">
						<dt>노트</dt>
						<dd><c:out value="${subDetailInfo.note1}"/></dd>
					</c:if>
					</dl>
				</div>
				<!--//list -->
			</div>
			<!-- //상세정보 -->
		</c:if>

		<c:if test="${not empty divList}">
			<!-- 리스트 -->
			<div class="result-block mt1">
				<div class="result-block-tt type2">
					<h4>리스트</h4>
				</div>
				<!-- list -->
				<div class="mList12">
					<dl>
					<c:forEach var="item" items="${divList}"  varStatus="status">
						<dt><c:out value="${item.div1MovielistName}"/></dt>
						<dd class="mTag1 gray">
							 <a href="#" onclick="fcnListDetail('<c:out value="${item.movielistId}"/>','<c:out value="${item.movielistNo}"/>');""><c:out value="${item.movielistName}"/></a>
						</dd>
					</c:forEach>
					</dl>
				</div>
				<!--//list -->
			</div>
			<!-- //리스트 -->
		</c:if>

		<c:if test="${not empty pageListVo.resultList }">
			<!-- 관련글 -->
			<div class="result-block mt1">
				<div class="result-block-tt type2">
					<h4>관련글</h4>
					<a href="#" onclick="fcnSubDetail('story');" class="iMore1">더보기</a>
				</div>
				<!-- list -->
				<div class="mImage1">
					<ul>
						<c:forEach var="item" items="${pageListVo.resultList }"  begin="0" end="2" varStatus="status">
						<li>
							<span class="mImg1"><span style="background-image: url('${MOVIE_STORY_IMG_PATH}<c:out value="${item.fileName }"/>')"></span></span>
							<span class="text">
								<a href="javascript:fcnStoryDetail('<c:out value="${item.storyDivSeq}"/>','<c:out value="${item.storySeq}"/>');" class="tit"><c:out value="${item.title}"/></a>
	                                    <span class="des"><c:out value="${item.shortNonTagContentDesc }" escapeXml="false"/></span>
	                                    <span class="nam"><span>by.</span>${item.writerName }</span>
	                                    <span class="dat">
	                                        <fmt:parseDate value="${item.regitDate}" var="fmtRegitDate" pattern="yyyyMMdd"/>
		                                    <fmt:formatDate value="${fmtRegitDate}" pattern="yyyy-MM-dd"/>
	                                    </span>
							</span>
						</li>
						</c:forEach>
					</ul>
				</div>
				<!--//list -->
			</div>
			<!-- //관련글 -->
		</c:if>

		<c:if test="${not empty pageListVo2.resultList }">
			<!-- 사용자리뷰 -->
			<div class="result-block mt1">
				<div class="result-block-tt type2">
					<h4>사용자리뷰</h4>
					<a href="#" onclick="fcnSubDetail('review');" class="iMore1">더보기</a>
				</div>
				<!-- list -->
				<div class="mImage1">
					<ul>
						<c:forEach var="item" items="${pageListVo2.resultList }"  begin="0" end="2" varStatus="status">
						<li class="noimg">
							<span class="text">
								<a href="#" class="tit" onclick="fcnReviewDetail('<c:out value="${item.reviewSeq }"/>');"> <c:out value="${item.subject }"/></a>
								<span class="des"><c:out value="${item.shortNonTagContentDesc }" escapeXml="false"/></span>
								<span class="nam2"><c:out value="${item.movieTitle }"/>(<c:out value="${item.prodYear }"/>)</span>
								<span class="dots"><c:out value="${item.createName }"/></span>
								<span class="dots"><c:out value="${item.createDate }"/></span>
							</span>
						</li>
						</c:forEach>
					<ul>
				</div>
				<!--//list -->
			</div>
			<!-- //사용자리뷰 -->
		</c:if>

		<c:if test="${not empty relMovieList }">
			<!-- 관련영화 -->
			<div class="result-block mt1">
				<div class="result-block-tt type2">
					<h4>관련영화</h4>
				</div>
				<!-- list -->
				<div class="mImage10 type2">
					<ul>
					<li>
						<c:forEach var="item" items="${relMovieList }"  begin="0" end="2" varStatus="status">
						<a href="#" onclick="fcnMovieDetail('<c:out value="${item.movieId }"/>','<c:out value="${item.movieSeq }"/>')" >
							<span class="mImg1"><span style="background-image: url('<c:out value="${MOVIE_POSTER_PATH}"/><c:out value="${item.imgPath}"/>/tn_<c:out value="${item.filename}"/>')"></span></span>
							<span class="text"><c:out value="${item.gubun }"/> : <c:out value="${item.title }"/> (<c:out value="${item.director }"/>, <c:out value="${item.prodYear }"/>)</span>
						</a>
						</c:forEach>
					</li>
					</ul>
				</div>
				<!--//list -->
			</div>
			<!-- //관련영화 -->
			</c:if>
        </section>
        </form>
    </div>
</div>


<script type="text/javascript" src="/resources/js/db.js"></script>

<script type="text/javascript">

	$(document).ready(function() {

	});


	function fcnKeyword(pKeyword) {
	    pKeyword = encodeURIComponent( encodeURIComponent( pKeyword ) );

		formSubmit("form1", "<c:url value="/history/talk/keyword/list"/>?keyword=" + pKeyword);
	}

	function goFestivalDetail(feNo, fedNo){
		 var frm = document.form1;
		    frm.target = "_self";
		    frm.action = "/db/festival/"+feNo+"/"+fedNo+"/award";
		    frm.submit();
	}

	function fcnListDetail(idx,mNo){
		$("#movielistNo").val(mNo);
		var frm = document.form1;
		    frm.target = "_self";
		    frm.action = "/db/list/"+idx;
		    frm.submit();
	}

	function fcnStoryDetail(pStoryDivSeq,pStorySeq) {
		var frm = document.form1;
		    frm.target = "_self";
		    frm.action = "/story/"+ pStoryDivSeq +"/" + pStorySeq;
		    frm.submit();
	}

	function fcnReviewDetail(idx){
		 var frm = document.form1;
		    frm.target = "_self";
		    frm.action = "/story/user/"+idx;
		    frm.submit();
	}

	function fcnMovieDetail(movieId,movieSeq) {
		var frm = document.form1;
		    frm.target = "_self";
		    frm.action = "/db/kor/detail/movie/"+ movieId +"/" + movieSeq;
		    frm.submit();
	}
</script>