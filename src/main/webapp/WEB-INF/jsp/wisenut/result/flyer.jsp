<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 전단/보도자료/기타자료 -->
<div class="result-block">
    <div class="result-block-tt noline">
        <h4>전단/보도자료/기타자료 (<span class="em weighty">${resultData.kmFLYERCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmFLYERCount > 0) || collection eq 'kmFLYER'}">
    <!-- list -->
    <table border="1" class="data-table medium transform-m">
        <caption>전단/보도자료/기타자료 테이블</caption>
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
            <th scope="col">연도</th>
            <th scope="col">분류</th>
            <th scope="col">구분</th>
            <th scope="col">형태</th>
            <th scope="col">수량</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="kmFLYER" items="${resultData.kmFLYERList }" varStatus="status">
<%--
${kmFLYER.DOCID}         ==  DOCID    <br/>
${kmFLYER.DATE}          ==  기본수집날짜    <br/>
${kmFLYER.HDIV1}         ==  구분1    <br/>
${kmFLYER.HDIV2}         ==  구분2    <br/>
${kmFLYER.HDIV3}         ==  구분3    <br/>
${kmFLYER.HTITLE1}       ==  제명1    <br/>
${kmFLYER.HTITLE2}       ==  제명2    <br/>
${kmFLYER.HTITLE3}       ==  제명3    <br/>
${kmFLYER.HTITLE4}       ==  제명4    <br/>
${kmFLYER.TITLE_SEARCH}  ==  제명검색    <br/>
${kmFLYER.PRID_YEAR}     ==  연도    <br/>
${kmFLYER.KIND_CLASS}    ==  형태    <br/>
${kmFLYER.COUNT}         ==  수량    <br/>
${kmFLYER.SEARCH_ETC}    ==  기타검색항목    <br/>
${kmFLYER.alias}         ==  alias    <br/>
--%>
        <tr>
            <td class="title align-left">
                <a href="javascript:void(0);" class="txtBlue">${kmFLYER.HTITLE1}
                    <c:if test="${kmFLYER.HTITLE2 ne ''}">, ${kmFLYER.HTITLE2}</c:if>
                    <c:if test="${kmFLYER.HTITLE3 ne ''}">: ${kmFLYER.HTITLE3}</c:if>
                    <c:if test="${kmFLYER.HTITLE4 ne ''}">[${kmFLYER.HTITLE4}]</c:if>
                </a></td>
            <td>${kmFLYER.PRID_YEAR}</td>
            <td>${kmFLYER.HDIV2}
                <c:if test="${kmFLYER.HDIV2 ne kmFLYER.HDIV3}">(${kmFLYER.HDIV3})</c:if>
            </td>
            <td>${kmFLYER.HDIV1}</td>
            <td>${kmFLYER.KIND_CLASS}</td>
            <td>${kmFLYER.COUNT}</td>
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

<c:if test="${'kmFLYER' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmFLYER', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //전단/보도자료/기타자료 -->