<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 영화제 -->
<div class="result-block">
    <div class="result-block-tt">
        <h4>영화제 (<span class="em weighty">${resultData.kmMOVIEJECount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmMOVIEJECount > 0) || collection eq 'kmMOVIEJE'}">
    <!-- list -->
    <div class="mTag1 purple">
        <c:forEach var="kmMOVIEJE" items="${resultData.kmMOVIEJEList }" varStatus="status">
<%--
${kmMOVIEJE.DOCID}         == DOCID   <br/>
${kmMOVIEJE.Date}          == 기본수집날짜   <br/>
${kmMOVIEJE.TITLE}         == 제목   <br/>
${kmMOVIEJE.TITLE_SEARCH}  == 제목검색   <br/>
${kmMOVIEJE.alias}         == alias   <br/>
--%>
        <a href="###">${kmMOVIEJE.TITLE}</a>
        </c:forEach>
    </div>
    <!--//list -->
    </c:when>
    <c:otherwise>
        <h4 class="content_title01 itemLink">검색 결과가 없습니다.</h4>
    </c:otherwise>
</c:choose>
</div>
<!-- //영화제 -->