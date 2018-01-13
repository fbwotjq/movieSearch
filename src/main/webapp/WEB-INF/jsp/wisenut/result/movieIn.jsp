<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 영화인 -->
<div class="result-block">
    <div class="result-block-tt">
        <h4>영화인 (<span class="em weighty">${resultData.kmMOVIEINCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmMOVIEINCount > 0) || collection eq 'kmMOVIEIN'}">
    <!-- list -->
    <div class="mList7">
        <ul>
        <c:forEach var="kmMOVIEIN" items="${resultData.kmMOVIEINList }" varStatus="status">
            <c:set var="PERSON_FILED" value="${fn:split(kmMOVIEIN.PERSON_FILED,'/')}" />
            <c:set var="FILMOGRAPHY" value="${fn:split(kmMOVIEIN.FILMOGRAPHY,'#*#')}" />

<%--
${kmMOVIEIN.DOCID}               == DOCID  <br/>
${kmMOVIEIN.DATE}                == 기본수집날짜  <br/>
${kmMOVIEIN.NAME_SEARCH}          == 성명  <br/>
${kmMOVIEIN.NAME}                 == 성명  <br/>
${kmMOVIEIN.FILMOGRAPHY_SEARCH}  == 필로그래프_서치  <br/>
${kmMOVIEIN.FILMOGRAPHY}         == 필로그래프  <br/>
${kmMOVIEIN.BIRTH_DATE}          == 생년월일  <br/>
${kmMOVIEIN.DEATH_DATE}          == 사망년일  <br/>
${kmMOVIEIN.PERSON_FILED}        == 분야  <br/>
${kmMOVIEIN.PERSON_AWARD}        == 수상내역  <br/>
${kmMOVIEIN.NOTE}                 == NOTE  <br/>
${kmMOVIEIN.ALIAS}               == ALIAS  <br/>
--%>


            <li>
                <a href="###" class="name">${kmMOVIEIN.NAME}</a>
                <div class="exp">${kmMOVIEIN.BIRTH_DATE} ~ ${kmMOVIEIN.DEATH_DATE},
                <c:forEach var="PERSON" items="${PERSON_FILED}" varStatus="i">
                    <c:choose>
                        <c:when test="${i.last}">
                            ${PERSON}
                        </c:when>
                        <c:otherwise>${PERSON},</c:otherwise>
                    </c:choose>
                </c:forEach>
                </div>
                <div class="pii">
                    <em class="ti">필모그래피</em>
                    <c:forEach var="FILMOGRAPHY" items="${FILMOGRAPHY}" varStatus="i" end="4">
                        <%--${FILMOGRAPHY} |||| ${fn:length(FILMOGRAPHY)}--%>
                        <c:if test="${fn:length(FILMOGRAPHY) > 0}">
                        <c:set var="FILMO" value="${fn:split(FILMOGRAPHY,'^')}" />
                            <%--${FILMO[0]} ||| ${FILMO[1]} AAA ${FILMO[2]}--%>
                        <c:choose>
                            <c:when test="${i.first}">
                                <a href="###">${FILMO[0]}</a>(${FILMO[3]},<a href="###">${FILMO[4]}</a>)
                            </c:when>
                            <c:otherwise>
                                <span class="dot"><a href="###">${FILMO[0]}</a>(${FILMO[3]},<a href="###">${FILMO[4]}</a>)</span>
                            </c:otherwise>
                        </c:choose>
                        </c:if>
                    </c:forEach>
                    <%--좋지 아니한家(좋지 아니한가)^K^08515^2006^정윤철^00002041--%>
                    <%---- 영화, 영화ID, 영화SEQ, 제작년도, 감독이름, 감독ID--%>
                </div>
            </li>
        </c:forEach>
        </ul>
    </div>
    <!--//list -->
    </c:when>
    <c:otherwise>
        <h4 class="content_title01 itemLink">검색 결과가 없습니다.</h4>
    </c:otherwise>
</c:choose>

<c:if test="${'kmMOVIEIN' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmMOVIEIN', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //영화인 -->