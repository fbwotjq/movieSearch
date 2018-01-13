<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 심의서류 -->
<div class="result-block">
    <div class="result-block-tt noline">
        <h4>심의서류 (<span class="em weighty">${resultData.kmCENSORCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmCENSORCount > 0) || collection eq 'kmCENSOR'}">
    <!-- list -->
    <table border="1" class="data-table medium transform-m">
        <caption>심의서류 테이블</caption>
        <colgroup>
            <col style="*">
            <col style="width:8.5%">
            <col style="width:32%">
            <col style="width:17%">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">제명</th>
            <th scope="col">연도</th>
            <th scope="col">제작사</th>
            <th scope="col">심의자료 건수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="kmCENSOR" items="${resultData.kmCENSORList }" varStatus="status">
<%--
${kmCENSOR.DOCID}            DOCID             <br/>
${kmCENSOR.DATE}             기본수집날짜         <br/>
${kmCENSOR.TITLE}            심의서류명             <br/>
${kmCENSOR.MOVIE_TITLE}      관련영화명            <br/>
${kmCENSOR.DIRECTOR_SEARCH}  감독검색                  <br/>
${kmCENSOR.DIRECTOR}         감독                <br/>
${kmCENSOR.AUTHORS}          원작/각본/각색                 <br/>
${kmCENSOR.PROD_COMPY}       제작사               <br/>
${kmCENSOR.CONTENTS}         내용                 <br/>
${kmCENSOR.PROD_YEAR}        제작년도                <br/>
${kmCENSOR.DOC_COUNT}        심의자료건수        <br/>
${kmCENSOR.POS_CLSS}         보존위치   <br/>
${kmCENSOR.alias}            alias  <br/>
 --%>
        <tr>
            <td class="title align-left"><a href="javascript:void(0);" class="txtBlue">${kmCENSOR.TITLE}(${kmCENSOR.DIRECTOR})</a></td>
            <td>${kmCENSOR.PROD_YEAR}</td>
            <td>${kmCENSOR.PROD_COMPY}</td>
            <td>${kmCENSOR.DOC_COUNT}건</td>
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

<c:if test="${'kmCENSOR' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmCENSOR', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //심의서류 -->