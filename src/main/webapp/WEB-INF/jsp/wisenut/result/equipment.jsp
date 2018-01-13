<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 박물류 -->
<div class="result-block">
    <div class="result-block-tt noline">
        <h4>박물류 (<span class="em weighty">${resultData.kmEQUIPMENTCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmEQUIPMENTCount > 0) || collection eq 'kmEQUIPMENT'}">
    <!-- list -->
    <table border="1" class="data-table medium transform-m">
        <caption>박물류 테이블</caption>
        <colgroup>
            <col style="*">
            <col style="width:17%">
            <col style="width:17%">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">제명</th>
            <th scope="col">구분</th>
            <th scope="col">분류</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="kmEQUIPMENT" items="${resultData.kmEQUIPMENTList }" varStatus="status">
<%--
${kmEQUIPMENT.DOCID}        ==  DOCID    <br/>
${kmEQUIPMENT.DATE}         ==  기본수집날짜    <br/>
${kmEQUIPMENT.TITLE}         ==  박물류명1    <br/>
${kmEQUIPMENT.TITLE_SUB}     ==  박물류명2    <br/>
${kmEQUIPMENT.TITLE_ETC}     ==  박물류명3    <br/>
${kmEQUIPMENT.TITLE_EQUAL}   ==  박물류명5    <br/>
${kmEQUIPMENT.MOVIE_TITLE}  ==  관련영화명    <br/>
${kmEQUIPMENT.DIR}          ==  박물류종류(구분)    <br/>
${kmEQUIPMENT.CLASS}        ==  분류    <br/>
${kmEQUIPMENT.IMAGE}        ==  디지털이미지    <br/>
${kmEQUIPMENT.SEARCH_ETC}   ==  기타검색항목    <br/>
${KMEQUIPMENT.ALIAS}        ==  ALIAS    <br/>
--%>
        <tr class="forPc"> <!-- pc용 리스트입니다. -->
            <td class="title align-left">
                <a href="javascript:void(0);" class="txtBlue">${kmEQUIPMENT.TITLE}
                    <c:if test="${kmEQUIPMENT.TITLE_SUB ne ''}">, ${kmEQUIPMENT.TITLE_SUB}</c:if>
                    <c:if test="${kmEQUIPMENT.TITLE_ETC ne ''}">: ${kmEQUIPMENT.TITLE_ETC}</c:if>
                    <c:if test="${kmEQUIPMENT.TITLE_EQUAL ne ''}">[${kmEQUIPMENT.TITLE_EQUAL}]</c:if>
                </a></td>
            <td>${kmEQUIPMENT.DIR}</td>
            <td>${kmEQUIPMENT.CLASS}</td>
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

<c:if test="${'kmEQUIPMENT' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmEQUIPMENT', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //박물류 -->