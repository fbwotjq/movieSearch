<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 필름/D시네마 -->
<div class="result-block pt1">
    <div class="result-block-tt noline">
        <h4>필름/D시네마 (<span class="em weighty">${resultData.kmDCFILMCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmDCFILMCount > 0) || collection eq 'kmDCFILM'}">
    <!-- list -->
    <table border="1" class="data-table medium transform-m">
        <caption>필름/D시네마 테이블</caption>
        <colgroup>
            <col style="*">
            <col style="width:8.5%">
            <col style="width:8.5%">
            <col style="width:32%">
            <col style="width:8.5%">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">제명 </th>
            <th scope="col">연도</th>
            <th scope="col" colspan="2">구분</th>
            <th scope="col">수량</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="kmDCFILM" items="${resultData.kmDCFILMList }" varStatus="status">
<%--

${kmDCFILM.DOCID}               ==  DOCID  <br/>
${kmDCFILM.DATE}                ==  기본날짜  <br/>
${kmDCFILM.PATTEN_CLSS}         ==  유형  <br/>
${kmDCFILM.PATTEN_CLSS_SEARCH}  ==  유형 검색  <br/>
${kmDCFILM.TITLE}               ==  제명  <br/>
${kmDCFILM.TITLE_SEARCH}        ==  영화명  <br/>
${kmDCFILM.DIRECTOR}            ==  감독  <br/>
${kmDCFILM.SUBDIRECTOR}         ==  서브감독  <br/>
${kmDCFILM.ACTOR}               ==  출연(성우)  <br/>
${kmDCFILM.STAFF}               ==  스탭  <br/>
${kmDCFILM.COMPANY}             ==  제작사/투자배급사  <br/>
${kmDCFILM.KEYWORD}             ==  키워드  <br/>
${kmDCFILM.PLOT}                ==  줄거리  <br/>
${kmDCFILM.NATIONAL_CLSS}       ==  국가구분  <br/>
${kmDCFILM.PROD_YEAR}           ==  제작년도  <br/>
${kmDCFILM.TYPE_CLSS}           ==  장르  <br/>
${kmDCFILM.CNS_CLSS}        ==  영화심의여부  <br/>
${kmDCFILM.DB}                  ==  자료구분  <br/>
${kmDCFILM.EDIUM}              ==  매체정보_구분  <br/>
${kmDCFILM.SPEC}                ==  메체정보_규격  <br/>
${kmDCFILM.CAP_CLSS}            ==  매체정보_자막  <br/>
${kmDCFILM.AMOUNT}              ==  수량  <br/>
${kmDCFILM.ALIAS}               ==  ALIAS  <br/>
--%>
        <tr>
            <td class="title align-left"><a href="javascript:void(0);" class="txtBlue">${kmDCFILM.TITLE}</a></td>
            <td>${kmDCFILM.PROD_YEAR}</td>
            <td>${kmDCFILM.DB}</td>
            <td>${kmDCFILM.COMPANY}</td>
            <td>${kmDCFILM.AMOUNT}</td>
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

<c:if test="${'kmDCFILM' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmDCFILM', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
<!-- //필름/D시네마 -->