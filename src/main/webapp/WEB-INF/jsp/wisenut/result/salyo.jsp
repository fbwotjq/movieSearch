<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 한국영화사료관 -->
<div class="result-block">
    <div class="result-block-tt">
        <h4>한국영화사료관 (<span class="em weighty">${resultData.kmSALYOCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmSALYOCount > 0) || collection eq 'kmSALYO'}">
    <!-- list -->
    <div class="mImage1 type2">
        <ul>
            <c:forEach var="kmSALYO" items="${resultData.kmSALYOList }" varStatus="status">
<%-- 이미지를 찾기 위한 경로가 잘못 되었다 (이미지에 접근이 안될지도.)
${kmSALYO.DOCID}             == DOCID  <br/>
${kmSALYO.DATE}              == DATE  <br/>
${kmSALYO.ARCHIVES_TYPE_CD}  == 구분코드  <br/>
${kmSALYO.CODE01}            == CODE01  <br/>
${kmSALYO.TXT_CODE_NAME}     == TXT_CODE_NAME  <br/>
${kmSALYO.SUBJECT}           == 제목  <br/>
${kmSALYO.TARGET_NAME}       == 성명  <br/>
${kmSALYO.CHERCHEUR}         == 채록연구  <br/>
${kmSALYO.FILE_NAME}         == 파일경로  <br/>
${kmSALYO.SUMMARY_DESC}      == 내용  <br/>
${kmSALYO.BIRTH_DATE}        == 생산일  <br/>
${kmSALYO.DEPTH_01}          == 사료관구분1  <br/>
${kmSALYO.DEPTH_02}          == 사료관구분2  <br/>
${kmSALYO.DEPTH_03}          == alias  <br/>
${kmSALYO.DEPTH_04}          == 구분  <br/>
${kmSALYO.DEPTH_ETC}         == DEPTH_ETC  <br/>
${kmSALYO.alias}             == alias  <br/>
--%>
            <li>
                <a href="###" class="link">
                    <span class="mImg1"><span style="background-image: url('${kmSALYO.FILE_NAME}')"></span></span>
                    <span class="text">
                        <strong class="tit">${kmSALYO.DEPTH_01}</strong>
                        <span class="dir"><em>[${kmSALYO.DEPTH_02}]</em> ${kmSALYO.TARGET_NAME} ${kmSALYO.DEPTH_04}</span>
                        <span class="des2">${kmSALYO.SUMMARY_DESC}</span>
                        <span class="nam"><em>${kmSALYO.CHERCHEUR}</em></span>
                    </span>
                </a>
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

<c:if test="${'kmSALYO' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmSALYO', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //한국영화사료관 -->