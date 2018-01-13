<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 장소 -->
<div class="result-block">
    <div class="result-block-tt">
        <h4>장소 (<span class="em weighty">${resultData.kmPLACECount}</span>)</h4>
    </div>
    <!-- list -->
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmPLACECount > 0) || collection eq 'kmPLACE'}">
    <div class="mTag1 red">
        <c:forEach var="kmPLACE" items="${resultData.kmPLACEList }" varStatus="status">
<%-- 현재 수집된 내용중에 제목 검색 말고는 아무 값도 존재 하지 않음.
${kmPLACE.DOCID}         == DOCID   <br/>
${kmPLACE.Date}          == 기본수집날짜   <br/>
${kmPLACE.TITLE}         == 제목   <br/>
${kmPLACE.TITLE_SEARCH}  == 제목검색   <br/>
${kmPLACE.ALIAS}         == ALIAS   <br/>
--%>
                        <a href="###">${kmPLACE.TITLE}</a>

                        <%--<a href="###">#영화제작주식회사</a>--%>
        </c:forEach>
    </div>
    <!--//list -->
    </c:when>
    <c:otherwise>
        <h4 class="content_title01 itemLink">검색 결과가 없습니다.</h4>
    </c:otherwise>
</c:choose>

</div>
<!-- //장소 -->