<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 국외영화 -->
<div class="result-block">
    <div class="result-block-tt">
        <h4>국외영화 (<span class="em weighty">${resultData.kmFORMOVIECount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmFORMOVIECount > 0) || collection eq 'kmFORMOVIE'}">
    <!-- list -->
    <div class="result-block-detail">
        <ul>
        <c:forEach var="kmFORMOVIE" items="${resultData.kmFORMOVIEList}" varStatus="status">
            <li class="detail-box">
                    <%--
                    - 런타임 없음.
                    - 이미지를 만들 때 DIR , IMG 없음.
                    감독 및 출연자 링크에 없는 값들이 있음. 없을때는 어떻게 할 것인지?
                    ${kmKORMOVIE.DOCID}                == DOCID<br/>
                    ${kmKORMOVIE.DATE}                 == 기본수집날짜<br/>
                    ${kmKORMOVIE.MOVIE_ID}             == MOVIE_ID<br/>
                    ${kmKORMOVIE.MOVIE_SEQ}            == MOVIE_SEQ<br/>
                    ${kmKORMOVIE.PATTEN_CLSS}          == 유형<br/>
                    ${kmKORMOVIE.CONTENS_DETAIL_CLSS}  == 유형검색<br/>
                    ${kmKORMOVIE.TITLE}                == 영화명<br/>
                    ${kmKORMOVIE.TITLE_SEARCH}         == 복합영화명<br/>
                    ${kmKORMOVIE.DIRECTOR_LINK}        == 감독링크<br/>
                    ${kmKORMOVIE.DIRECTOR_SEARCH}      == 감독검색<br/>
                    ${kmKORMOVIE.ACTOR_LINK}           == 출연링크<br/>
                    ${kmKORMOVIE.ACTOR_SEARCH}         == 출연검색<br/>
                    ${kmKORMOVIE.STAFF}                == 스탭<br/>
                    ${kmKORMOVIE.COMPANY}              == 제작사투자배급사<br/>
                    ${kmKORMOVIE.KEYWORDS}             == 키워드<br/>
                    ${kmKORMOVIE.PLOT}                 == 줄거리<br/>
                    ${kmKORMOVIE.NATIONAL_CLSS}        == 국가구분<br/>
                    ${kmKORMOVIE.PROD_YEAR}            == 제작년도<br/>
                    ${kmKORMOVIE.NATION_CLSS}          == 제작국가<br/>
                    ${kmKORMOVIE.TYPE_CLSS}            == 장르<br/>
                    ${kmKORMOVIE.RELEASE_DATE}         == 영화개봉일<br/>
                    ${kmKORMOVIE.LENGTH_CLSS}          == 길이구분<br/>
                    ${kmKORMOVIE.LEVEL_CLSS}           == 관람기준<br/>
                    ${kmKORMOVIE.FILMCNS_CLSS}         == 심의여부<br/>
                    ${kmKORMOVIE.PLACE}                == 촬영장소<br/>
                    ${kmKORMOVIE.NOTE}                 == NOTE<br/>
                    ${kmKORMOVIE.alias}                == alias<br/>
                    --%>
                <div class="details">
                    <div class="movie-tt">
                        <a href="#" class="ftc-blue">
                            <i class="agelimit ageall">${kmKORMOVIE.LEVEL_CLSS}</i>
                                ${kmKORMOVIE.TITLE}
                            <div class="vod forPc"><span>VOD</span></div> <!-- forPc -->
                        </a>
                    </div>
                    <div class="movie-tt-eng">${kmKORMOVIE.TITLE_SEARCH}</div>
                    <div class="national">
                        <a href="#" class="ftc-blue"><span>${kmKORMOVIE.CONTENS_DETAIL_CLSS}</span></a>, <a href="#" class="ftc-blue"><span>${kmKORMOVIE.NATION_CLSS}</span></a>,
                    </div>
                    <div class="year">
                        <span>${kmKORMOVIE.PROD_YEAR}</span><span class="comma">,</span><span class="dots">###찾지 못함 ###분</span>
                    </div>
                    <div class="director">
                        <span>감독</span>
                        <div>
                            <c:forEach var="DIRECTOR_ARR" items="${DIRECTOR_LINK}" varStatus="i" end="10">
                                <c:set var="DIRECTOR" value="${fn:split(DIRECTOR_ARR,'|')}" />
                                <%--코드 = ${DIRECTOR[0]} | 1 ID = ${DIRECTOR[1]} | 2 NAME = ${DIRECTOR[2]}--%>
                                <c:choose>
                                    <c:when test="${i.first}"><a href="#" class="ftc-blue">${DIRECTOR[2]}</a></c:when>
                                    <c:otherwise>,<a href="#" class="ftc-blue">${DIRECTOR[2]}</a></c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="actor">
                        <span>출연</span>
                        <div>
                            <c:forEach var="ACTOR_ARR" items="${ACTOR_LINK}" varStatus="i" end="10">
                                <c:set var="ACTOR" value="${fn:split(ACTOR_ARR,'|')}" />
                                <%--코드 = ${ACTOR[0]} | 1 ID = ${ACTOR[1]} | 2 NAME = ${ACTOR[2]}--%>
                                <c:if test="${ACTOR[0] ne null && ACTOR[1] ne null && ACTOR[2] ne null}">
                                    <c:choose>
                                        <c:when test="${i.first}"><a href="#" class="ftc-blue">${ACTOR[2]}</a></c:when>
                                        <c:otherwise>,<a href="#" class="ftc-blue">${ACTOR[2]}</a></c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="vod forMobile"><span>VOD</span></div> <!-- forMobile -->
                </div>
                <div class="poster"><a href="#" class="ftc-blue">이미지를 가지고 오기 위한 dir, img 없음<img src="http://file.koreafilm.or.kr/thm/02/DIR값/tn_||IMG값" alt="${kmKORMOVIE.TITLE}"></a></div>
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

<c:if test="${'kmFORMOVIE' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmFORMOVIE', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //국외영화 -->