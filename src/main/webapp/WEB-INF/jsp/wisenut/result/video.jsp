<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 비디오 -->
<div class="result-block">
    <div class="result-block-tt noline">
        <h4>비디오 (<span class="em weighty">${resultData.kmVIDEOCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmVIDEOCount > 0) || collection eq 'kmVIDEO'}">
    <!-- list -->
    <table border="1" class="data-table medium transform-m">
        <caption>비디오 테이블</caption>
        <colgroup>
            <col style="*">
            <col style="width:15.5%">
            <col style="width:15.5%">
            <col style="width:15.5%">
            <col style="width:8.5%">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">제명</th>
            <th scope="col">수록영화</th>
            <th scope="col">제조연도</th>
            <th scope="col">규격</th>
            <th scope="col">수량</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="kmVIDEO" items="${resultData.kmVIDEOList }" varStatus="status">
<%--
${kmVIDEO.DOCID}          == DOCID     <br/>
${kmVIDEO.DATE}           == 기본수집날짜     <br/>
${kmVIDEO.TITLES}         == 제명     <br/>
${kmVIDEO.TITLE_SUB}      == 제명     <br/>
${kmVIDEO.TITLE_ETC}      == 제명     <br/>
${kmVIDEO.TITLE_EQUAL}    == 제명     <br/>
${kmVIDEO.MOVIE_COUNT}    == 수록영화     <br/>
${kmVIDEO.PATTEN_CLSS}    == 유형     <br/>
${kmVIDEO.DIRECTOR}       == 감독     <br/>
${kmVIDEO.ACTOR}          == 출연(성우     <br/>
${kmVIDEO.STAFF}          == 스탭     <br/>
${kmVIDEO.INVEST}         == 제작사/투자배급사     <br/>
${kmVIDEO.KEYWORDS}       == 키워드     <br/>
${kmVIDEO.PLOT}           == 줄거리     <br/>
${kmVIDEO.EXYEAR}         == 제작년도     <br/>
${kmVIDEO.NATIONAL_CLSS}  == 국가구분     <br/>
${kmVIDEO.PROD_NATION}    == 제작국가     <br/>
${kmVIDEO.TYPE_CLSS}      == 장르     <br/>
${kmVIDEO.DEV_CLSS}       == 매체_비디오규격     <br/>
${kmVIDEO.STANDARD}       == 규격     <br/>
${kmVIDEO.COMPANY}        == 매체_비디오 제조사/판매원     <br/>
${kmVIDEO.PROD_YEAR}      == 제조년도     <br/>
${kmVIDEO.LEVEL_CLSS}     == 매체_관람기준     <br/>
${kmVIDEO.COLOR_CLSS}     == 매체_색체"  <br/>
${kmVIDEO.LANG_CLSS}      == 매체_언어     <br/>
${kmVIDEO.CAP_CLSS}       == 매체_자막     <br/>
${kmVIDEO.POS_CLSS}       == 보존위치     <br/>
${kmVIDEO.AMOUNT}         == 수량     <br/>
${kmVIDEO.VIEW_STANDARD}  == 관람기준     <br/>
${kmVIDEO.MOVIE_CODE}     == 영화코드     <br/>
${kmVIDEO.ALIAS}          == ALIAS  <br/>
--%>
        <tr>
            <td class="title align-left">
                <a href="javascript:void(0);" class="txtBlue">
                ${kmVIDEO.TITLES}
                <c:if test="${kmVIDEO.TITLE_SUB ne ''}">, ${kmVIDEO.TITLE_SUB}</c:if>
                <c:if test="${kmVIDEO.TITLE_ETC ne ''}">: ${kmVIDEO.TITLE_ETC}</c:if>
                <c:if test="${kmVIDEO.TITLE_EQUAL ne ''}">[${kmVIDEO.TITLE_EQUAL}]</c:if>
                </a>
            </td>
            <td>${kmVIDEO.MOVIE_COUNT}편</td>
            <td>${kmVIDEO.PROD_YEAR}</td>
            <td>
                <c:choose>
                    <c:when test="${kmVIDEO.DEV_CLSS eq 'R'}">Blu-ray</c:when>
                    <c:when test="${kmVIDEO.DEV_CLSS eq 'D'}">DVD</c:when>
                    <c:when test="${kmVIDEO.DEV_CLSS eq 'V'}">VHS</c:when>
                    <c:when test="${kmVIDEO.DEV_CLSS eq 'G'}">Digi-betacam</c:when>
                    <c:otherwise>HDCAM</c:otherwise>
                </c:choose>
            </td>
            <td>${kmVIDEO.AMOUNT}</td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
    <!--//list -->
    </c:when>
    <c:otherwise>
        <h4 class="content_title01 itemLink">검색 결과가 없습니다.</h4>
    </c:otherwise>
</c:choose>

    <c:if test="${'kmVIDEO' ne collection}">
        <div class="mButton1 mt15">
            <span class="gRight"><a href="javascript:doCollectionSearch('kmVIDEO', 'movieTab');" class="iMore1">더보기</a></span>
        </div>
    </c:if>
</div>
<!-- //비디오 -->