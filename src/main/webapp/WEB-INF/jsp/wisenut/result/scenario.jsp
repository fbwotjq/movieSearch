<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 시나리오/콘티 -->
<div class="result-block">
    <div class="result-block-tt noline">
        <h4>시나리오/콘티 (<span class="em weighty">${resultData.kmSCENARIOCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmSCENARIOCount > 0) || collection eq 'kmSCENARIO'}">
    <!-- list -->
    <table border="1" class="data-table medium transform-m">
        <caption>시나리오&middot;콘티 테이블</caption>
        <colgroup>
            <col style="*">
            <col style="width:8.5%">
            <col style="width:8.5%">
            <col style="width:15.5%">
            <col style="width:15.5%">
            <col style="width:8.5%">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">제명</th>
            <th scope="col">연도</th>
            <th scope="col">분류</th>
            <th scope="col">구분</th>
            <th scope="col">형태</th>
            <th scope="col">수량</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="kmSCENARIO" items="${resultData.kmSCENARIOList }" varStatus="status">
<%--

${kmSCENARIO.DOCID}          == DOCID       <br/>
${kmSCENARIO.DATE}           == 기본수집날짜       <br/>
${kmSCENARIO.TITLE}          == 시나리오명명1       <br/>
${kmSCENARIO.TITLE_SUB}      == 시나리오명명2       <br/>
${kmSCENARIO.TITLE_ETC}      == 시나리오명명3       <br/>
${kmSCENARIO.TITLE_EQUAL}    == 시나리오명명4       <br/>
${kmSCENARIO.M_TITLE}        == 관련영화명       <br/>
${kmSCENARIO.DIRECTOR}       == 감독       <br/>
${kmSCENARIO.AUTHOR}         == 원작/각본/각색       <br/>
${kmSCENARIO.CONTENTS_CLSS}  == 시나리오종류       <br/>
${kmSCENARIO.PROD_YEAR}      == 제작년도       <br/>
${kmSCENARIO.KIND_CLSS}      == 구분       <br/>
${kmSCENARIO.FORM_CLSS}      == 형태       <br/>
${kmSCENARIO.POS_CLSS}       == 보존위치       <br/>
${kmSCENARIO.COUNT}          == 수량       <br/>
${KMSCENARIO.ALIAS}          == ALIAS       <br/>
--%>
        <tr>
            <td class="title align-left"><a href="javascript:void(0);" class="txtBlue">${kmSCENARIO.TITLE}</a></td>
            <td>${kmSCENARIO.PROD_YEAR}</td>
            <td>${kmSCENARIO.CONTENTS_CLSS}</td>
            <td>${kmSCENARIO.KIND_CLSS}</td>
            <td>${kmSCENARIO.FORM_CLSS}</td>
            <td>${kmSCENARIO.COUNT}</td>
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

<c:if test="${'kmSCENARIO' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmSCENARIO', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //시나리오&middot;콘티 -->