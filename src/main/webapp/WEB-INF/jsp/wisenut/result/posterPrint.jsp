<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 포스터 인쇄물 -->
<div class="result-block">
    <div class="result-block-tt noline pb1">
        <h4>포스터 인쇄물 (<span class="em weighty">${resultData.kmPOSTERPRINTCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmPOSTERPRINTCount > 0) || collection eq 'kmPOSTERPRINT'}">
    <!-- list -->
    <table border="1" class="data-table medium transform-m">
        <caption>포스터 인쇄물 테이블</caption>
        <colgroup>
            <col style="*">
            <col style="width:8.5%">
            <col style="width:8.5%">
            <col style="width:8.5%">
            <col style="width:8.5%">
            <col style="width:23%">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">제목</th>
            <th scope="col">연도</th>
            <th scope="col">구분</th>
            <th scope="col">내용상세</th>
            <th scope="col">실물크기</th>
            <th scope="col">내용</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="kmPOSTERPRINT" items="${resultData.kmPOSTERPRINTList }" varStatus="status">
<%--
${kmPOSTERPRINT.DOCID}                == DOCID    <br/>
${kmPOSTERPRINT.DATE}                 == 기본수집날짜    <br/>
${kmPOSTERPRINT.IMAGE_TITLE1}              == 제명1    <br/>
${kmPOSTERPRINT.IMAGE_TITLE2}              == 제명2    <br/>
${kmPOSTERPRINT.IMAGE_TITLE3}              == 제명3    <br/>
${kmPOSTERPRINT.IMAGE_TITLE4}              == 제명4    <br/>
${kmPOSTERPRINT.MOVIE_TITLE}          == 영화명    <br/>
${kmPOSTERPRINT.MOVIE_CODE}           == 영화코드    <br/>
${kmPOSTERPRINT.PERSON_NM}            == 인물명    <br/>
${kmPOSTERPRINT.PERSON_CODE}          == 인물코드    <br/>
${kmPOSTERPRINT.FESTIVAL_TITLE}       == 영화제명    <br/>
${kmPOSTERPRINT.FESTIVAL_CODE}        == 영화제코드    <br/>
${kmPOSTERPRINT.FESTIVAL_AWARD_CODE}  == 영화제수상코드    <br/>
${kmPOSTERPRINT.TC_TITLE}             == 기타명    <br/>
${kmPOSTERPRINT.OTHER_ID}             == ETC_CODE    <br/>
${kmPOSTERPRINT.CONTENS_CLSS}         == 내용구분    <br/>
${kmPOSTERPRINT.CONTENS_CLSS_TEXT}    == 내용구분텍스트    <br/>
${kmPOSTERPRINT.MATERIAL_CLSS}        == 자료유형    <br/>
${kmPOSTERPRINT.FORM}                 == 형태    <br/>
${kmPOSTERPRINT.REL_PERSON_NM1}       == 인명    <br/>
${kmPOSTERPRINT.REL_PERSON_NM2}       == 인명    <br/>
${kmPOSTERPRINT.NATIONAL_CLSS}        == 국가구분    <br/>
${kmPOSTERPRINT.PROD_YEAR}            == 제작년도    <br/>
${kmPOSTERPRINT.HAVEFILE}             == 디지털이미지    <br/>
${kmPOSTERPRINT.CONTENS_DETAIL_CLSS}  == 내용상세구분    <br/>
${kmPOSTERPRINT.SIZE}                 == 실물크기    <br/>
${kmPOSTERPRINT.CONTENTS}             == 내용    <br/>
${kmPOSTERPRINT.FILE_DIR}             == 이미지경로    <br/>
${kmPOSTERPRINT.FILE_NM}              == 이미지파일명    <br/>
${kmPOSTERPRINT.PROHIBIT_19}          == 19금여부    <br/>
${kmPOSTERPRINT.ALIAS}                == ALIAS    <br/>
--%>
        <tr>
            <td class="title align-left">
                <a href="javascript:void(0);"><em class="txtPurple">[${kmPOSTERPRINT.CONTENS_CLSS_TEXT}]</em>${kmPOSTERPRINT.IMAGE_TITLE1}
                    <c:if test="${kmPOSTERPRINT.IMAGE_TITLE2 ne ''}">, ${kmPOSTERPRINT.IMAGE_TITLE2}</c:if>
                    <c:if test="${kmPOSTERPRINT.IMAGE_TITLE3 ne ''}">: ${kmPOSTERPRINT.IMAGE_TITLE3}</c:if>
                    <c:if test="${kmPOSTERPRINT.IMAGE_TITLE4 ne ''}">[${kmPOSTERPRINT.IMAGE_TITLE4}]</c:if></a></td>
            <td>${kmPOSTERPRINT.PROD_YEAR}</td>
            <td>포스터</td>
            <td></td>
            <td>${kmPOSTERPRINT.SIZE}</td>
            <td>${kmPOSTERPRINT.CONTENTS}</td>
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

<c:if test="${'kmPOSTERPRINT' ne collection}">
    <div class="mButton1">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmPOSTERPRINT', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //포스터 인쇄물 -->