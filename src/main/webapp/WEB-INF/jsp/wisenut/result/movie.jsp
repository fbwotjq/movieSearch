<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 동영상 -->
<div class="result-block">
    <div class="result-block-tt">
        <h4>동영상 (<span class="em weighty"><c:out value="${resultData.kmMOVIECount}"/></span>)</h4>
    </div>
<c:choose>
	<c:when test="${(collection eq 'ALL' && resultData.kmMOVIECount > 0) || collection eq 'kmMOVIE'}">
	<!-- list -->
    <div class="mImage7 type2">
        <ul>
			<c:forEach var="kmMOVIE" items="${resultData.kmMOVIEList }" varStatus="status">
<%--
${kmMOVIE.DOCID}               == DOCID <br/>
${kmMOVIE.DATE}                == 기본수집날짜 <br/>
${kmMOVIE.MUL_TITLE}           == 제명 <br/>
${kmMOVIE.TITLE_SUB}           == 제명 <br/>
${kmMOVIE.TITLE_ETC}           == 제명 <br/>
${kmMOVIE.TITLE_EQUAL}         == 제명 <br/>
${kmMOVIE.PATTEN_CLSS}         == 유형 <br/>
${kmMOVIE.PATTEN_CLSS_SEARCH}  == 유형검색 <br/>
${kmMOVIE.TITLE}               == 영화명 <br/>
${kmMOVIE.DIRECTOR}            == 감독 <br/>
${kmMOVIE.ACTOR}               == 출연 <br/>
${kmMOVIE.STAFF}               == 스탭 <br/>
${kmMOVIE.COMPANY}             == 제작사 <br/>
${kmMOVIE.KEYWORDS}            == 키워드 <br/>
${kmMOVIE.PLOT}                == 줄거리 <br/>
${kmMOVIE.NATIONAL_CLSS}       == 국가구분 <br/>
${kmMOVIE.PROD_YEAR}           == 제작년도 <br/>
${kmMOVIE.PROD_NATION}         == 제작국가 <br/>
${kmMOVIE.TYPE_CLSS}           == 장르 <br/>
${kmMOVIE.USE_CLSS}            == 서비스구분 <br/>
${kmMOVIE.MSCREEN_CLSS}        == 동영상종류 <br/>
${kmMOVIE.MSCREEN_CLSS_TEXT}   == 동영상종류텍스트 <br/>
${kmMOVIE.LEVEL_CLSS_TEXT}     == 관람기준텍스트 <br/>
${kmMOVIE.MOVIE_CODE}          == 영화코드 <br/>
${kmMOVIE.IMG_DIR}             == 이미지 <br/>
${kmMOVIE.IMAGE_NM}            == 이미지파일명 <br/>
${kmMOVIE.RUNTIME}             == 상영시간_분 <br/>
${kmMOVIE.SECONDS}             == 상영시간_초 <br/>
${kmMOVIE.ALIAS}               == ALIAS <br/>
--%>


				<fmt:formatNumber var="RUNTIME" minIntegerDigits="4" value="${kmMOVIE.RUNTIME}" pattern="#"/>
            <li class="pt0" id="${kmMOVIE.DOCID}">
                <a href="${kmMOVIE.MOVIE_CODE}">
					<span class="timeline-box">
						<span class="mImg1"><span style="background-image: url('http://file.koreafilm.or.kr/multi/${kmMOVIE.IMG_DIR}/${kmMOVIE.IMAGE_NM}')"></span></span>
						<span class="timeline">
							<span class="timeline-musicvideo">
								<c:choose>
									<c:when test="${kmMOVIE.USE_CLSS eq '2'}">영상도서관</c:when>
									<c:otherwise>${kmMOVIE.MSCREEN_CLSS_TEXT}</c:otherwise>
								</c:choose>
							</span>
							<span><c:choose>
									<c:when test="${empty kmMOVIE.SECONDS}">${fn:substring(RUNTIME, 0, 2)}:${fn:substring(RUNTIME, 2, 4)}:00</c:when>
									<c:otherwise>${fn:substring(RUNTIME, 0, 2)}:${fn:substring(RUNTIME, 2, 4)}:${kmMOVIE.SECONDS}</c:otherwise>
								</c:choose></span>

						</span>
						<span class="play"><i class="ico-play"></i></span>
					</span>
                    <span class="text">
						<span class="title">${kmMOVIE.MUL_TITLE}(${kmMOVIE.PROD_YEAR})</span>
					</span>
                </a>
            </li>
			</c:forEach>
        </ul>
    </div>
	<!--//list -->
	</c:when>
	<c:otherwise>
		<h4 class="content_title01 itemLink">검색 결과가 없습니다.</h4>
	</c:otherwise>
</c:choose>

<c:if test="${'kmMOVIE' ne collection}">
<div class="mButton1 mt15 line">
	<span class="gRight"><a href="javascript:doCollectionSearch('kmMOVIE', 'movieTab');" class="iMore1">더보기</a></span>
</div>
</c:if>
</div>
<!-- //동영상 -->



<%--</c:if>--%>