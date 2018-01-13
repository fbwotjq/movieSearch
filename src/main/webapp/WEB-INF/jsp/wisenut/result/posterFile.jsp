<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 포스터 파일 -->
<div class="result-block">
    <div class="result-block-tt noline pb1">
        <h4>포스터 파일 (<span class="em weighty">${resultData.kmPOSTERFILECount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmPOSTERFILECount > 0) || collection eq 'kmPOSTERFILE'}">
    <!-- list -->
    <div class="mList8 type3">
        <ul>
        <c:forEach var="kmPOSTERFILE" items="${resultData.kmPOSTERFILEList }" varStatus="status">

<%--
http://file.koreafilm.or.kr/thm/02/${kmPOSTERFILE.FILE_DIR}/tn_${kmPOSTERFILE.FILE_NM}
이미지 파일명 FILE_NM 이 뭔가 이상하다 _01 이 붙으면 안되는 거 같음.

${kmPOSTERFILE.DOCID}                == DOCID    <br/>
${kmPOSTERFILE.DATE}                 == 기본수집날짜    <br/>
${kmPOSTERFILE.IMAGE_TITLE1}              == 제명1    <br/>
${kmPOSTERFILE.IMAGE_TITLE2}              == 제명2    <br/>
${kmPOSTERFILE.IMAGE_TITLE3}              == 제명3    <br/>
${kmPOSTERFILE.IMAGE_TITLE4}              == 제명4    <br/>
${kmPOSTERFILE.MOVIE_TITLE}          == 영화명    <br/>
${kmPOSTERFILE.MOVIE_CODE}           == 영화코드    <br/>
${kmPOSTERFILE.PERSON_NM}            == 인물명    <br/>
${kmPOSTERFILE.PERSON_CODE}          == 인물코드    <br/>
${kmPOSTERFILE.FESTIVAL_TITLE}       == 영화제명    <br/>
${kmPOSTERFILE.FESTIVAL_CODE}        == 영화제코드    <br/>
${kmPOSTERFILE.FESTIVAL_AWARD_CODE}  == 영화제수상코드    <br/>
${kmPOSTERFILE.TC_TITLE}             == 기타명    <br/>
${kmPOSTERFILE.OTHER_ID}             == ETC_CODE    <br/>
${kmPOSTERFILE.CONTENS_CLSS}         == 내용구분    <br/>
${kmPOSTERFILE.CONTENS_CLSS_TEXT}    == 내용구분텍스트    <br/>
${kmPOSTERFILE.MATERIAL_CLSS}        == 자료유형    <br/>
${kmPOSTERFILE.FORM}                 == 형태    <br/>
${kmPOSTERFILE.REL_PERSON_NM1}       == 인명    <br/>
${kmPOSTERFILE.REL_PERSON_NM2}       == 인명    <br/>
${kmPOSTERFILE.NATIONAL_CLSS}        == 국가구분    <br/>
${kmPOSTERFILE.PROD_YEAR}            == 제작년도    <br/>
${kmPOSTERFILE.HAVEFILE}             == 디지털이미지    <br/>
${kmPOSTERFILE.CONTENS_DETAIL_CLSS}  == 내용상세구분    <br/>
${kmPOSTERFILE.SIZE}                 == 실물크기    <br/>
${kmPOSTERFILE.CONTENTS}             == 내용    <br/>
${kmPOSTERFILE.FILE_DIR}             == 이미지경로    <br/>
${kmPOSTERFILE.FILE_NM}              == 이미지파일명    <br/>
${kmPOSTERFILE.PROHIBIT_19}          == 19금여부    <br/>
${kmPOSTERFILE.ALIAS}                == ALIAS    <br/>
--%>
            <li>
                <a href="###">
                    <span class="mImg1"><span style="background-image: url('http://file.koreafilm.or.kr/thm/02/${kmPOSTERFILE.FILE_DIR}/tn_${kmPOSTERFILE.FILE_NM}')"></span></span>
                    <span class="text">${kmPOSTERFILE.IMAGE_TITLE1}
                        <c:if test="${kmPOSTERFILE.IMAGE_TITLE2 ne ''}">, ${kmPOSTERFILE.IMAGE_TITLE2}</c:if>
                        <c:if test="${kmPOSTERFILE.IMAGE_TITLE3 ne ''}">: ${kmPOSTERFILE.IMAGE_TITLE3}</c:if>
                        <c:if test="${kmPOSTERFILE.IMAGE_TITLE4 ne ''}">[${kmPOSTERFILE.IMAGE_TITLE4}]</c:if>
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

<c:if test="${'kmPOSTERFILE' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmPOSTERFILE', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //포스터 파일 -->