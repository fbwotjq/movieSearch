<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 스틸 인쇄물 -->
<div class="result-block">
<div class="result-block-tt noline pb1">
    <h4>포스터 인쇄물 (<span class="em weighty">${resultData.kmSTILLPRINTCount}</span>)</h4>
</div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmSTILLPRINTCount > 0) || collection eq 'kmSTILLPRINT'}">
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
        <c:forEach var="kmSTILLPRINT" items="${resultData.kmSTILLPRINTList }" varStatus="status">
<%--
${kmSTILLPRINT.DOCID}                == DOCID    <br/>
${kmSTILLPRINT.DATE}                 == 기본수집날짜    <br/>
${kmSTILLPRINT._TITLE1}              == 제명1    <br/>
${kmSTILLPRINT._TITLE2}              == 제명2    <br/>
${kmSTILLPRINT._TITLE3}              == 제명3    <br/>
${kmSTILLPRINT._TITLE4}              == 제명4    <br/>
${kmSTILLPRINT.MOVIE_TITLE}          == 영화명    <br/>
${kmSTILLPRINT.MOVIE_CODE}           == 영화코드    <br/>
${kmSTILLPRINT.PERSON_NM}            == 인물명    <br/>
${kmSTILLPRINT.PERSON_CODE}          == 인물코드    <br/>
${kmSTILLPRINT.FESTIVAL_TITLE}       == 영화제명    <br/>
${kmSTILLPRINT.FESTIVAL_CODE}        == 영화제코드    <br/>
${kmSTILLPRINT.FESTIVAL_AWARD_CODE}  == 영화제수상코드    <br/>
${kmSTILLPRINT.TC_TITLE}             == 기타명    <br/>
${kmSTILLPRINT.OTHER_ID}             == ETC_CODE    <br/>
${kmSTILLPRINT.CONTENS_CLSS}         == 내용구분    <br/>
${kmSTILLPRINT.CONTENS_CLSS_TEXT}    == 내용구분텍스트    <br/>
${kmSTILLPRINT.MATERIAL_CLSS}        == 자료유형    <br/>
${kmSTILLPRINT.FORM}                 == 형태    <br/>
${kmSTILLPRINT.REL_PERSON_NM1}       == 인명    <br/>
${kmSTILLPRINT.REL_PERSON_NM2}       == 인명    <br/>
${kmSTILLPRINT.NATIONAL_CLSS}        == 국가구분    <br/>
${kmSTILLPRINT.PROD_YEAR}            == 제작년도    <br/>
${kmSTILLPRINT.HAVEFILE}             == 디지털이미지    <br/>
${kmSTILLPRINT.CONTENS_DETAIL_CLSS}  == 내용상세구분    <br/>
${kmSTILLPRINT.SIZE}                 == 실물크기    <br/>
${kmSTILLPRINT.CONTENTS}             == 내용    <br/>
${kmSTILLPRINT.FILE_DIR}             == 이미지경로    <br/>
${kmSTILLPRINT.FILE_NM}              == 이미지파일명    <br/>
${kmSTILLPRINT.PROHIBIT_19}          == 19금여부    <br/>
${kmSTILLPRINT.alias}                == alias    <br/>
--%>
        <tr>
            <td class="title align-left">
                <a href="javascript:void(0);"><em class="txtPurple">[${kmSTILLPRINT.CONTENS_CLSS_TEXT}]</em>${kmSTILLPRINT.IMAGE_TITLE1}
                    <c:if test="${kmSTILLPRINT.IMAGE_TITLE2 ne ''}">, ${kmSTILLPRINT.IMAGE_TITLE2}</c:if>
                    <c:if test="${kmSTILLPRINT.IMAGE_TITLE3 ne ''}">: ${kmSTILLPRINT.IMAGE_TITLE3}</c:if>
                    <c:if test="${kmSTILLPRINT.IMAGE_TITLE4 ne ''}">[${kmSTILLPRINT.IMAGE_TITLE4}]</c:if></a></td>
            <td>${kmSTILLPRINT.PROD_YEAR}</td>
            <td>${kmSTILLPRINT.CONTENS_CLSS_TEXT}</td>
            <td>${kmSTILLPRINT.CONTENS_DETAIL_CLSS}</td>
            <td>${kmSTILLPRINT.SIZE}</td>
            <td>${kmSTILLPRINT.CONTENTS}</td>
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

<c:if test="${'kmSTILLPRINT' ne collection}">
    <div class="mButton1">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmSTILLPRINT', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //스틸 인쇄물 -->