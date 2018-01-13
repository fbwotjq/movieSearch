<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 도서/논문 -->
<div class="result-block">
    <div class="result-block-tt noline">
        <h4>도서/논문 (<span class="em weighty">${resultData.kmBOOKCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmBOOKCount > 0) || collection eq 'kmBOOK'}">
    <!-- list -->
    <table border="1" class="data-table medium transform-m">
        <caption>도서/논문 테이블</caption>
        <colgroup>
            <col style="*">
            <col style="width:7%">
            <col style="width:8.5%">
            <col style="width:13%">
            <col style="width:8.5%">
            <col style="width:8.5%">
            <col style="width:8.5%">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">제명</th>
            <th scope="col">구분</th>
            <th scope="col">저자정보</th>
            <th scope="col">발행처</th>
            <th scope="col">연도</th>
            <th scope="col">페이지</th>
            <th scope="col">초록/목차여부</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="kmBOOK" items="${resultData.kmBOOKList }" varStatus="status">
<%--
${kmBOOK.DOCID}          == DOCID   <br/>
${kmBOOK.Date}           == Date   <br/>
${kmBOOK.DB_CLSS}        == 구분   <br/>
${kmBOOK.DEGREE_CLASS}   == 학위구분   <br/>
${kmBOOK.TITLE_SEARCH}   == 도서/눈문명검색   <br/>
${kmBOOK.BOOK_NM}        == 도서/논문명1   <br/>
${kmBOOK.TITLE_SUB}      == 도서/논문명2   <br/>
${kmBOOK.TITLE_ETC}      == 도서/논문명3   <br/>
${kmBOOK.TITLE_EQUAL}    == 도서/논문명4   <br/>
${kmBOOK.WRITER}         == 저자   <br/>
${kmBOOK.TRANSLATOR}     == 역자   <br/>
${kmBOOK.PUB_PLACE}      == 발행처   <br/>
${kmBOOK.NATIONAL_CLSS}  == 발행국가   <br/>
${kmBOOK.PUB_YEAR}       == 발행년도   <br/>
${kmBOOK.PAGE}           == 페이지   <br/>
${kmBOOK.TOC}            == 목차   <br/>
${kmBOOK.ABSTRACT}       == 초록   <br/>
${kmBOOK.KEYWORDS}       == 키워드   <br/>
${kmBOOK.POS_CLSS}       == 보존위치   <br/>
${KMBOOK.ALIAS}          == ALIAS   <br/>
--%>
        <tr>
            <td class="title align-left">
                <a href="javascript:void(0);" class="txtBlue">
                    ${kmBOOK.BOOK_NM}
                    <c:if test="${kmBOOK.TITLE_SUB ne ''}">, ${kmBOOK.TITLE_SUB}</c:if>
                    <c:if test="${kmBOOK.TITLE_ETC ne ''}">: ${kmBOOK.TITLE_ETC}</c:if>
                    <c:if test="${kmBOOK.TITLE_EQUAL ne ''}">[${kmBOOK.TITLE_EQUAL}]</c:if>
                </a></td>
            <td>${kmBOOK.DB_CLSS}<c:if test="${kmBOOK.DEGREE_CLASS ne ''}"> (${kmBOOK.DEGREE_CLASS})</c:if></td>
            <td>저자 : ${kmBOOK.WRITER} 역자 : ${kmBOOK.TRANSLATOR}</td>
            <td>${kmBOOK.PUB_PLACE}</td>
            <td>${kmBOOK.PUB_YEAR}</td>
            <td>${kmBOOK.PAGE}</td>
            <td>
                <c:if test="${kmBOOK.TOC ne ''}">목차</c:if>
                <c:if test="${kmBOOK.ABSTRACT ne ''}">초록</c:if>
            </td>
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

<c:if test="${'kmBOOK' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmBOOK', 'sojangTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //도서/논문 -->