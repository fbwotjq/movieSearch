<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 행사/사건 -->
<div class="result-block">
    <div class="result-block-tt">
        <h4>행사/사건 (<span class="em weighty">${resultData.kmEVENTCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmEVENTCount > 0) || collection eq 'kmEVENT'}">
    <!-- list -->
    <div class="mTag1">
        <c:forEach var="kmEVENT" items="${resultData.kmEVENTList }" varStatus="status">

<%-- 현재 수집된 내용중에 제목 검색 말고는 아무 값도 존재 하지 않음.
제목이나 기타검색 항목 존재하지 않음.
${kmEVENT.DOCID}       == DOCID  <br/>
${kmEVENT.Date}        == 기본수집날짜  <br/>
${kmEVENT.TITLE}        == 제목  <br/>
${kmEVENT.TITLE_SEARCH} == 제목검색  <br/>
${kmEVENT.SEARCH_ETC}  == 기타검색항목  <br/>
${kmEVENT.ALIAS}       == ALIAS  <br/>
--%>

        <a href="###">${kmEVENT.TITLE}</a>
        </c:forEach>
    </div>
    <!--//list -->
    </c:when>
    <c:otherwise>
        <h4 class="content_title01 itemLink">검색 결과가 없습니다.</h4>
    </c:otherwise>
</c:choose>
</div>
<!-- //행사/사건 -->