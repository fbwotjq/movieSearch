<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 스틸 파일 -->
<div class="result-block">
    <div class="result-block-tt noline pb1">
        <h4>스틸 파일 (<span class="em weighty">${resultData.kmSTILLFILECount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmSTILLFILECount > 0) || collection eq 'kmSTILLFILE'}">
    <!-- list -->
    <div class="mList8 type3">
        <ul>
        <c:forEach var="kmSTILLFILE" items="${resultData.kmSTILLFILEList }" varStatus="status">

            <%--
http://file.koreafilm.or.kr/thm/02/${kmPOSTERFILE.FILE_DIR}/tn_${kmPOSTERFILE.FILE_NM}
이미지 파일명 FILE_NM 이 뭔가 이상하다 _01 이 붙으면 안되는 거 같음.             

${kmSTILLFILE.DOCID}                == DOCID    <br/>
${kmSTILLFILE.DATE}                 == 기본수집날짜    <br/>
${kmSTILLFILE._TITLE1}              == 제명1    <br/>
${kmSTILLFILE._TITLE2}              == 제명2    <br/>
${kmSTILLFILE._TITLE3}              == 제명3    <br/>
${kmSTILLFILE._TITLE4}              == 제명4    <br/>
${kmSTILLFILE.MOVIE_TITLE}          == 영화명    <br/>
${kmSTILLFILE.MOVIE_CODE}           == 영화코드    <br/>
${kmSTILLFILE.PERSON_NM}            == 인물명    <br/>
${kmSTILLFILE.PERSON_CODE}          == 인물코드    <br/>
${kmSTILLFILE.FESTIVAL_TITLE}       == 영화제명    <br/>
${kmSTILLFILE.FESTIVAL_CODE}        == 영화제코드    <br/>
${kmSTILLFILE.FESTIVAL_AWARD_CODE}  == 영화제수상코드    <br/>
${kmSTILLFILE.TC_TITLE}             == 기타명    <br/>
${kmSTILLFILE.OTHER_ID}             == ETC_CODE    <br/>
${kmSTILLFILE.CONTENS_CLSS}         == 내용구분    <br/>
${kmSTILLFILE.CONTENS_CLSS_TEXT}    == 내용구분텍스트    <br/>
${kmSTILLFILE.MATERIAL_CLSS}        == 자료유형    <br/>
${kmSTILLFILE.FORM}                 == 형태    <br/>
${kmSTILLFILE.REL_PERSON_NM1}       == 인명    <br/>
${kmSTILLFILE.REL_PERSON_NM2}       == 인명    <br/>
${kmSTILLFILE.NATIONAL_CLSS}        == 국가구분    <br/>
${kmSTILLFILE.PROD_YEAR}            == 제작년도    <br/>
${kmSTILLFILE.HAVEFILE}             == 디지털이미지    <br/>
${kmSTILLFILE.CONTENS_DETAIL_CLSS}  == 내용상세구분    <br/>
${kmSTILLFILE.SIZE}                 == 실물크기    <br/>
${kmSTILLFILE.CONTENTS}             == 내용    <br/>
${kmSTILLFILE.FILE_DIR}             == 이미지경로    <br/>
${kmSTILLFILE.FILE_NM}              == 이미지파일명    <br/>
${kmSTILLFILE.PROHIBIT_19}          == 19금여부    <br/>
${kmSTILLFILE.ALIAS}                == ALIAS    <br/>
- contens_clss = 1 또는 4 또는 5인 경우,
      -> ‘file.koreafilm.or.kr/still/copy/’ + file_dir + file_nm
    - contens_clss = 3
      -> ‘file.koreafilm.or.kr/person/’ + file_dir + file_nm

--%>
            <li>
                <a href="###">
                    <span class="mImg1">
                        <c:choose>
                            <c:when test="${kmSTILLFILE.CONTENS_CLSS eq '3'}">
                                <span style="background-image: url('http://file.koreafilm.or.kr/person/${kmSTILLFILE.FILE_DIR}/tn_${kmSTILLFILE.FILE_NM}')"></span>
                            </c:when>
                            <c:otherwise>
                                <span style="background-image: url('http://file.koreafilm.or.kr/still/copy/${kmSTILLFILE.FILE_DIR}/tn_${kmSTILLFILE.FILE_NM}')"></span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                    <span class="text">${kmSTILLFILE.IMAGE_TITLE1}
                        <c:if test="${kmSTILLFILE.IMAGE_TITLE2 ne ''}">, ${kmSTILLFILE.IMAGE_TITLE2}</c:if>
                        <c:if test="${kmSTILLFILE.IMAGE_TITLE3 ne ''}">: ${kmSTILLFILE.IMAGE_TITLE3}</c:if>
                        <c:if test="${kmSTILLFILE.IMAGE_TITLE4 ne ''}">[${kmSTILLFILE.IMAGE_TITLE4}]</c:if>
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

<c:if test="${'kmSTILLFILE' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmSTILLFILE', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //스틸 파일 -->