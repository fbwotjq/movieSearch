<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 영화글 -->
<div class="result-block">
    <div class="result-block-tt">
        <h4>영화글 (<span class="em weighty">${resultData.kmMSTORYCount}</span>)</h4>
    </div>
<c:choose>
    <c:when test="${(collection eq 'ALL' && resultData.kmMSTORYCount > 0) || collection eq 'kmMSTORY'}">
    <!-- list -->
    <div class="mImage1">
        <ul>
        <c:forEach var="kmMSTORY" items="${resultData.kmMSTORYList }" varStatus="status">
<%-- 이미지 , 본문 내용 없고 디자인에 영화글의 구분 1,2 의 디자인이 안 맞음.
${kmMSTORY.DOCID}       == DOCID  <br/>
${kmMSTORY.DATE}        == 등록일  <br/>
${kmMSTORY.WRITER_SEQ}  == WRITER_SEQ  <br/>
${kmMSTORY._SEQ}        == STORY_SEQ  <br/>
${kmMSTORY._DIV_SEQ}    == STORY_DIV_SEQ  <br/>
${kmMSTORY.TITLE01}     == 영화글  <br/>
${kmMSTORY.TITLE02}     == 영화글  <br/>
${kmMSTORY.SUBJECT}     == 제목  <br/>
${kmMSTORY.WRITER}      == 필자  <br/>
${kmMSTORY.alias}       == alias  <br/>
--%>


            <li>
                <span class="mImg1"><span style="background-image: url('../../resources/images/@temp/movie13-01.jpg')"></span></span>
                <span class="text">
                    ${kmMSTORY.TITLE01}<a href="###" class="tit">[${kmMSTORY.TITLE02}]${kmMSTORY.SUBJECT}</a>
                    <span class="des">이미지가 없음. 본문 내용 없음.</span>
                    <span class="nam"><span>by.</span><a href="###">${kmMSTORY.WRITER}</a></span>
                    <span class="dat">${kmMSTORY.DATE}</span>
                </span>
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

<c:if test="${'kmMSTORY' ne collection}">
    <div class="mButton1 mt15">
        <span class="gRight"><a href="javascript:doCollectionSearch('kmMSTORY', 'movieTab');" class="iMore1">더보기</a></span>
    </div>
</c:if>
</div>
<!-- //영화글 -->