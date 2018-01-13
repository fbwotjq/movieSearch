<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- OST -->
<div class="result-block">
    <div class="result-block-tt noline">
        <h4>OST (<span class="em weighty">${resultData.kmOSTCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmOSTCount > 0) || collection eq 'kmOST'}">
    <!-- list -->
    <table border="1" class="data-table medium transform-m">
        <caption>OST 테이블</caption>
        <colgroup>
            <col style="*">
            <col style="width:8.5%">
            <col style="width:10%">
            <col style="width:15.5%">
            <col style="width:15.5%">
            <col style="width:8.5%">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">제명</th>
            <th scope="col">규격</th>
            <th scope="col">연도</th>
            <th scope="col">제작사</th>
            <th scope="col">총연주시간</th>
            <th scope="col">트랙수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="kmOST" items="${resultData.kmOSTList }" varStatus="status">
<%--
${kmOST.DOCID}        DOCID  <br/>
${kmOST.DATE}         기본수집날짜  <br/>
${kmOST.TITLE_SEARCH}  음반명검색  <br/>
${kmOST.TITLE}         음반명1  <br/>
${kmOST.TITLE_SUB}     음반명2  <br/>
${kmOST.TITLE_ETC}     음반명3  <br/>
${kmOST.TITLE_EQUAL}   음반명4  <br/>
${kmOST.MOVIE_TITLE}  관련영화명  <br/>
${kmOST.SONG_TITLE}   수록곡  <br/>
${kmOST.ARTIST}       아티스트  <br/>
${kmOST.RECORD_CLSS}  음반종류  <br/>
${kmOST.DEV_CLSS}     규격  <br/>
${kmOST.PROD_COMPY}   제작사  <br/>
${kmOST.PROD_YEAR}    제작년도  <br/>
${kmOST.TOTAL_TIME}    연주시간  <br/>
${kmOST.TRACK_COUNT}   트랙수  <br/>
${kmOST.POS_CLSS}     보존위치  <br/>
${KMOST.ALIAS}        ALIAS  <br/>
--%>
        <tr>
            <td class="title align-left">
                <a href="javascript:void(0);" class="txtBlue">
                    ${kmOST.TITLE}
                    <c:if test="${kmOST.TITLE_SUB ne ''}">: ${kmOST.TITLE_SUB}</c:if>
                    <c:if test="${kmOST.TITLE_ETC ne ''}">(${kmOST.TITLE_ETC})</c:if>
                </a></td>
            <td>${kmOST.DEV_CLSS}</td>
            <td>${kmOST.PROD_YEAR}</td>
            <td>${kmOST.PROD_COMPY}</td>
            <td>${kmOST.TOTAL_TIME}</td>
            <td>${kmOST.TRACK_COUNT}트랙</td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
    <!-- //list -->

    </c:when>
    <c:otherwise>
        <h4 class="content_title01 itemLink">검색 결과가 없습니다.</h4>
    </c:otherwise>
</c:choose>

<c:if test="${'kmOST' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmOST', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //OST -->